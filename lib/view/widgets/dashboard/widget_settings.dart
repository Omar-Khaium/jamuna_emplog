import 'package:cached_network_image/cached_network_image.dart';
import 'package:emplog/provider/provider_auth.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/route/route_activity_log.dart';
import 'package:emplog/view/route/route_auth.dart';
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
          leading: CircleAvatar(
            backgroundColor: themeProvider.accentColor.withOpacity(.05),
            child: CachedNetworkImage(
              imageUrl: "Api.fileUrl(authProvider.user.profilePicture)",
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CupertinoActivityIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.person, color: themeProvider.accentColor),
            ),
          ),
          title: Text(authProvider.user.name, style: TextStyles.body(context: context, color: themeProvider.textColor)),
          subtitle: Text("view profile", style: TextStyles.caption(context: context, color: themeProvider.hintColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: themeProvider.hintColor, size: 16),
          dense: false,
          visualDensity: VisualDensity.comfortable,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.note_outlined, color: themeProvider.textColor),
          title: Text("Notes", style: TextStyles.body(context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.alarm_rounded, color: themeProvider.textColor),
          title: Text("Reminders", style: TextStyles.body(context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.local_activity_outlined, color: themeProvider.textColor),
          title: Text("Activity log", style: TextStyles.body(context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: (){
            Navigator.of(context).pushNamed(ActivityRoute().route);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.lock_outline, color: themeProvider.textColor),
          title: Text("Change password", style: TextStyles.body(context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.color_lens_outlined, color: themeProvider.textColor),
          title: Text("Change theme", style: TextStyles.body(context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: (){
            showModalBottomSheet(context: context, builder: (context)=>ThemeBottomSheet());
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.privacy_tip_outlined, color: themeProvider.textColor),
          title: Text("Privacy policy", style: TextStyles.body(context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: themeProvider.hintColor, size: 16),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout, color: themeProvider.textColor),
          title: Text("Log out", style: TextStyles.body(context: context, color: themeProvider.textColor)),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: themeProvider.hintColor, size: 16),
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
              Text("v1.0", style: TextStyles.overline(context: context, color: themeProvider.textColor), textAlign: TextAlign.center),
              Container(child: Icon(Icons.fiber_manual_record, color: themeProvider.shadowColor, size: 11), margin: EdgeInsets.symmetric(horizontal: 12)),
              Text("Powered by Jamuna Group", style: TextStyles.overline(context: context, color: themeProvider.textColor), textAlign: TextAlign.center),
            ],
          ),
        ),
      ],
    );
  }
}
