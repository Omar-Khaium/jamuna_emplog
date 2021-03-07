import 'package:emplog/utils/constants.dart';
import 'package:flutter/material.dart';

class PrettyAttendanceItem {
  String guid;
  String time;
  double latitude;
  double longitude;
  String location;
  AttendanceType event;
  String duration;
  String picture;

  PrettyAttendanceItem(
      {@required this.guid,
      @required this.time,
      @required this.latitude,
      @required this.longitude,
      @required this.location,
      @required this.event,
      @required this.duration,
      @required this.picture});
}
