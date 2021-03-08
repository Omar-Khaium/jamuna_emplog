import 'dart:collection';

import 'package:emplog/model/db/attendance.dart';
import 'package:emplog/model/outlet.dart';
import 'package:emplog/model/pretty_attendance.dart';
import 'package:emplog/model/pretty_attendance_item.dart';
import 'package:emplog/model/db/user.dart';
import 'package:emplog/model/shop.dart';
import 'package:emplog/utils/fake_database.dart';
import 'package:emplog/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class AttendanceProvider extends ChangeNotifier {
  Map<String, PrettyAttendance> items = HashMap<String, PrettyAttendance>();

  bool isNetworking = false;
  bool isCheckedIn = false;
  bool useFakeLocation = false;

  double distanceFilter = 50;

  LocationData currentLocation;

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

  trackLocation() async {
    Location()
      ..changeSettings(accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 1)
      ..onLocationChanged().listen((event) {
        currentLocation = event;
        notifyListeners();
      });
  }

  List<PrettyAttendance> getAll() {
    List<PrettyAttendance> list = items.values.toList();
    list.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    list = parseHistory(list);
    list.forEach((element) {
      element.items.sort((a, b) => DateFormat("yyyy-MM-dd HH:mm:ss").parse(b.time).compareTo(DateFormat("yyyy-MM-dd HH:mm:ss").parse(a.time)));
    });
    isCheckedIn = list.first.items.first.event=="In";
    return list;
  }

  List<Outlet> getAllOutlets() {
    List<Outlet> list = [];
    outlets.forEach((element) {
      if (useFakeLocation || currentLocation == null) {
        if (isInMockArea(element.latitude, element.longitude)) {
          list.add(element);
        }
      } else {
        if (isInArea(element.latitude, element.longitude)) {
          list.add(element);
        }
      }
    });
    if (useFakeLocation || currentLocation == null) {
      list.sort(
          (b, a) => calculateDistance(b.latitude, b.longitude, fakeLatitude, fakeLongitude).compareTo(calculateDistance(a.latitude, a.longitude, fakeLatitude, fakeLongitude)));
    } else {
      list.sort((b, a) => calculateDistance(b.latitude, b.longitude, fakeLatitude, fakeLongitude)
          .compareTo(calculateDistance(a.latitude, a.longitude, currentLocation.longitude, currentLocation.longitude)));
    }
    return list;
  }

  List<Shop> getAllShops() {
    List<Shop> list = [];
    shops.forEach((element) {
      if (useFakeLocation || currentLocation == null) {
        if (isInMockArea(element.latitude, element.longitude)) {
          list.add(element);
        }
      } else {
        if (isInArea(element.latitude, element.longitude)) {
          list.add(element);
        }
      }
    });
    if (useFakeLocation || currentLocation == null) {
      list.sort(
          (b, a) => calculateDistance(b.latitude, b.longitude, fakeLatitude, fakeLongitude).compareTo(calculateDistance(a.latitude, a.longitude, fakeLatitude, fakeLongitude)));
    } else {
      list.sort((b, a) => calculateDistance(b.latitude, b.longitude, fakeLatitude, fakeLongitude)
          .compareTo(calculateDistance(a.latitude, a.longitude, currentLocation.longitude, currentLocation.longitude)));
    }
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

  toggleFakeLocation() {
    useFakeLocation = !useFakeLocation;
    notifyListeners();
  }

  checkIn(Attendance attendance, bool isOffline) {
    if(isOffline) {
      attendanceBox.add(attendance);
    }
    items[attendance.guid] = PrettyAttendance(
        guid: attendance.guid,
        dateTime: attendance.dateTime,
        latitude: attendance.latitude,
        longitude: attendance.longitude,
        location: attendance.location,
        event: attendance.event,
        duration: attendance.duration,
        picture: attendance.picture);
    isCheckedIn = true;
    notifyListeners();
  }

  visitShop(Attendance attendance, bool isOffline) {
    if(isOffline) {
      attendanceBox.add(attendance);
    }
    items[attendance.guid] = PrettyAttendance(
        guid: attendance.guid,
        dateTime: attendance.dateTime,
        latitude: attendance.latitude,
        longitude: attendance.longitude,
        location: attendance.location,
        event: attendance.event,
        duration: attendance.duration,
        picture: attendance.picture);
    notifyListeners();
  }

  checkOut(bool offline) {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getAll().first.items.first.time);
    DateTime now = DateTime.now();
    String duration = "${now.difference(dateTime).inHours} hours ${now.difference(dateTime).inMinutes} minutes";
    Attendance attendance = Attendance(
        guid: now.toIso8601String(),
        dateTime: DateFormat("yyyy-MM-dd HH:mm:ss").format(now),
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        location: "",
        event: "Out",
        duration: duration,
        picture: "");
    if(offline) {
      attendanceBox.add(attendance);
    }
    items[attendance.guid] = PrettyAttendance(
        guid: attendance.guid,
        dateTime: attendance.dateTime,
        latitude: attendance.latitude,
        longitude: attendance.longitude,
        location: attendance.location,
        event: attendance.event,
        duration: attendance.duration,
        picture: attendance.picture);
    isCheckedIn = false;
    notifyListeners();

  }

  applyDistanceFilter(double value) {
    distanceFilter =value;
    notifyListeners();
  }

  bool get hasUnSyncedData => attendanceBox.isNotEmpty;
  int get unSyncedData => attendanceBox.length;
  void clearUnSyncedData() {
    while(attendanceBox.isNotEmpty) {
      attendanceBox.deleteAt(0);
    }
    notifyListeners();
  }

  bool isInArea(double lat, double lng) {
    return calculateDistance(lat, lng, currentLocation.latitude, currentLocation.longitude) <= distanceFilter;
  }

  bool isInMockArea(double lat, double lng) {
    return calculateDistance(lat, lng, fakeLatitude, fakeLongitude) <= distanceFilter;
  }
}
