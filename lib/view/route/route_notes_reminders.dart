import 'package:emplog/provider/provider_attendance.dart';
import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/dashboard/settings/note/widget_notes_reminders_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NotesAndRemindersRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final attendanceProvider = Provider.of<AttendanceProvider>(context);

    Future.delayed(Duration(milliseconds: 0),(){
      attendanceProvider.trackLocation();
      attendanceProvider.trackNearbyOutlet();
      attendanceProvider.trackNearbyShop();
    });

    return Container(
      decoration: BoxDecoration(color: themeProvider.backgroundColor),

        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                        content: Container(
                          decoration: BoxDecoration(color: themeProvider.backgroundColor),
                          width: 300,
                          child: ListTile(
                          visualDensity: VisualDensity.compact,
                          contentPadding: EdgeInsets.all(0),
                          leading: index == 3 || index == 2 || index == 6
                              ? Icon(Icons.alarm_on_outlined)
                              : Icon(Icons.note_outlined),
                          title: Text(
                            "This is dummy note from Omar Khaium",
                            maxLines: 2,
                            style: TextStyles.body(context: context, color: themeProvider.textColor),
                              ),
                              subtitle: Visibility(
                            visible: index == 3 || index == 2 || index == 6,
                            child: Text(
                              "03/12/11 at 12.30 PM",
                              style: TextStyles.caption(context: context, color: themeProvider.hintColor),
                            ),
                          ),
                        ),
                      ),
                    );
                    });
              },
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      visualDensity: VisualDensity.compact,
                      leading: index == 3 || index == 2 || index == 6 ? Icon(Icons.alarm_on_outlined) : Icon(Icons.note_outlined),
                      title: Text(
                        "This is dummy note from Omar Khaium",
                        maxLines: 2,
                        style: TextStyles.body(context: context, color: themeProvider.textColor),
                      ),
                      subtitle: Visibility(
                        visible: index == 3 || index == 2 || index == 6,
                        child: Text(
                          "03/12/11 at 12.30 PM",
                          style: TextStyles.caption(context: context, color: themeProvider.hintColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

      ),
    );
  }
}
