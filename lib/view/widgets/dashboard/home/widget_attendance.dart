import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class AttendanceHistory extends StatelessWidget {
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
              "Attendances",
              style: TextStyles.subTitle(
                  context: context, color: themeProvider.accentColor),
            ),
            SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Icon(MdiIcons.arrowTopRight,
                  color: themeProvider.accentColor, size: 24),
              title: Text("Today",
                  style: TextStyles.body(
                      context: context, color: themeProvider.textColor)),
              subtitle: Text("09:57am",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.textColor)),
              trailing: Icon(Icons.fiber_manual_record,
                  color: themeProvider.accentColor),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Icon(MdiIcons.arrowBottomRight,
                  color: themeProvider.errorColor, size: 24),
              title: Text("Yesterday",
                  style: TextStyles.body(
                      context: context, color: themeProvider.textColor)),
              subtitle: Text("07:33pm",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.textColor)),
              trailing: Text("09:32:00",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.iconColor)),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: Icon(MdiIcons.arrowTopRight,
                  color: themeProvider.accentColor, size: 24),
              title: Text("Yesterday",
                  style: TextStyles.body(
                      context: context, color: themeProvider.textColor)),
              subtitle: Text("10:01am",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.textColor)),
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
