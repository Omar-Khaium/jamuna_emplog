import 'package:emplog/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'attendance.g.dart';

@HiveType(adapterName: "AttendanceAdapter", typeId: tableAttendance)
class Attendance {
  @HiveField(0)
  String guid;
  @HiveField(1)
  String dateTime;
  @HiveField(2)
  double latitude;
  @HiveField(3)
  double longitude;
  @HiveField(4)
  String location;
  @HiveField(5)
  String event;
  @HiveField(6)
  String duration;
  @HiveField(7)
  String picture;

  Attendance(
      {@required this.guid,
      @required this.dateTime,
      @required this.latitude,
      @required this.longitude,
      @required this.location,
      @required this.event,
      @required this.duration,
      @required this.picture});
}
