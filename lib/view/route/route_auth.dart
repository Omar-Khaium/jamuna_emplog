import 'package:emplog/provider/provider_auth.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/auth/form_auth.dart';
import 'package:emplog/view/widgets/auth/form_fingerprint_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthRoute extends StatelessWidget {
  final String route = "/auth";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    authProvider.init();

    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AuthForm(),
              Visibility(child: Container(child: Divider(), margin: EdgeInsets.symmetric(vertical: 24)), visible: authProvider.hasPreviousAuth),
              Visibility(child: BiometricForm(), visible: authProvider.hasPreviousAuth),
            ],
          ),
        ),
      ),
    );
  }
}
