import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisitedShopsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return PhysicalModel(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Visited Shops",
              style: TextStyles.subTitle(
                  context: context, color: themeProvider.accentColor),
            ),
            SizedBox(height: 12),
            ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              leading: Icon(
                Icons.person,
                color: themeProvider.accentColor,
              ),
              title: Text(
                "John Snow's food shop",
                style: TextStyles.body(
                    context: context, color: themeProvider.textColor),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              leading: Icon(
                Icons.person,
                color: themeProvider.accentColor,
              ),
              title: Text(
                "Ned Stark's coffee shop",
                style: TextStyles.body(
                    context: context, color: themeProvider.textColor),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              leading: Icon(
                Icons.person,
                color: themeProvider.accentColor,
              ),
              title: Text(
                "Thomas Shelby's cigarettes shop",
                style: TextStyles.body(
                    context: context, color: themeProvider.textColor),
              ),
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: themeProvider.backgroundColor,
      shadowColor: themeProvider.accentColor.withOpacity(.25),
      elevation: 2,
      shape: BoxShape.rectangle,
    );
  }
}
