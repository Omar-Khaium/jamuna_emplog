import 'package:emplog/provider/provider_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  final String route="/home";
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final String route = "/home";

  int _selectedIndex = 0;

  bool isFirstTime = true;

  List<Widget> fragments = [];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: fragments[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 16,
        selectedItemColor: themeProvider.accentColor,
        unselectedItemColor: themeProvider.textColor.withOpacity(.3),
        currentIndex: _selectedIndex,
        onTap: _onItemSelected,
        backgroundColor: themeProvider.backgroundColor.withOpacity(.5),
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
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.heart),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
