import 'dart:async';

import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/view/route/route_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class BiometricForm extends StatefulWidget {
  @override
  _BiometricFormState createState() => _BiometricFormState();
}

class _BiometricFormState extends State<BiometricForm> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isAvailable = false;

  @override
  void initState() {
    isBiometricAvailable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      child: Icon(Icons.fingerprint,
          size: 64,
          color: isAvailable
              ? themeProvider.accentColor
              : themeProvider.hintColor),
      onTap: () {
        authenticateUser();
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
  }

  Future<void> isBiometricAvailable() async {
    bool flag = false;
    try {
      flag = await auth.canCheckBiometrics;
    } catch (e) {
      setState(() async {
        flag = false;
      });
    }
    setState(() {
      isAvailable = flag;
    });
  }

  Future<void> authenticateUser() async {
    try {
      await auth
          .authenticateWithBiometrics(
              localizedReason: "Welcome to Jamuna Group",
              useErrorDialogs: true,
              stickyAuth: true)
          .then((value) {
        if (value) {
          Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
        }
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Something went wrong"),
          content: Text(e.message),
        ),
      );
    }
  }
}
