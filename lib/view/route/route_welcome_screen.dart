import 'dart:ui';

import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/welcome/widget_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeRoute extends StatelessWidget {
  final String route = "/welcome";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage(
                      'images/welcome.png',
                    )),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                color: Colors.redAccent,
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeProvider.accentColor.withOpacity(.04),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  alignment: Alignment.topCenter,
                  child: Text(
                    "eAttendance",
                    style: TextStyles.title(
                            context: context, color: themeProvider.accentColor)
                        .copyWith(fontSize: 24),
                  ),
                ),
                Positioned(
                  top: 136,
                  left: 48,
                  child: Text(
                    "Easy way to Record & Track Attendance",
                    style: TextStyles.body(
                        context: context,
                        color: themeProvider.accentColor.withOpacity(.5)),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.center,
                  child: LoginButtons(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
