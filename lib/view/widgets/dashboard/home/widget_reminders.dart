import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ReminderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PhysicalModel(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notes",
              style: TextStyles.subTitle(
                  context: context, color: themeProvider.accentColor),
            ),
            SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Icon(
                Icons.note,
                color: themeProvider.accentColor,
              ),
              title: Text(
                "Shop is closed since 24 Feb",
                style: TextStyles.body(
                    context: context, color: themeProvider.textColor),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text("03/02/2021 at 9.23 pm",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.hintColor)),
              trailing: Icon(MdiIcons.reminder, color: themeProvider.iconColor),
            ),
          ],
        ),
      ),
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: themeProvider.backgroundColor,
      shadowColor: themeProvider.accentColor.withOpacity(.25),
      elevation: 3,
      shape: BoxShape.rectangle,
    );
  }
}
