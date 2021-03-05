import 'dart:collection';

import 'package:emplog/model/attendance.dart';
import 'package:emplog/model/attendance_item.dart';
import 'package:emplog/model/user.dart';
import 'package:emplog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

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
      int position = list.indexWhere((element) => stringToDateTime(element.dateTime).difference(stringToDateTime(attendance.dateTime)).inDays == 0) ?? -1;

      if (position != -1) {
        list[position].items.add(AttendanceItem(time: attendance.dateTime, duration: attendance.duration, event: attendance.event));
      } else {
        list.add(
          Attendance(
            items: [AttendanceItem(time: attendance.dateTime, duration: attendance.duration, event: attendance.event)],
            event: attendance.event,
            dateTime: attendance.dateTime,
            duration: attendance.duration,
            guid: attendance.guid,
          ),
        );
      }
    });
    return list;
  }

  DateTime stringToDateTime(String date) {
    DateTime dateTime = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").parse(date.contains(".") ? date : "$date.000");
    return dateTime;
  }

  Future<void> loadAttendances() async {
    items["11"] = Attendance(guid: "11", dateTime: "2021-03-05'T'19:24:11.111", event: AttendanceType.Out, duration: "9 hours");
    items["22"] = Attendance(guid: "22", dateTime: "2021-03-05'T'09:24:11.111", event: AttendanceType.In, duration: "9 hours");
    items["33"] = Attendance(guid: "33", dateTime: "2021-03-04'T'19:12:11.111", event: AttendanceType.Out, duration: "9 hours");
    items["44"] = Attendance(guid: "44", dateTime: "2021-03-04'T'17:24:11.111", event: AttendanceType.In, duration: "9 hours");
    items["55"] = Attendance(guid: "55", dateTime: "2021-03-04'T'17:12:11.111", event: AttendanceType.Out, duration: "9 hours");
    items["66"] = Attendance(guid: "66", dateTime: "2021-03-04'T'11:24:11.111", event: AttendanceType.In, duration: "9 hours");
    items["77"] = Attendance(guid: "77", dateTime: "2021-03-04'T'11:12:11.111", event: AttendanceType.Out, duration: "9 hours");
    items["88"] = Attendance(guid: "88", dateTime: "2021-03-04'T'09:24:11.111", event: AttendanceType.In, duration: "9 hours");
    items["133"] = Attendance(guid: "133", dateTime: "2021-03-03'T'19:02:11.111", event: AttendanceType.Out, duration: "9 hours");
    items["144"] = Attendance(guid: "144", dateTime: "2021-03-03'T'14:24:11.111", event: AttendanceType.In, duration: "9 hours");
    items["155"] = Attendance(guid: "155", dateTime: "2021-03-03'T'14:12:11.111", event: AttendanceType.Out, duration: "9 hours");
    items["66"] = Attendance(guid: "66", dateTime: "2021-03-03'T'09:12:11.111", event: AttendanceType.In, duration: "9 hours");
    items["77"] = Attendance(guid: "77", dateTime: "2021-03-02'T'11:12:11.111", event: AttendanceType.Out, duration: "9 hours");
    items["88"] = Attendance(guid: "88", dateTime: "2021-03-02'T'09:24:11.111", event: AttendanceType.In, duration: "9 hours");
  }
}
