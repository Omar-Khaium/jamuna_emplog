import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emplog/model/shop.dart';
import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_internet.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/fake_database.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/route/route_notes_reminders.dart';
import 'package:emplog/view/widgets/dashboard/settings/note/widget_notes_reminders_details.dart';
import 'package:emplog/view/widgets/shop/widget_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
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
                title: Text(shop.name,
                    style: TextStyles.subTitle(
                        context: context, color: themeProvider.textColor)),
                collapseMode: CollapseMode.parallax,
                stretchModes: [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground
                ],
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
                          decoration: BoxDecoration(
                              color: themeProvider.backgroundColor
                                  .withOpacity(.75)),
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
                          preferredSize: Size(MediaQuery.of(context).size.width,
                              kToolbarHeight),
                          child: TabBar(
                            labelColor: themeProvider.accentColor,
                            labelStyle: TextStyles.caption(
                                context: context,
                                color: themeProvider.accentColor),
                            unselectedLabelColor: themeProvider.hintColor,
                            unselectedLabelStyle: TextStyles.caption(
                                context: context,
                                color: themeProvider.hintColor),
                            indicatorWeight: 2,
                            indicatorColor: themeProvider.accentColor,
                            tabs: [
                              Tab(
                                  icon: Icon(Icons.info_outlined),
                                  child: Text("Information")),
                              Tab(
                                  icon: Icon(Icons.note_outlined),
                                  child: Text("Notes")),
                            ],
                            isScrollable: false,
                          ),
                        ),
                        body: TabBarView(children: [
                          Information(shop),
                          NotesAndRemindersRoute()
                        ]),
                      ),
                    ),
                  ),
                ],
                addAutomaticKeepAlives: true,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetails(), fullscreenDialog: true));
          },
          backgroundColor: themeProvider.accentColor,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
