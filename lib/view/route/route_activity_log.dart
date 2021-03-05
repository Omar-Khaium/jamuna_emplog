import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

class ActivityRoute extends StatelessWidget {
  final String route = "/activity_log";
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        elevation: 0,
        title: Text(
          "Activity Log",
          style: TextStyles.title(
              context: context, color: themeProvider.accentColor),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Timeline.tileBuilder(
          theme: TimelineThemeData(
              nodePosition: 0,
              connectorTheme: ConnectorThemeData(thickness: 2),
              indicatorTheme: IndicatorThemeData(size: 32)),
          builder: TimelineTileBuilder.connected(
            contentsBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 24),
                    Text("Checked In",
                        style: TextStyles.body(
                                context: context,
                                color: themeProvider.textColor)
                            .copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("03/11/2021",
                        style: TextStyles.caption(
                                context: context,
                                color: themeProvider.hintColor)
                            .copyWith(fontStyle: FontStyle.italic)),
                    SizedBox(
                      height: 8,
                    ),
                    Text("Lorem Ipsum is simply dummy text",
                        style: TextStyles.caption(
                                context: context,
                                color: themeProvider.hintColor)
                            .copyWith(fontStyle: FontStyle.normal)),
                  ],
                ),
              );
            },
            connectorBuilder: (_, index, __) {
              return SolidLineConnector(color: themeProvider.accentColor);
            },
            indicatorBuilder: (_, index) {
              return index % 3 == 0
                  ? DotIndicator(
                      color: themeProvider.accentColor,
                      child: Icon(Icons.lock_clock,
                          color: themeProvider.backgroundColor),
                    )
                  : DotIndicator(
                      color: themeProvider.accentColor,
                      child: Icon(Icons.note,
                          color: themeProvider.backgroundColor),
                    );
            },
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
