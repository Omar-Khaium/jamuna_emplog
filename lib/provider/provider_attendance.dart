import 'dart:collection';

import 'package:emplog/model/attendance.dart';
import 'package:emplog/model/attendance_item.dart';
import 'package:emplog/model/user.dart';
import 'package:emplog/utils/constants.dart';
import 'package:emplog/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AttendanceProvider extends ChangeNotifier {
  Map<String, Attendance> items = HashMap<String, Attendance>();

  bool isNetworking = false;

  User user;
  Box<User> userBox;

  init() {
    userBox = Hive.box("users");
    if (userBox.length > 0) {
      user = userBox.getAt(0);
    }
  }

  List<Attendance> getAll() {
    List<Attendance> list = items.values.toList();
    list.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    list = parseHistory(list);
    return list;
  }

  Attendance findHistoryByID(String guid) => items[guid];

  void destroy() {
    isNetworking = false;
    items = {};
    notifyListeners();
  }

  List<Attendance> parseHistory(List<Attendance> attendanceList) {
    List<Attendance> list = [];

    attendanceList.forEach((attendance) {
      int position = list.indexWhere((element) {
        return stringToDateTime(element.dateTime).difference(stringToDateTime(attendance.dateTime)).inDays == 0;
      }) ?? -1;


      if (position != -1) {
        list[position].items.add(AttendanceItem(time: attendance.dateTime, duration: attendance.duration, event: attendance.event, location: attendance.location));
      } else {
        list.add(
          Attendance(
            items: [AttendanceItem(time: attendance.dateTime, duration: attendance.duration, event: attendance.event, location: attendance.location)],
            event: attendance.event,
            dateTime: attendance.dateTime,
            duration: attendance.duration,
            guid: attendance.guid,
            location: attendance.location
          ),
        );
      }
    });
    return list;
  }

  Future<void> loadAttendances() async {
    items["11"] = Attendance(guid: "11", dateTime: "2021-03-05 19:24:11", event: AttendanceType.Out, duration: "9 hours", location: "Bashundhara Depo");
    items["22"] = Attendance(guid: "22", dateTime: "2021-03-05 09:24:11", event: AttendanceType.In, duration: "9 hours", location: "Bashundhara Depo");
    items["33"] = Attendance(guid: "33", dateTime: "2021-03-04 19:12:11", event: AttendanceType.Out, duration: "9 hours", location: "Bashundhara Depo");
    items["44"] = Attendance(guid: "44", dateTime: "2021-03-04 17:24:11", event: AttendanceType.In, duration: "9 hours", location: "Bhai Bhai Shop");
    items["55"] = Attendance(guid: "55", dateTime: "2021-03-04 17:12:11", event: AttendanceType.Out, duration: "9 hours", location: "Akkas Miya'r tong");
    items["66"] = Attendance(guid: "66", dateTime: "2021-03-04 11:24:11", event: AttendanceType.In, duration: "9 hours", location: "Tanvir vhaiyer Mudi");
    items["77"] = Attendance(guid: "77", dateTime: "2021-03-04 11:12:11", event: AttendanceType.Out, duration: "9 hours", location: "Bashundhara Depo");
    items["88"] = Attendance(guid: "88", dateTime: "2021-03-04 09:24:11", event: AttendanceType.In, duration: "9 hours", location: "Bashundhara Depo");
    items["133"] = Attendance(guid: "133", dateTime: "2021-03-03 19:02:11", event: AttendanceType.Out, duration: "9 hours", location: "Bashundhara Depo");
    items["144"] = Attendance(guid: "144", dateTime: "2021-03-03 14:24:11", event: AttendanceType.In, duration: "9 hours", location: "Bashundhara Depo");
    items["155"] = Attendance(guid: "155", dateTime: "2021-03-03 14:12:11", event: AttendanceType.Out, duration: "9 hours", location: "Bashundhara Depo");
    items["66221"] = Attendance(guid: "66221", dateTime: "2021-03-03 09:12:11", event: AttendanceType.In, duration: "9 hours", location: "Bashundhara Depo");
    items["77221"] = Attendance(guid: "77221", dateTime: "2021-03-02 11:12:11", event: AttendanceType.Out, duration: "9 hours", location: "Bashundhara Depo");
    items["88221"] = Attendance(guid: "88221", dateTime: "2021-03-02 09:24:11", event: AttendanceType.In, duration: "9 hours", location: "Bashundhara Depo");
    notifyListeners();
  }
}
