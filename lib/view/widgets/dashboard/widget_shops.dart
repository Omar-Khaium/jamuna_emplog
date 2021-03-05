import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ShopsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
        decoration: BoxDecoration(color: themeProvider.backgroundColor),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          children: [
            ListTile(
              leading: CircleAvatar(
                  backgroundColor: themeProvider.accentColor.withOpacity(.02),
                  child: Icon(MdiIcons.arrowTopRight,
                      color: themeProvider.redColor)),
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
              leading: CircleAvatar(
                backgroundColor: themeProvider.accentColor.withOpacity(.02),
                child: Icon(MdiIcons.arrowBottomRight,
                    color: themeProvider.greenColor),
              ),
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
              trailing: Text(
                "9 hr",
                style: TextStyles.caption(
                    context: context, color: themeProvider.hintColor),
              ),
            ),
          ],
        ));
  }
}
