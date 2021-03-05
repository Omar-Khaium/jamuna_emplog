import 'package:emplog/model/attendance_item.dart';
import 'package:emplog/utils/constants.dart';
import 'package:flutter/material.dart';

class Attendance {
  String guid;
  String dateTime;
  AttendanceType event;
  String duration;
  List<AttendanceItem> items = [];

  Attendance({@required this.guid, @required this.dateTime, @required this.event, @required this.duration, this.items});
}