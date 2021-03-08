import 'package:emplog/provider/provider_theme.dart';
import 'package:emplog/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NoteDetails extends StatefulWidget {
  @override
  _NoteDetailsState createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  TextEditingController noteController = TextEditingController();

  bool _isChecked = true;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final maxLines = 5;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.backgroundColor,
      appBar: AppBar(
        backgroundColor: themeProvider.backgroundColor,
        elevation: 0,
        title: Text(
          "Add Note",
          style: TextStyles.body(
              context: context, color: themeProvider.accentColor),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        padding: EdgeInsets.all(16),
        scrollDirection: Axis.vertical,
        children: [
          Text(
            "Note",
            style: TextStyles.caption(
                context: context, color: themeProvider.textColor),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: maxLines * 24.0,
            child: TextField(
              maxLines: maxLines,
              controller: noteController,
              keyboardType: TextInputType.text,
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
              cursorColor: themeProvider.accentColor,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                isDense: true,
                fillColor: themeProvider.secondaryColor,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(4)),
                contentPadding: EdgeInsets.all(16),
                hintText: "Type note here...",
                hintStyle: TextStyles.body(
                    context: context, color: themeProvider.hintColor),
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            children: [
              ActionChip(
                visualDensity: VisualDensity.compact,
                label: Text(
                  "Hey i am here",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.textColor),
                ),
                onPressed: () {
                  setState(() {
                    noteController.text = "Hey i am here";
                  });
                },
                backgroundColor: themeProvider.accentColor.withOpacity(.08),
              ),
              ActionChip(
                visualDensity: VisualDensity.compact,
                label: Text(
                  "Shop is closed",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.textColor),
                ),
                onPressed: () {
                  setState(() {
                    noteController.text = "Shop is closed";
                  });
                },
                backgroundColor: themeProvider.accentColor.withOpacity(.08),
              ),
              ActionChip(
                visualDensity: VisualDensity.compact,
                label: Text(
                  "Shop checked successfully",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.textColor),
                ),
                onPressed: () {
                  setState(() {
                    noteController.text = "Shop checked successfully";
                  });
                },
                backgroundColor: themeProvider.accentColor.withOpacity(.08),
              ),
              ActionChip(
                visualDensity: VisualDensity.compact,
                label: Text(
                  "Due money",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.textColor),
                ),
                onPressed: () {
                  setState(() {
                    noteController.text = "Due money";
                  });
                },
                backgroundColor: themeProvider.accentColor.withOpacity(.08),
              ),
              ActionChip(
                visualDensity: VisualDensity.compact,
                label: Text(
                  "Cash received",
                  style: TextStyles.caption(
                      context: context, color: themeProvider.textColor),
                ),
                onPressed: () {
                  setState(() {
                    noteController.text = "Cash received";
                  });
                },
                backgroundColor: themeProvider.accentColor.withOpacity(.08),
              ),
              ActionChip(
                  backgroundColor: themeProvider.accentColor.withOpacity(.08),
                  visualDensity: VisualDensity.compact,
                  avatar: Icon(Icons.add),
                  onPressed: () {},
                  label: Text(
                    "Add template",
                    style: TextStyles.caption(
                        context: context, color: themeProvider.textColor),
                  ))
            ],
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.all(0),
            title: Text(
              "Reminder available",
              style: TextStyles.body(
                  context: context, color: themeProvider.textColor),
            ),
            value: _isChecked,
            onChanged: (val) {
              setState(() {
                _isChecked = val;
              });
            },
          ),
          Visibility(
            visible: _isChecked,
            child: ListTile(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.only(left: 8),
              leading: Icon(
                Icons.calendar_today_outlined,
                color: themeProvider.accentColor,
              ),
              title: Container(
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text(
                      "${selectedDate.toString()}".split(' ')[0],
                      textAlign: TextAlign.left,
                      style: TextStyles.body(
                          context: context, color: themeProvider.textColor),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text("Save",
                  style: TextStyles.body(
                      context: context, color: themeProvider.backgroundColor))),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
