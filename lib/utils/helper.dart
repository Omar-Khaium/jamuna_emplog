import 'dart:math';

import 'package:intl/intl.dart';

class Helper {
  static List<DateTime> getCurrentMonth() {
    List<DateTime> list = [];

    DateTime firstDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime lastDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 1).subtract(Duration(days: 1));
    DateTime nextMonthFirstDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 1);

    String firstDay = DateFormat("E").format(firstDate).toLowerCase();

    switch (firstDay) {
      case "mon":
        break;
      case "tue":
        List.generate(1, (index) {
          list.add(firstDate.subtract(Duration(days: 1 - index)));
        });
        break;
      case "wed":
        List.generate(2, (index) {
          list.add(firstDate.subtract(Duration(days: 2 - index)));
        });
        break;
      case "thu":
        List.generate(3, (index) {
          list.add(firstDate.subtract(Duration(days: 3 - index)));
        });
        break;
      case "fri":
        List.generate(4, (index) {
          list.add(firstDate.subtract(Duration(days: 4 - index)));
        });
        break;
      case "sat":
        List.generate(5, (index) {
          list.add(firstDate.subtract(Duration(days: 5 - index)));
        });
        break;
      case "sun":
        List.generate(6, (index) {
          list.add(firstDate.subtract(Duration(days: 6 - index)));
        });
        break;
    }

    List.generate(lastDate.difference(firstDate).inDays + 1, (index) {
      list.add(firstDate.add(Duration(days: index)));
    });

    List.generate(35 - list.length, (index) {
      list.add(nextMonthFirstDate.add(Duration(days: index)));
    });
    return list;
  }

  static bool isPreviousMonth(DateTime date) {
    return date.month < DateTime.now().month;
  }

  static bool isNextMonth(DateTime date) {
    return date.month > DateTime.now().month;
  }
}

DateTime stringToDateTime(String date) {
  DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
  return dateTime;
}

String dateTimeToStringDate(DateTime date, String pattern) => DateFormat(pattern).format(date);

String dateTimeToStringTime(DateTime date, String pattern) => DateFormat(pattern).format(date);

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a)) * 1000;
}

String prettyDistance(double meter) {
  if (meter > 1000) {
    return "${(meter / 1000).toStringAsFixed(2)}km";
  }else {
    return "${(meter).toStringAsFixed(2)}m";
  }
}
