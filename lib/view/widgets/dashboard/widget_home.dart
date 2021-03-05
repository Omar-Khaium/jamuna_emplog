import 'package:emplog/view/widgets/dashboard/home/widget_attendance.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_logs.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_reminders.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(8),
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        children: [
          SizedBox(
            height: 16,
          ),
          AttendanceHistory(),
          SizedBox(
            height: 16,
          ),
          LogsHistory(),
          SizedBox(
            height: 16,
          ),
          ReminderHistory(),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
