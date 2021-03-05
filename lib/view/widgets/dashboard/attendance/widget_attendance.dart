import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AttendanceFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: themeProvider.backgroundColor,
          elevation: 0,
          title: Text("Attendance History",
              style: TextStyles.title(
                  context: context, color: themeProvider.accentColor)),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          children: [
            ListTile(
              leading: Icon(MdiIcons.arrowTopRight),
              title: Text(
                "Terry Ganser",
                style: TextStyles.body(
                    context: context, color: themeProvider.textColor),
              ),
              subtitle: Text(
                "12.54 AM",
                style: TextStyles.caption(
                    context: context, color: themeProvider.hintColor),
              ),
            ),
            ListTile(
              leading: Icon(MdiIcons.arrowTopRight),
              title: Text(
                "Terry Ganser",
                style: TextStyles.body(
                    context: context, color: themeProvider.textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
