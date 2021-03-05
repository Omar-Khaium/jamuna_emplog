import 'package:emplog/model/attendance.dart';
import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/constants.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttendanceFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    Future.delayed(Duration(milliseconds: 0), () {
      if (attendanceProvider.items.isEmpty) {
        attendanceProvider.loadAttendances();
      }
    });
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        title: Text("Attendance", style: TextStyles.title(context: context, color: themeProvider.accentColor)),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.add_location_alt_outlined), onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          Attendance attendance = attendanceProvider.getAll()[index];
          return Container(
            margin: EdgeInsets.only(top: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attendance.dateTime,
                  style: TextStyles.body(context: context, color: themeProvider.hintColor),
                ),
                Visibility(
                  visible: attendance.items!=null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: attendance.items.map((item) => ListTile(
                      visualDensity: VisualDensity.compact,
                      dense: true,
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade50,
                        radius: 16,
                        child: Icon(
                          item.event == AttendanceType.In ? Icons.north_east : Icons.south_east,
                          color: item.event == AttendanceType.In ? Colors.green : Colors.red,
                        ),
                      ),
                      title: Text(
                        item.time,
                        style: TextStyles.body(context: context, color: themeProvider.textColor),
                      ),
                      subtitle: Text(
                        item.location,
                        style: TextStyles.caption(context: context, color: themeProvider.hintColor),
                      ),
                      trailing: item.event == AttendanceType.In ? Text(item.duration,
                        style: TextStyles.caption(context: context, color: themeProvider.hintColor),
                      ) : null,
                      contentPadding: EdgeInsets.zero,
                    )).toList(),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: attendanceProvider.getAll().length,
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 24),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.login),
        ),
      ),
    );
  }
}
