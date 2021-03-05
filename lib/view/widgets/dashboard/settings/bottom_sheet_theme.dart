import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: themeProvider.backgroundColor,
      ),
      padding: EdgeInsets.all(24),
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        direction: Axis.horizontal,
        verticalDirection: VerticalDirection.down,
        alignment: WrapAlignment.spaceEvenly,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.spaceEvenly,
        children: themeColors
            .map((color) => InkWell(
                  onTap: () {
                    themeProvider.applyTheme(color);
                  },
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 24,
                    child: Visibility(
                      visible: color == themeProvider.accentColor,
                      child: Icon(
                        Icons.check,
                        color: themeProvider.backgroundColor,
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
