import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_attendance.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_logs.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_reminders.dart';
import 'package:emplog/view/widgets/dashboard/home/widget_sync_now.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    attendanceProvider.init();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: themeProvider.backgroundColor,
          title: Text("Home", style: TextStyles.title(context: context, color: themeProvider.accentColor)),
          centerTitle: false,
          automaticallyImplyLeading: false,
          brightness: Brightness.light,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          children: [
            Visibility(
              child: SyncData(),
              visible: attendanceProvider.hasUnSyncedData,
            ),
            Visibility(child: SizedBox(height: 16), visible: attendanceProvider.hasUnSyncedData),
            AttendanceHistory(),
            SizedBox(height: 16),
            LogsHistory(),
            SizedBox(height: 16),
            ReminderHistory(),
          ],
        ),
      ),
    );
  }
}
