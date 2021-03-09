import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emplog/model/db/attendance.dart';
import 'package:emplog/model/shop.dart';
import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_internet.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/fake_database.dart';
import 'package:emplog/utils/helper.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class VisitShop extends StatelessWidget {
  final Function onSubmit;

  VisitShop({@required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final internetProvider = Provider.of<InternetProvider>(context);
    attendanceProvider.trackLocation();
    internetProvider.listen();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: themeProvider.backgroundColor,
          title: Text("Visit shop", style: TextStyles.title(context: context, color: themeProvider.accentColor)),
          centerTitle: false,
          automaticallyImplyLeading: true,
          brightness: Brightness.light,
          elevation: 0,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 12, top: 12, bottom: 12),
              child: ElevatedButton(
                  onPressed: () {
                    attendanceProvider.toggleFakeLocation();
                  },
                  style: ElevatedButton.styleFrom(primary: themeProvider.accentColor.withOpacity(.05)),
                  child: Text(
                    "Use ${attendanceProvider.useFakeLocation ? "current" : "mock"} location",
                    style: TextStyles.caption(context: context, color: themeProvider.accentColor),
                  )),
            )
          ],
        ),
        body: attendanceProvider.getAllShops().isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.closed_caption_disabled_outlined, size: 72),
                    SizedBox(height: 24),
                    Text("No shop found inside ${attendanceProvider.distanceFilter.toStringAsFixed(2)}m"),
                  ],
                ),
              )
            : ListView.builder(
                physics: ScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Shop shop = attendanceProvider.getAllShops()[index];
                  return ListTile(
                    tileColor: attendanceProvider.didVisitedThisShopToday(shop.name) ? themeProvider.tagColor : themeProvider.backgroundColor,
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: themeProvider.accentColor, width: attendanceProvider.didVisitedThisShopToday(shop.name) ? 2 : 0),
                          borderRadius: BorderRadius.circular(40)),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: CachedNetworkImage(
                                imageUrl: shop.logo,
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
                                placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.store, color: themeProvider.hintColor),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: attendanceProvider.didVisitedThisShopToday(shop.name),
                            child: Positioned(
                              child: CircleAvatar(child: Icon(Icons.check, color: themeProvider.backgroundColor, size: 12), backgroundColor: themeProvider.accentColor, radius: 8),
                              bottom: -4,
                              right: -4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    title: Text(shop.name, style: TextStyles.body(context: context, color: themeProvider.textColor)),
                    subtitle: Text(shop.contactPerson, style: TextStyles.caption(context: context, color: themeProvider.hintColor)),
                    trailing: Text(prettyDistance(calculateDistance(shop.latitude, shop.longitude, fakeLatitude, fakeLongitude)),
                        style: TextStyles.caption(context: context, color: themeProvider.hintColor)),
                    onTap: () async {
                      if (attendanceProvider.didVisitedThisShopToday(shop.name)) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Warning", style: TextStyles.subTitle(context: context, color: themeProvider.textColor)),
                                  content: Text("This shop is already visited by you at ${DateFormat("hh:mma").format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(attendanceProvider
                                          .lastShopVisitTime(shop.name)))}.", style: 
                                  TextStyles.body(context: context, color: themeProvider
                                      .textColor)),
                                ));
                      } else {
                        ImagePicker picker = ImagePicker();
                        PickedFile file = await picker.getImage(source: ImageSource.camera);
                        Directory directory = await getApplicationDocumentsDirectory();
                        File localFile = File("${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg");
                        await localFile.writeAsBytes(await file.readAsBytes(), flush: true);
                        if (localFile != null) {
                          Attendance attendance = Attendance(
                              guid: DateTime.now().toIso8601String(),
                              dateTime: DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
                              latitude: attendanceProvider.currentLocation.latitude,
                              longitude: attendanceProvider.currentLocation.longitude,
                              location: shop.name,
                              event: "ShopVisit",
                              duration: "",
                              picture: localFile.path);

                          attendanceProvider.visitShop(attendance, internetProvider.notConnected, shop.guid);
                          Navigator.of(context).pop();
                          onSubmit();
                        }
                      }
                    },
                  );
                },
                itemCount: attendanceProvider.getAllShops().length,
              ),
      ),
    );
  }
}
