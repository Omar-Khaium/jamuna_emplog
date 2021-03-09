import 'package:emplog/model/pretty_attendance.dart';
import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_internet.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';

class AttendanceDetailsRoute extends StatelessWidget {
  final String route = "/attendance_details";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final internetProvider = Provider.of<InternetProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    internetProvider.listen();

    String attendanceId = ModalRoute.of(context).settings.arguments as String;
    final PrettyAttendance attendance = attendanceProvider.findHistoryByID(attendanceId);
    Future.delayed(Duration(milliseconds: 0), () {
      attendanceProvider.trackLocation();
      attendanceProvider.trackNearbyOutlet();
      attendanceProvider.trackNearbyShop();
    });
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        title: Text(
          attendance.event == "In"
              ? "Checked in"
              : attendance.event == "Out"
                  ? "Checked out"
                  : "Shop visit",
          style: TextStyles.title(context: context, color: themeProvider.accentColor),
        ),
        elevation: 0,
        brightness: Brightness.light,
        automaticallyImplyLeading: true,
        centerTitle: false,
      ),
      body: ListView(
        physics: ScrollPhysics(),
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            dense: true,
            leading: Icon(
              attendance.event == "In"
                  ? Icons.south_east
                  : attendance.event == "Out"
                      ? Icons.north_east
                      : Icons.store_mall_directory_outlined,
              color: attendance.event == "In"
                  ? Colors.green
                  : attendance.event == "Out"
                      ? Colors.red
                      : themeProvider.hintColor,
            ),
            title: Text(
              DateFormat("hh:mma").format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(attendance.dateTime)),
              style: TextStyles.body(
                  context: context,
                  color: attendance.event == "In"
                      ? Colors.greenAccent.shade700
                      : attendance.event == "Out"
                          ? Colors.redAccent.shade200
                          : themeProvider.textColor),
            ),
            trailing: attendance.event == "Out"
                ? Text(
                    attendance.duration,
                    style: TextStyles.caption(context: context, color: themeProvider.hintColor),
                  )
                : null,
            contentPadding: EdgeInsets.zero,
          ),
          Visibility(
            visible: attendance.event != "Out",
            child: ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_pin, color: themeProvider.textColor),
              title: Text(
                attendance.location,
                style: TextStyles.body(context: context, color: themeProvider.textColor),
              ),
            ),
          ),
          Visibility(
            visible: attendance.event == "Out",
            child: ListTile(
              visualDensity: VisualDensity.compact,
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.access_time_outlined, color: themeProvider.textColor),
              title: Text(
                attendance.duration,
                style: TextStyles.body(context: context, color: themeProvider.textColor),
              ),
            ),
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.gps_fixed, color: themeProvider.textColor),
            title: Text(
              "${attendance.latitude}, ${attendance.longitude}",
              style: TextStyles.body(context: context, color: themeProvider.textColor),
            ),
            onTap: () {
              MapsLauncher.launchCoordinates(attendance.latitude, attendance.longitude);
            },
          )
        ],
      ),
    );
  }
}
