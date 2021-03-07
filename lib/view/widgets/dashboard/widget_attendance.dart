import 'package:emplog/model/db/attendance.dart';
import 'package:emplog/model/pretty_attendance.dart';
import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/constants.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/dashboard/attendance/widget_checkin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    attendanceProvider.init();
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
          PrettyAttendance attendance = attendanceProvider.getAll()[index];
          return Container(
            margin: EdgeInsets.only(top: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("dd/MM/yyyy").format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(attendance.dateTime)),
                  style: TextStyles.body(context: context, color: themeProvider.hintColor),
                ),
                Visibility(
                  visible: attendance.items != null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: attendance.items
                        .map((item) => ListTile(
                              visualDensity: VisualDensity.compact,
                              dense: true,
                              leading: CircleAvatar(
                                backgroundColor: item.event == AttendanceType.In
                                    ? Colors.green.shade50
                                    : item.event == AttendanceType.Out
                                        ? Colors.red.shade50
                                        : Colors.grey.shade50,
                                radius: 16,
                                child: Icon(
                                  item.event == AttendanceType.In
                                      ? Icons.south_east
                                      : item.event == AttendanceType.Out
                                          ? Icons.north_east
                                          : Icons.store_mall_directory_outlined,
                                  color: item.event == AttendanceType.In
                                      ? Colors.green
                                      : item.event == AttendanceType.Out
                                          ? Colors.red
                                          : themeProvider.hintColor,
                                ),
                              ),
                              title: Text(
                                DateFormat("hh:mma").format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(item.time)),
                                style: TextStyles.body(
                                    context: context,
                                    color: item.event == AttendanceType.In
                                        ? Colors.greenAccent.shade700
                                        : item.event == AttendanceType.Out
                                            ? Colors.redAccent.shade200
                                            : themeProvider.textColor),
                              ),
                              subtitle: Text(
                                item.location,
                                style: TextStyles.caption(context: context, color: themeProvider.hintColor),
                              ),
                              trailing: item.event == AttendanceType.Out
                                  ? Text(
                                      item.duration,
                                      style: TextStyles.caption(context: context, color: themeProvider.hintColor),
                                    )
                                  : null,
                              contentPadding: EdgeInsets.zero,
                            ))
                        .toList(),
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
          onPressed: () {
            if (attendanceProvider.isCheckedIn) {
              attendanceProvider.toggleAttendanceStatus();
            } else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckIn()));
            }
          },
          backgroundColor: attendanceProvider.isCheckedIn ? Colors.redAccent.shade200 : Colors.greenAccent.shade700,
          child: Icon(attendanceProvider.isCheckedIn ? Icons.logout : Icons.login),
        ),
      ),
    );
  }
}
