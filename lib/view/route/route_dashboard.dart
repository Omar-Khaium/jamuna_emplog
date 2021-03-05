import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/view/widgets/dashboard/widget_attendance.dart';
import 'package:emplog/view/widgets/dashboard/widget_home.dart';
import 'package:emplog/view/widgets/dashboard/widget_settings.dart';
import 'package:emplog/view/widgets/dashboard/widget_shops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DashboardRoute extends StatefulWidget {
  final String route = "/dashboard";
  @override
  _DashboardRouteState createState() => _DashboardRouteState();
}

class _DashboardRouteState extends State<DashboardRoute> {
  int _selectedIndex = 0;

  bool isFirstTime = true;

  List<Widget> fragments = [
    HomeFragment(),
    AttendanceFragment(),
    ShopsFragment(),
    SettingsFragment()
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
      ),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: fragments[_selectedIndex],
        resizeToAvoidBottomInset: true,
        extendBodyBehindAppBar: true,
        extendBody: true,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 16,
          selectedItemColor: themeProvider.accentColor,
          unselectedItemColor: themeProvider.textColor.withOpacity(.3),
          currentIndex: _selectedIndex,
          onTap: _onItemSelected,
          backgroundColor: themeProvider.accentColor.withOpacity(.01),
          selectedLabelStyle: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: themeProvider.textColor,
                ),
          ),
          unselectedLabelStyle: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: themeProvider.textColor,
                ),
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.clock),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.store),
              label: 'Shops',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
