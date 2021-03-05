import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_auth.dart';
import 'package:emplog/provider/provider_internet.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/model/user.dart';
import 'package:emplog/view/route/route_auth.dart';
import 'package:emplog/view/route/route_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(UserAdapter());
  runApp(
    MultiProvider(
      child: MyApp(),
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => InternetProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AttendanceProvider()),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Attendance',
      theme: ThemeData(
        primarySwatch: themeProvider.accentColor,
        accentColor: themeProvider.accentColor,
        backgroundColor: themeProvider.backgroundColor,
        canvasColor: themeProvider.backgroundColor,
        shadowColor: themeProvider.shadowColor,
        indicatorColor: themeProvider.accentColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: themeProvider.accentColor,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: themeProvider.accentColor,
        ),
        iconTheme: IconThemeData(color: themeProvider.iconColor, size: 20),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: themeProvider.accentColor), actionsIconTheme: IconThemeData(color: themeProvider.accentColor)),
      ),
      home: LauncherRoute(),
      routes: {
        AuthRoute().route: (context) => AuthRoute(),
        DashboardRoute().route: (context) => DashboardRoute(),
      },
    );
  }
}

// ignore: must_be_immutable
class LauncherRoute extends StatefulWidget {
  @override
  _LauncherRouteState createState() => _LauncherRouteState();
}

class _LauncherRouteState extends State<LauncherRoute> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      redirect();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Center(
        child: FlutterLogo(
          size: 42,
        ),
      ),
    );
  }

  redirect() async {
    try {
      Box<User> userBox = await Hive.openBox("users");
      User user;
      if (userBox.length > 0) {
        user = userBox.getAt(0);
      }
      Navigator.of(context).pushReplacementNamed(user == null
          ? AuthRoute().route
          : user.isAuthenticated ?? false
              ? DashboardRoute().route
              : AuthRoute().route);
    } catch (error) {
      Navigator.of(context).pushReplacementNamed(AuthRoute().route);
    }
  }
}
