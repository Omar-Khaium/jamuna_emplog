import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emplog/model/db/attendance.dart';
import 'package:emplog/model/outlet.dart';
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

class CheckIn extends StatelessWidget {
  final Function onSubmit;

  CheckIn({@required this.onSubmit});

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
          title: Text("Check In", style: TextStyles.title(context: context, color: themeProvider.accentColor)),
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
        body: attendanceProvider.getAllOutlets().isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.closed_caption_disabled_outlined, size: 72),
                    SizedBox(height: 24),
                    Text("No outlet found inside ${attendanceProvider.distanceFilter.toStringAsFixed(2)}m"),
                  ],
                ),
              )
            : ListView.builder(
                physics: ScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Outlet outlet = attendanceProvider.getAllOutlets()[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(48),
                      child: CachedNetworkImage(
                        imageUrl: outlet.logo,
                        fit: BoxFit.cover,
                        width: 48,
                        height: 48,
                        placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.store, color: themeProvider.hintColor),
                      ),
                    ),
                    title: Text(outlet.branch, style: TextStyles.body(context: context, color: themeProvider.textColor)),
                    subtitle: Text(outlet.branchType, style: TextStyles.caption(context: context, color: themeProvider.hintColor)),
                    trailing: Text(prettyDistance(calculateDistance(outlet.latitude, outlet.longitude, fakeLatitude, fakeLongitude)),
                        style: TextStyles.caption(context: context, color: themeProvider.hintColor)),
                    onTap: () async {
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
                            location: outlet.branch,
                            event: "In",
                            duration: "",
                            picture: localFile.path);

                        attendanceProvider.checkIn(attendance, internetProvider.notConnected, outlet.guid);
                        Navigator.of(context).pop();
                        onSubmit();
                      }
                    },
                  );
                },
                itemCount: attendanceProvider.getAllOutlets().length,
              ),
      ),
    );
  }
}
