import 'package:emplog/provider/provider_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
      ),
    );
  }
}
