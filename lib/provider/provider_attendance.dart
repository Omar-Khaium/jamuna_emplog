import 'dart:collection';

import 'package:emplog/model/db/attendance.dart';
import 'package:emplog/model/db/user.dart';
import 'package:emplog/model/outlet.dart';
import 'package:emplog/model/pretty_attendance.dart';
import 'package:emplog/model/pretty_attendance_item.dart';
import 'package:emplog/model/shop.dart';
import 'package:emplog/utils/fake_database.dart';
import 'package:emplog/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class AttendanceProvider extends ChangeNotifier {
  Map<String, PrettyAttendance> items = HashMap<String, PrettyAttendance>();

  bool isNetworking = false;
  bool isCheckedIn;
  bool useFakeLocation = false;

  double distanceFilter = 50;

  LocationData currentLocation;

  User user;
  Box<User> userBox;
  Box<Attendance> attendanceBox;

  //notification properties
  final FlutterLocalNotificationsPlugin plugin = new FlutterLocalNotificationsPlugin();
  var initializeAndroidSettings;
  var initializeIOSSettings;
  var initializeSettings;
  NotificationDetails platformChannelSpecifics;
  var androidPlatformChannelSpecifics = AndroidNotificationDetails('emplog_notification', 'emplog_notification', 'emplog_notification',
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'), playSound: true, visibility: NotificationVisibility.public);

  IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
    presentBadge: true,
    badgeNumber: 1,
    presentAlert: true,
    presentSound: true,
  );

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

    platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    initializeAndroidSettings = new AndroidInitializationSettings("logo");
    initializeIOSSettings = new IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    initializeSettings = InitializationSettings(android: initializeAndroidSettings, iOS: initializeIOSSettings);
    plugin.initialize(initializeSettings);
    _createNotificationChannel();
  }

  trackLocation() async {
    Location()
      ..changeSettings(accuracy: LocationAccuracy.navigation, distanceFilter: 1)
      ..onLocationChanged.listen((event) async {
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
    list.forEach((element) {
      if (isCheckedIn == null) {
        element.items.forEach((item) {
          if (isCheckedIn == null) {
            if (item.event == "In") {
              isCheckedIn = true;
              return;
            } else if (item.event == "Out") {
              isCheckedIn = false;
              return;
            }
          } else {
            return;
          }
        });
      } else {
        return;
      }
    });
    isCheckedIn = isCheckedIn ?? false;
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

  checkIn(Attendance attendance, bool isOffline, String guid) {
    if (isOffline) {
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
    if (notificationHistory.contains(guid)) {
      notificationHistory.remove(guid);
    }
    notifyListeners();
  }

  visitShop(Attendance attendance, bool isOffline, String guid) {
    if (isOffline) {
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
    if (notificationHistory.contains(guid)) {
      notificationHistory.remove(guid);
    }
    notifyListeners();
  }

  checkOut(bool offline) {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getAll().first.items.first.time);
    DateTime now = DateTime.now();
    String duration = "${now.difference(dateTime).inHours}h ${60 % now.difference(dateTime).inMinutes}m ${60 % now.difference(dateTime).inSeconds}s";
    Attendance attendance = Attendance(
        guid: now.toIso8601String(),
        dateTime: DateFormat("yyyy-MM-dd HH:mm:ss").format(now),
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
        location: getAll().first.items.first.location,
        event: "Out",
        duration: duration,
        picture: "");
    if (offline) {
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
    String guid;
    getAll().forEach((element) {
      if (guid == null) {
        element.items.forEach((item) {
          if (item.event == "In") {
            guid = item.guid;
            return;
          }
        });
      } else {
        return;
      }
    });
    if (notificationHistory.contains(guid)) {
      notificationHistory.remove(guid);
    }
    isCheckedIn = false;
    notifyListeners();
  }

  applyDistanceFilter(double value) {
    distanceFilter = value;
    notifyListeners();
  }

  bool get hasUnSyncedData => attendanceBox.isNotEmpty;

  int get unSyncedData => attendanceBox.length;

  void clearUnSyncedData() {
    while (attendanceBox.isNotEmpty) {
      attendanceBox.deleteAt(0);
    }
    notifyListeners();
  }

  bool isInArea(double lat, double lng) {
    return currentLocation != null && calculateDistance(lat, lng, currentLocation.latitude, currentLocation.longitude) <= distanceFilter;
  }

  bool isInMockArea(double lat, double lng) {
    return calculateDistance(lat, lng, fakeLatitude, fakeLongitude) <= distanceFilter;
  }

  Future<void> _createNotificationChannel() async {
    var androidNotificationChannel = AndroidNotificationChannel(
      'emplog_notification',
      'emplog_notification',
      'emplog_notification',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      enableVibration: true,
      enableLights: true,
    );
    await plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);
  }

  trackNearbyOutlet() async {
    outlets.forEach((outlet) async {
      if (getAll().first.items.first.location == outlet.branch && isCheckedIn && !isInArea(outlet.latitude, outlet.longitude) && !notificationHistory.contains(outlet.guid)) {
        notificationHistory.add(outlet.guid);
        plugin.show(
            DateTime.now().millisecond,
            outlet.branch,
            "Seems like you are out of ${outlet.branch}'s "
            "area. Do you wanna check-out from ${outlet.branch}?",
            platformChannelSpecifics);
      } else if (!isCheckedIn && isInArea(outlet.latitude, outlet.longitude) && !notificationHistory.contains(outlet.guid)) {
        notificationHistory.add(outlet.guid);
        plugin.show(
            DateTime.now().millisecond, outlet.branch, "Seems like you are nearby ${outlet.branch}'s area. Do you wanna check-in to ${outlet.branch}?", platformChannelSpecifics);
      }
    });
  }

  trackNearbyShop() async {
    shops.forEach((shop) async {
      if (isInArea(shop.latitude, shop.longitude) && !didVisitedThisShopToday(shop.name)) {
        if (!notificationHistory.contains(shop.guid)) {
          notificationHistory.add(shop.guid);
          plugin.show(DateTime.now().millisecond, shop.name, "Do you wanna check-in at ${shop.name}?", platformChannelSpecifics);
        }
      }
    });
  }

  bool didVisitedThisShopToday(String name) {
    return items.values
        .where((element) =>
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(element.dateTime).difference(DateTime.now()).inDays == 0 && element.event == "ShopVisit" && element.location == name)
        .isNotEmpty;
  }

  String lastShopVisitTime(String name) {
    return items.values
        .firstWhere((element) =>
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(element.dateTime).difference(DateTime.now()).inDays == 0 && element.event == "ShopVisit" && element.location == name)
        .dateTime;
  }
}
