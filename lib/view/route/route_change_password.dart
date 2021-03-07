import 'package:cached_network_image/cached_network_image.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/constants.dart';
import 'package:emplog/utils/form_validator.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChangePasswordRoute extends StatefulWidget {
  final String route = "/change_password";

  @override
  _ChangePasswordRouteState createState() => _ChangePasswordRouteState();
}

class _ChangePasswordRouteState extends State<ChangePasswordRoute> {
  TextEditingController oldPasswordController = TextEditingController();

  TextEditingController newPasswordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  //validators declaration
  FormValidator oldPasswordValidator = FormValidator();
  FormValidator newPasswordValidator = FormValidator();
  FormValidator confirmPasswordValidator = FormValidator();

  @override
  void initState() {
    oldPasswordValidator.initialize(
        controller: oldPasswordController, type: FormType.password);
    newPasswordValidator.initialize(
        controller: newPasswordController, type: FormType.password);
    confirmPasswordValidator.initialize(
        controller: confirmPasswordController, type: FormType.password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        elevation: 0,
        title: Text(
          "Change Password",
          style: TextStyles.title(
              context: context, color: themeProvider.accentColor),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            TextField(
              controller: oldPasswordController,
              keyboardType: TextInputType.text,
              style: TextStyles.body(
                  context: context,
                  color: oldPasswordValidator.isValid
                      ? themeProvider.textColor
                      : themeProvider.errorColor),
              cursorColor: oldPasswordValidator.isValid
                  ? themeProvider.accentColor
                  : themeProvider.errorColor,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                if (!oldPasswordValidator.isValid) {
                  setState(() {
                    oldPasswordValidator.validate();
                  });
                }
              },
              decoration: InputDecoration(
                  fillColor: themeProvider.secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(4)),
                  prefixIcon: Icon(Icons.lock,
                      color: oldPasswordValidator.isValid
                          ? themeProvider.iconColor
                          : themeProvider.errorColor),
                  contentPadding: EdgeInsets.all(16),
                  hintText: "old password",
                  hintStyle: TextStyles.body(
                      context: context,
                      color: oldPasswordValidator.isValid
                          ? themeProvider.shadowColor
                          : themeProvider.errorColor.withOpacity(.25)),
                  helperText: oldPasswordValidator.validationMessage,
                  helperStyle: TextStyles.caption(
                      context: context, color: themeProvider.errorColor),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                        oldPasswordValidator.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: oldPasswordValidator.isValid
                            ? themeProvider.iconColor
                            : themeProvider.errorColor),
                    onPressed: () {
                      setState(() {
                        oldPasswordValidator.toggleObscure();
                      });
                    },
                  )),
              obscureText: oldPasswordValidator.isObscure,
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: newPasswordController,
              keyboardType: TextInputType.text,
              style: TextStyles.body(
                  context: context,
                  color: newPasswordValidator.isValid
                      ? themeProvider.textColor
                      : themeProvider.errorColor),
              cursorColor: newPasswordValidator.isValid
                  ? themeProvider.accentColor
                  : themeProvider.errorColor,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                if (!newPasswordValidator.isValid) {
                  setState(() {
                    newPasswordValidator.validate();
                  });
                }
              },
              decoration: InputDecoration(
                  fillColor: themeProvider.secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(4)),
                  prefixIcon: Icon(Icons.lock,
                      color: newPasswordValidator.isValid
                          ? themeProvider.iconColor
                          : themeProvider.errorColor),
                  contentPadding: EdgeInsets.all(16),
                  hintText: "new password",
                  hintStyle: TextStyles.body(
                      context: context,
                      color: newPasswordValidator.isValid
                          ? themeProvider.shadowColor
                          : themeProvider.errorColor.withOpacity(.25)),
                  helperText: newPasswordValidator.validationMessage,
                  helperStyle: TextStyles.caption(
                      context: context, color: themeProvider.errorColor),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                        newPasswordValidator.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: newPasswordValidator.isValid
                            ? themeProvider.iconColor
                            : themeProvider.errorColor),
                    onPressed: () {
                      setState(() {
                        newPasswordValidator.toggleObscure();
                      });
                    },
                  )),
              obscureText: newPasswordValidator.isObscure,
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: confirmPasswordController,
              keyboardType: TextInputType.text,
              style: TextStyles.body(
                  context: context,
                  color: confirmPasswordValidator.isValid
                      ? themeProvider.textColor
                      : themeProvider.errorColor),
              cursorColor: confirmPasswordValidator.isValid
                  ? themeProvider.accentColor
                  : themeProvider.errorColor,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                if (!confirmPasswordValidator.isValid) {
                  setState(() {
                    confirmPasswordValidator.validate();
                  });
                }
              },
              decoration: InputDecoration(
                  fillColor: themeProvider.secondaryColor,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(4)),
                  prefixIcon: Icon(Icons.lock,
                      color: confirmPasswordValidator.isValid
                          ? themeProvider.iconColor
                          : themeProvider.errorColor),
                  contentPadding: EdgeInsets.all(16),
                  hintText: "confirm password",
                  hintStyle: TextStyles.body(
                      context: context,
                      color: confirmPasswordValidator.isValid
                          ? themeProvider.shadowColor
                          : themeProvider.errorColor.withOpacity(.25)),
                  helperText: confirmPasswordValidator.validationMessage,
                  helperStyle: TextStyles.caption(
                      context: context, color: themeProvider.errorColor),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(
                        confirmPasswordValidator.isObscure
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: confirmPasswordValidator.isValid
                            ? themeProvider.iconColor
                            : themeProvider.errorColor),
                    onPressed: () {
                      setState(() {
                        confirmPasswordValidator.toggleObscure();
                      });
                    },
                  )),
              obscureText: confirmPasswordValidator.isObscure,
            ),
            SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    oldPasswordValidator.validate();
                    newPasswordValidator.validate();
                    confirmPasswordValidator.validate();
                  });
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: Stack(
                              children: [
                                Container(
                                  height: 300,
                                  width: MediaQuery.of(context).size.width - 64,
                                  child: CachedNetworkImage(
                                    height: 300,
                                    imageUrl:
                                        "https://cdn.dribbble.com/users/472667/screenshots/14651557/media/9f6abf9b528fac0e2befaffc11b836a2.png?compress=1&resize=300x300",
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.close,
                                          size: 18,
                                          color: themeProvider.backgroundColor,
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                      barrierDismissible: true);
                },
                child: Text(
                  "Change Password".toUpperCase(),
                  style: TextStyles.body(context: context, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
