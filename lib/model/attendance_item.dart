import 'package:emplog/utils/constants.dart';
import 'package:flutter/material.dart';

class AttendanceItem {
  String time;
  AttendanceType event;
  String duration;
  String location;

  AttendanceItem({@required this.time, @required this.event, @required this.duration, @required this.location});
}