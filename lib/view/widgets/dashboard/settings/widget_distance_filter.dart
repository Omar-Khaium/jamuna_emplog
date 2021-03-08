import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/helper.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DistanceFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Maximum allowed distance - ${prettyDistance(attendanceProvider.distanceFilter)}", style: TextStyles.body(context: context, color: themeProvider.accentColor)),
          SizedBox(height: 16),
          Slider(
            value: attendanceProvider.distanceFilter,
            onChanged: (value) {
              attendanceProvider.applyDistanceFilter(value);
            },
            activeColor: themeProvider.accentColor,
            max: 20000,
            divisions: 100,
            min: 1,
          ),
        ],
      ),
    );
  }
}
