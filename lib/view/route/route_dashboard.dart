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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: fragments[currentIndex],
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
