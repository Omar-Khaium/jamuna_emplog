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

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        body: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
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
              SizedBox(
                height: 16,
              ),
              Text(
                "-------------- or --------------",
                style: TextStyles.caption(
                    context: context, color: themeProvider.textColor),
              ),
              SizedBox(
                height: 36,
              ),
              Center(
                child: InkWell(
                  child: Icon(
                    Icons.fingerprint,
                    size: 64,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
