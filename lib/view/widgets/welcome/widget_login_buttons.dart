import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              primary: themeProvider.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              Navigator.pushNamed(context, "/email");
            },
            icon: Icon(
              MdiIcons.email,
              color: Colors.white,
            ),
            label: Text(
              "Sign in with Email".toUpperCase(),
              style: TextStyles.body(
                  context: context, color: themeProvider.backgroundColor),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              primary: themeProvider.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {
              Navigator.pushNamed(context, "/finger_auth");
            },
            icon: Icon(
              MdiIcons.fingerprint,
              color: Colors.white,
            ),
            label: Text(
              "Sign in with Fingerprint".toUpperCase(),
              style: TextStyles.body(
                  context: context, color: themeProvider.backgroundColor),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width - 48,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              primary: themeProvider.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () async {},
            icon: Icon(
              Icons.verified,
              color: Colors.white,
            ),
            label: Text(
              "Sign in with OTP".toUpperCase(),
              style: TextStyles.body(
                  context: context, color: themeProvider.backgroundColor),
            ),
          ),
        ),
      ],
    );
  }
}
