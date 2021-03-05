import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

class InternetProvider extends ChangeNotifier {
  bool _hasInternet = false;

  bool get connected => _hasInternet;

  bool get notConnected => !_hasInternet;

  listen() async {
    DataConnectionChecker().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case DataConnectionStatus.disconnected:
          _hasInternet = false;
          notifyListeners();
          break;
        case DataConnectionStatus.connected:
          _hasInternet = true;
          notifyListeners();
          break;
      }
    });
  }
}
