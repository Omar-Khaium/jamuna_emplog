import 'package:cached_network_image/cached_network_image.dart';
import 'package:emplog/provider/provider_auth.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/route/route_activity_log.dart';
import 'package:emplog/view/route/route_auth.dart';
import 'package:emplog/view/route/route_change_password.dart';
import 'package:emplog/view/route/route_notes_reminders.dart';
import 'package:emplog/view/widgets/dashboard/settings/bottom_sheet_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    authProvider.init();
    return ListView(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      children: [
        SizedBox(height: MediaQuery.of(context).padding.top),
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(48),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              height: 48,
              width: 48,
              filterQuality: FilterQuality.medium,
              imageUrl:
                  "https://images.unsplash.com/photo-1570857502809-08184874388e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=798&q=80",
            ),
          ),
          title: Text(authProvider.user.name,
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor)),
          subtitle: Text("view profile",
              style: TextStyles.caption(
                  context: context, color: themeProvider.hintColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: themeProvider.hintColor, size: 16),
          dense: false,
          visualDensity: VisualDensity.comfortable,
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, NotesAndRemindersRoute().route);
          },
          leading: Icon(Icons.note_outlined, color: themeProvider.textColor),
          title: Text("Notes",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.local_activity_outlined,
              color: themeProvider.textColor),
          title: Text("Activity log",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () {
            Navigator.of(context).pushNamed(ActivityRoute().route);
          },
        ),
        Divider(),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, ChangePasswordRoute().route);
          },
          leading: Icon(Icons.lock_outline, color: themeProvider.textColor),
          title: Text("Change password",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        Divider(),
        ListTile(
          leading:
              Icon(Icons.color_lens_outlined, color: themeProvider.textColor),
          title: Text("Change theme",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () {
            showModalBottomSheet(
                context: context, builder: (context) => ThemeBottomSheet());
          },
        ),
        Divider(),
        ListTile(
          leading:
              Icon(Icons.privacy_tip_outlined, color: themeProvider.textColor),
          title: Text("Privacy policy",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: themeProvider.textColor),
          title: Text("Log out",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () {
            authProvider.logout();
            Navigator.of(context).pushReplacementNamed(AuthRoute().route);
          },
        ),
        Divider(),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("v1.0",
                  style: TextStyles.overline(
                      context: context, color: themeProvider.textColor),
                  textAlign: TextAlign.center),
              Container(
                  child: Icon(Icons.fiber_manual_record,
                      color: themeProvider.shadowColor, size: 11),
                  margin: EdgeInsets.symmetric(horizontal: 12)),
              Text("Powered by Jamuna Group",
                  style: TextStyles.overline(
                      context: context, color: themeProvider.textColor),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }
}
