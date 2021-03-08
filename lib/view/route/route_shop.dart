import 'dart:io';
import 'dart:ui';

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
import 'package:maps_launcher/maps_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopDetailsRoute extends StatelessWidget {
  final String route = "/shop";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final internetProvider = Provider.of<InternetProvider>(context);
    attendanceProvider.trackLocation();
    internetProvider.listen();
    String shopId = ModalRoute.of(context).settings.arguments as String;
    Shop shop = shops.firstWhere((element) => element.guid == shopId);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: MediaQuery.of(context).size.height * .2,
              backgroundColor: themeProvider.backgroundColor,
              elevation: 0,
              pinned: true,
              brightness: Brightness.light,
              iconTheme: IconThemeData(color: themeProvider.textColor),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(shop.name, style: TextStyles.subTitle(context: context, color: themeProvider.textColor)),
                collapseMode: CollapseMode.parallax,
                stretchModes: [StretchMode.blurBackground, StretchMode.zoomBackground],
                background: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: CachedNetworkImage(
                        imageUrl: shop.logo,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      bottom: 0,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                          decoration: BoxDecoration(color: themeProvider.backgroundColor.withOpacity(.75)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        appBar: PreferredSize(
                          preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight),
                          child: TabBar(
                            labelColor: themeProvider.accentColor,
                            labelStyle: TextStyles.caption(context: context, color: themeProvider.accentColor),
                            unselectedLabelColor: themeProvider.hintColor,
                            unselectedLabelStyle: TextStyles.caption(context: context, color: themeProvider.hintColor),
                            indicatorWeight: 2,
                            indicatorColor: themeProvider.accentColor,
                            tabs: [
                              Tab(icon: Icon(Icons.info_outlined), child: Text("Information")),
                              Tab(icon: Icon(Icons.note_outlined), child: Text("Notes")),
                            ],
                            isScrollable: false,
                          ),
                        ),
                        body: TabBarView(
                          children: [1, 2]
                              .map((e) => Container(
                                    child: ListView(
                                      physics: ScrollPhysics(),
                                      padding: const EdgeInsets.all(16),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: [
                                        SizedBox(height: 16),
                                        ListTile(
                                          leading: Icon(Icons.location_pin, color: themeProvider.textColor),
                                          title: Text(shop.address, style: TextStyles.body(context: context, color: themeProvider.textColor)),
                                          subtitle: Text(
                                              "${prettyDistance(calculateDistance(shop.latitude, shop.longitude, attendanceProvider.currentLocation.latitude, attendanceProvider.currentLocation.longitude))} away",
                                              style: TextStyles.caption(context: context, color: themeProvider.hintColor)),
                                          trailing: Icon(
                                            Icons.directions,
                                            color: themeProvider.accentColor,
                                          ),
                                          dense: true,
                                          visualDensity: VisualDensity.compact,
                                          onTap: () {
                                            MapsLauncher.launchQuery(shop.address);
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person, color: themeProvider.textColor),
                                          title: Text(shop.contactPerson, style: TextStyles.body(context: context, color: themeProvider.textColor)),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone, color: themeProvider.textColor),
                                          title: Text(shop.phone, style: TextStyles.body(context: context, color: themeProvider.textColor)),
                                          onTap: () {
                                            launch("tel:${shop.phone}");
                                          },
                                        ),
                                        Divider(),
                                        SizedBox(height: 16),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 16),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(primary: themeProvider.backgroundColor, shadowColor: themeProvider.secondaryColor, elevation: 2),
                                            onPressed: () {},
                                            child: Text("Add Estimate", style: TextStyles.subTitle(context: context, color: themeProvider.accentColor)),
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          height: 48,
                                        ),
                                        SizedBox(height: 16),
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 16),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (attendanceProvider.isInArea(shop.latitude, shop.longitude)) {
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

                                                  attendanceProvider.visitShop(attendance, internetProvider.notConnected);
                                                  if (internetProvider.connected) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) => AlertDialog(
                                                              title: Text("Success", style: TextStyles.subTitle(context: context, color: themeProvider.accentColor)),
                                                              content: Text("Checked-in successfully", style: TextStyles.body(context: context, color: themeProvider.textColor)),
                                                            ));
                                                  } else {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) => AlertDialog(
                                                              title: Text("Success", style: TextStyles.subTitle(context: context, color: themeProvider.accentColor)),
                                                              content: Text("You've checked-in on offline mode. Please sync the activity once internet is available",
                                                                  style: TextStyles.body(context: context, color: themeProvider.textColor)),
                                                            ));
                                                  }
                                                }
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => AlertDialog(
                                                          title: Text("Oops!", style: TextStyles.subTitle(context: context, color: themeProvider.textColor)),
                                                          content: Text(
                                                              "It seems that you are not in ${prettyDistance(attendanceProvider.distanceFilter)} radius of \"${shop.name}\"",
                                                              style: TextStyles.body(context: context, color: themeProvider.textColor)),
                                                        ));
                                              }
                                            },
                                            child: Text("Check in", style: TextStyles.subTitle(context: context, color: themeProvider.backgroundColor)),
                                          ),
                                          width: MediaQuery.of(context).size.width,
                                          height: 48,
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
                addAutomaticKeepAlives: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
