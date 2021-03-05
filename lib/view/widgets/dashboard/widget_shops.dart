import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopsFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      body: Container(
        decoration: BoxDecoration(color: themeProvider.backgroundColor),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: index > 2 && index < 6
                      ? themeProvider.accentColor.withOpacity(.05)
                      : null),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    visualDensity: VisualDensity.compact,
                    leading: ClipOval(
                      child: Image.network(
                        "https://images.unsplash.com/photo-1570857502809-08184874388e?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=798&q=80",
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      "Robi Shop",
                      style: TextStyles.body(
                          context: context, color: themeProvider.textColor),
                    ),
                    subtitle: Text(
                      "H-2,R-34,Nikunja-2,Khilkhet",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.hintColor),
                    ),
                    trailing: Text(
                      "10m",
                      style: TextStyles.caption(
                          context: context, color: themeProvider.hintColor),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        elevation: 0,
        title: Text(
          "Shops",
          style: TextStyles.title(
              context: context, color: themeProvider.accentColor),
        ),
      ),
    );
  }
}
