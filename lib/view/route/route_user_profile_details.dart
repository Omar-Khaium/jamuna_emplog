import 'package:cached_network_image/cached_network_image.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class UserDetailsRoute extends StatelessWidget {
  final String route = "/user_details";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyles.title(
              context: context, color: themeProvider.accentColor),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(16),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl:
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                width: 144,
                height: 144,
              ),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0),
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.person),
            title: Text(
              "John Doe",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
            ),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0),
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.phone),
            title: Text(
              "01475547755",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.email_outlined),
            title: Text(
              "John@example.com",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.all(0),
            visualDensity: VisualDensity.compact,
            leading: Icon(Icons.shop),
            trailing: Text(
              "(23)",
              style: TextStyles.caption(
                  context: context, color: themeProvider.textColor),
            ),
            title: Text(
              "Shops visited",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 128,
                height: 64,
                decoration: BoxDecoration(
                    color: themeProvider.accentColor.withOpacity(.06),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "34.44",
                      style: TextStyles.title(
                              context: context, color: themeProvider.textColor)
                          .copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "Hours tracked",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.hintColor),
                    ),
                  ],
                ),
              ),
              Container(
                width: 128,
                height: 64,
                decoration: BoxDecoration(
                    color: themeProvider.accentColor.withOpacity(.06),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "15.21",
                      style: TextStyles.title(
                              context: context, color: themeProvider.textColor)
                          .copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "Remaining hours",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.hintColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Worked this month",
            style: TextStyles.body(
                context: context, color: themeProvider.textColor),
          ),
          SizedBox(
            height: 8,
          ),
          LinearPercentIndicator(
              animation: true,
              lineHeight: 12.0,
              percent: 0.7,
              backgroundColor: themeProvider.tagColor,
              progressColor: themeProvider.accentColor),
        ],
      ),
    );
  }
}
