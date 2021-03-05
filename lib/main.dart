import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/view/route/route_auth.dart';
import 'package:emplog/view/route/route_home.dart';
import 'package:emplog/view/route/route_welcome_screen.dart';
import 'package:emplog/view/widgets/auth/form_fingerprint_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'JAS',
      theme: ThemeData(
        primarySwatch: themeProvider.accentColor,
        accentColor: themeProvider.accentColor,
        backgroundColor: themeProvider.backgroundColor,
        canvasColor: themeProvider.backgroundColor,
        shadowColor: themeProvider.shadowColor,
        indicatorColor: themeProvider.accentColor,
        cursorColor: themeProvider.accentColor,
        iconTheme: IconThemeData(color: themeProvider.iconColor, size: 20),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: themeProvider.accentColor),
            actionsIconTheme: IconThemeData(color: themeProvider.accentColor)),
      ),
      home: AuthRoute(),
      routes: {
        AuthRoute().route: (context) => AuthRoute(),
        //HomeRoute().route: (context) => HomeRoute(),
        WelcomeRoute().route: (context) => WelcomeRoute(),
        FingerprintAuth().route: (context) => FingerprintAuth(),
      },
    );
  }
}

// ignore: must_be_immutable
class LauncherRoute extends StatelessWidget {
  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (isFirstTime) {
      isFirstTime = false;
      Future.delayed(Duration(milliseconds: 1500), () {
        Navigator.of(context).pushReplacementNamed(AuthRoute().route);
      });
    }

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Center(
        child: FlutterLogo(
          size: 42,
        ),
      ),
    );
  }
}
