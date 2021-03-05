import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogsHistory extends StatelessWidget {
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
              "Logs",
              style: TextStyles.subTitle(
                  context: context, color: themeProvider.accentColor),
            ),
            SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Icon(Icons.check_box_rounded,
                  color: themeProvider.accentColor, size: 24),
              title: Text("CheckIn",
                  style: TextStyles.body(
                      context: context, color: themeProvider.textColor)),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("03/02/2021 at 9.23 pm",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.hintColor)),
                  Text("Lorem Ipsum is simply dummy text",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.textColor))
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Icon(Icons.attach_money,
                  color: themeProvider.accentColor, size: 24),
              title: Text("Cash Received",
                  style: TextStyles.body(
                      context: context, color: themeProvider.textColor)),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("03/02/2021 at 9.23 pm",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.hintColor)),
                  Text("Lorem Ipsum is simply dummy text",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.textColor))
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Icon(Icons.lock_clock,
                  color: themeProvider.accentColor, size: 24),
              title: Text("Pending checkout",
                  style: TextStyles.body(
                      context: context, color: themeProvider.textColor)),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("03/02/2021 at 9.23 pm",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.hintColor)),
                  Text("Lorem Ipsum is simply dummy text",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.textColor))
                ],
              ),
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
