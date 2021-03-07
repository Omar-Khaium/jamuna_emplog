import 'dart:collection';

import 'package:emplog/model/db/attendance.dart';
import 'package:emplog/model/pretty_attendance.dart';
import 'package:emplog/model/pretty_attendance_item.dart';
import 'package:emplog/model/db/user.dart';
import 'package:emplog/utils/fake_database.dart';
import 'package:emplog/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AttendanceProvider extends ChangeNotifier {
  Map<String, PrettyAttendance> items = HashMap<String, PrettyAttendance>();

  bool isNetworking = false;
  bool isCheckedIn = false;

  User user;
  Box<User> userBox;
  Box<Attendance> attendanceBox;

  init() {
    userBox = Hive.box("users");
    attendanceBox = Hive.box("attendances");

    if (items.isEmpty) {
      attendances.forEach((element) {
        items[element.guid] = PrettyAttendance(
            guid: element.guid,
            dateTime: element.dateTime,
            latitude: element.latitude,
            longitude: element.longitude,
            location: element.location,
            event: element.event,
            duration: element.duration,
            picture: element.picture);
      });
    }
    if (userBox.length > 0) {
      user = userBox.getAt(0);
    }
    attendanceBox.values.forEach((element) {
      items[element.guid] = PrettyAttendance(
          guid: element.guid,
          dateTime: element.dateTime,
          latitude: element.latitude,
          longitude: element.longitude,
          location: element.location,
          event: element.event,
          duration: element.duration,
          picture: element.picture);
    });
  }

  List<PrettyAttendance> getAll() {
    List<PrettyAttendance> list = items.values.toList();
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    list = parseHistory(list);
    return list;
  }

  PrettyAttendance findHistoryByID(String guid) => items[guid];

  void destroy() {
    isNetworking = false;
    items = {};
    notifyListeners();
  }

  List<PrettyAttendance> parseHistory(List<PrettyAttendance> attendanceList) {
    List<PrettyAttendance> list = [];

    attendanceList.forEach((attendance) {
      int position = list.indexWhere((element) {
            return stringToDateTime(element.dateTime).difference(stringToDateTime(attendance.dateTime)).inDays == 0;
          }) ??
          -1;

      if (position != -1) {
        list[position].items.add(PrettyAttendanceItem(
            time: attendance.dateTime,
            duration: attendance.duration,
            event: attendance.event,
            location: attendance.location,
            picture: attendance.picture,
            latitude: attendance.latitude,
            longitude: attendance.longitude,
            guid: attendance.guid));
      } else {
        list.add(
          PrettyAttendance(
              items: [
                PrettyAttendanceItem(
                    time: attendance.dateTime,
                    duration: attendance.duration,
                    event: attendance.event,
                    location: attendance.location,
                    picture: attendance.picture,
                    latitude: attendance.latitude,
                    longitude: attendance.longitude,
                    guid: attendance.guid)
              ],
              dateTime: attendance.dateTime,
              duration: attendance.duration,
              event: attendance.event,
              location: attendance.location,
              picture: attendance.picture,
              latitude: attendance.latitude,
              longitude: attendance.longitude,
              guid: attendance.guid),
        );
      }
    });
    return list;
  }

  toggleAttendanceStatus() {
    isCheckedIn = !isCheckedIn;
    notifyListeners();
  }
}
