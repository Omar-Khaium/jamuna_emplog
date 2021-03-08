import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyles.title(
              context: context, color: themeProvider.accentColor),
        ),
        actions: [],
        elevation: 0,
        backgroundColor: themeProvider.backgroundColor,
      ),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(16),
          children: [
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
              cursorColor: themeProvider.accentColor,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                fillColor: themeProvider.secondaryColor,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)),
                prefixIcon: Icon(Icons.person, color: themeProvider.iconColor),
                contentPadding: EdgeInsets.all(16),
                hintText: "Name",
                hintStyle: TextStyles.body(
                    context: context, color: themeProvider.shadowColor),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
              cursorColor: themeProvider.accentColor,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                fillColor: themeProvider.secondaryColor,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)),
                prefixIcon: Icon(Icons.email, color: themeProvider.iconColor),
                contentPadding: EdgeInsets.all(16),
                hintText: "Email",
                hintStyle: TextStyles.body(
                    context: context, color: themeProvider.shadowColor),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              keyboardType: TextInputType.text,
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
              cursorColor: themeProvider.accentColor,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                fillColor: themeProvider.secondaryColor,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)),
                prefixIcon: Icon(Icons.phone, color: themeProvider.iconColor),
                contentPadding: EdgeInsets.all(16),
                hintText: "Phone",
                hintStyle: TextStyles.body(
                    context: context, color: themeProvider.shadowColor),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {},
                child: Text(
                  "Save".toUpperCase(),
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
