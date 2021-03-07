import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:emplog/view/widgets/dashboard/settings/widget_notes_reminders_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NotesAndRemindersRoute extends StatefulWidget {
  final String route = "/notes_reminders";

  @override
  _NotesAndRemindersRouteState createState() => _NotesAndRemindersRouteState();
}

class _NotesAndRemindersRouteState extends State<NotesAndRemindersRoute> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        elevation: 0,
        title: Text(
          "Notes & Reminders",
          style: TextStyles.title(
              context: context, color: themeProvider.accentColor),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      visualDensity: VisualDensity.compact,
                      leading: index == 3 || index == 2 || index == 6
                          ? Icon(Icons.alarm_on_outlined)
                          : Icon(Icons.note_outlined),
                      title: Text(
                        "This is dummy note from Omar Farooq",
                        maxLines: 2,
                        style: TextStyles.body(
                            context: context, color: themeProvider.textColor),
                      ),
                      subtitle: Visibility(
                        visible: index == 3 || index == 2 || index == 6,
                        child: Text(
                          "03/12/11 at 12.30 PM",
                          style: TextStyles.caption(
                              context: context, color: themeProvider.hintColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 24),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetails(), fullscreenDialog: true));
          },
          backgroundColor: themeProvider.accentColor,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
