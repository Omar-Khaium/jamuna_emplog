import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SyncData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return PhysicalModel(
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: themeProvider.backgroundColor,
      shadowColor: themeProvider.accentColor.withOpacity(.25),
      elevation: 4,
      shape: BoxShape.rectangle,
      child: MaterialBanner(
        content: Text("You have 12 unsaved data including attendance, notes and reminders."),
        forceActionsBelow: true,
        padding: EdgeInsets.all(16),
        leading: Icon(Icons.sync_problem, color: themeProvider.textColor),
        contentTextStyle: TextStyles.body(context: context, color: themeProvider.textColor),
        actions: [
          TextButton(onPressed: () {}, child: Text("Discard", style: TextStyles.body(context: context, color: themeProvider.textColor))),
          ElevatedButton(onPressed: () {}, child: Text("Sync now", style: TextStyles.body(context: context, color: themeProvider.backgroundColor))),
        ],
      ),
    );
  }
}
