import 'package:emplog/view/widgets/dashboard/home/widget_attendance.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_logs.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_reminders.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_sync_now.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_visited_shops.dart';
import 'package:flutter/material.dart';

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top - 16),
          SyncData(),
          SizedBox(height: 16),
          AttendanceHistory(),
          SizedBox(height: 16),
          LogsHistory(),
          SizedBox(height: 16),
          ReminderHistory(),
          SizedBox(height: 16),
          VisitedShopsFragment(),
          SizedBox(height: 16)
        ],
      ),
    );
  }
}
