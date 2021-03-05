import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/auth/form_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthRoute extends StatelessWidget {
  final String route = "/email";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.architecture,
                    size: 72,
                    color: themeProvider.accentColor,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Sign in",
                      style: TextStyles.title(
                          context: context, color: themeProvider.accentColor),
                      textAlign: TextAlign.center),
                  SizedBox(
                    height: 12,
                  ),
                  AuthForm(),
                ],
              ),
            ),
            Positioned(
              child: Center(
                child: TextButton(
                  child: Text("Forget password",
                      style: TextStyles.body(
                          context: context, color: themeProvider.accentColor),
                      textAlign: TextAlign.center),
                  onPressed: () {},
                ),
              ),
              bottom: 16,
              left: 0,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }
}
