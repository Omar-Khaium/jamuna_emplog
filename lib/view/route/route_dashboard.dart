import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_internet.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/dashboard/widget_attendance.dart';
import 'package:emplog/view/widgets/dashboard/widget_home.dart';
import 'package:emplog/view/widgets/dashboard/widget_settings.dart';
import 'package:emplog/view/widgets/dashboard/widget_shops.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DashboardRoute extends StatefulWidget {
  final String route = "/dashboard";

  @override
  _DashboardRouteState createState() => _DashboardRouteState();
}

class _DashboardRouteState extends State<DashboardRoute> {
  int currentIndex = 0;

  final List<Widget> fragments = [
    HomeFragment(),
    AttendanceFragment(),
    ShopsFragment(),
    SettingsFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final internetProvider = Provider.of<InternetProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    internetProvider.listen();

    Future.delayed(Duration(milliseconds: 0),(){
      attendanceProvider.trackLocation();
      attendanceProvider.trackNearbyOutlet();
      attendanceProvider.trackNearbyShop();
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(bottom: kToolbarHeight),
          child: Stack(
            children: [
              Positioned(
                child: fragments[currentIndex],
                bottom: internetProvider.connected ? 0 : 42,
                right: 0,
                left: 0,
                top: 0,
              ),
              Visibility(
                visible: internetProvider.notConnected,
                child: Positioned(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text("No internet", style: TextStyles.caption(context: context, color: Colors.red)),
                  ),
                  bottom: 0,
                  right: 0,
                  left: 0,
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: themeProvider.accentColor,
          unselectedItemColor: themeProvider.hintColor,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: themeProvider.secondaryColor,
          selectedLabelStyle: TextStyles.caption(context: context, color: themeProvider.accentColor),
          unselectedLabelStyle: TextStyles.caption(context: context, color: themeProvider.hintColor),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(MdiIcons.clock), label: 'Attendance'),
            BottomNavigationBarItem(icon: Icon(MdiIcons.store), label: 'Shops'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
