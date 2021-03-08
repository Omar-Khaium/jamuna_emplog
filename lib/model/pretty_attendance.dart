import 'package:emplog/model/pretty_attendance_item.dart';
import 'package:flutter/material.dart';

class PrettyAttendance {
  String guid;
  String dateTime;
  double latitude;
  double longitude;
  String location;
  String event;
  String duration;
  String picture;
  List<PrettyAttendanceItem> items = [];

  PrettyAttendance(
      {@required this.guid,
      @required this.dateTime,
      @required this.latitude,
      @required this.longitude,
      @required this.location,
      @required this.event,
      @required this.duration,
      @required this.picture,
      this.items});
}
