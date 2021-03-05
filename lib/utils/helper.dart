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