import 'package:emplog/model/pretty_attendance.dart';
import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_internet.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/dashboard/attendance/widget_checkin.dart';
import 'package:emplog/view/widgets/dashboard/attendance/widget_visit_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AttendanceFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final internetProvider = Provider.of<InternetProvider>(context);
    attendanceProvider.init();
    attendanceProvider.trackLocation();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: themeProvider.backgroundColor,
        appBar: AppBar(
          backgroundColor: themeProvider.backgroundColor,
          title: Text("Attendance", style: TextStyles.title(context: context, color: themeProvider.accentColor)),
          centerTitle: false,
          automaticallyImplyLeading: false,
          brightness: Brightness.light,
          elevation: 0,
          actions: [
            IconButton(icon: Icon(Icons.add_location_alt_outlined), onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VisitShop(
                    onSubmit: () {
                      if (internetProvider.connected) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Success", style: TextStyles.subTitle(context: context, color: themeProvider.accentColor)),
                              content: Text("Checked-in successfully", style: TextStyles.body(context: context, color: themeProvider.textColor)),
                            ));
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Success", style: TextStyles.subTitle(context: context, color: themeProvider.accentColor)),
                              content: Text("You've checked-in on offline mode. Please sync the activity once internet is available",
                                  style: TextStyles.body(context: context, color: themeProvider.textColor)),
                            ));
                      }
                    },
                  ),
                  fullscreenDialog: true));
            }),
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
                                  backgroundColor: item.event == "In"
                                      ? Colors.green.shade50
                                      : item.event == "Out"
                                          ? Colors.red.shade50
                                          : Colors.grey.shade50,
                                  radius: 16,
                                  child: Icon(
                                    item.event == "In"
                                        ? Icons.south_east
                                        : item.event == "Out"
                                            ? Icons.north_east
                                            : Icons.store_mall_directory_outlined,
                                    color: item.event == "In"
                                        ? Colors.green
                                        : item.event == "Out"
                                            ? Colors.red
                                            : themeProvider.hintColor,
                                  ),
                                ),
                                title: Text(
                                  DateFormat("hh:mma").format(DateFormat("yyyy-MM-dd HH:mm:ss").parse(item.time)),
                                  style: TextStyles.body(
                                      context: context,
                                      color: item.event == "In"
                                          ? Colors.greenAccent.shade700
                                          : item.event == "Out"
                                              ? Colors.redAccent.shade200
                                              : themeProvider.textColor),
                                ),
                                subtitle: item.event == "Out"
                                    ? null
                                    : Text(
                                        item.location,
                                        style: TextStyles.caption(context: context, color: themeProvider.hintColor),
                                      ),
                                trailing: item.event == "Out"
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
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Confirm action", style: TextStyles.subTitle(context: context, color: themeProvider.textColor)),
                          content: Text("Do you want to check out?", style: TextStyles.body(context: context, color: themeProvider.textColor)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Close", style: TextStyles.body(context: context, color: themeProvider.textColor)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent.shade200
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Check out", style: TextStyles.body(context: context, color: themeProvider.backgroundColor)),
                            ),
                          ],
                        ));
                attendanceProvider.checkOut(internetProvider.notConnected);
              } else {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CheckIn(
                          onSubmit: () {
                            if (internetProvider.connected) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Success", style: TextStyles.subTitle(context: context, color: themeProvider.accentColor)),
                                        content: Text("Checked-in successfully", style: TextStyles.body(context: context, color: themeProvider.textColor)),
                                      ));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Success", style: TextStyles.subTitle(context: context, color: themeProvider.accentColor)),
                                        content: Text("You've checked-in on offline mode. Please sync the activity once internet is available",
                                            style: TextStyles.body(context: context, color: themeProvider.textColor)),
                                      ));
                            }
                          },
                        ),
                    fullscreenDialog: true));
              }
            },
            backgroundColor: attendanceProvider.isCheckedIn ? Colors.redAccent.shade200 : Colors.greenAccent.shade700,
            child: Icon(attendanceProvider.isCheckedIn ? Icons.logout : Icons.login),
          ),
        ),
      ),
    );
  }
}
