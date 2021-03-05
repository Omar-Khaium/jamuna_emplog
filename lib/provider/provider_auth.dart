import 'package:emplog/model/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuthProvider extends ChangeNotifier {
  User user;
  Box<User> userBox;

  init() async {
    if (user == null) {
      if (Hive.isBoxOpen("users")) {
        userBox = Hive.box("users");
      } else {
        userBox = await Hive.openBox("users");
      }
      if (userBox.length > 0) {
        user = userBox.getAt(0);
      } else {
        user = User();
      }
    }
  }

  bool get hasPreviousAuth => user != null && (user.isFingerPrintSaved ?? false);

  Future<bool> loginWithCredential(String email, String password) async {
    try {
      user.id = DateTime.now().millisecondsSinceEpoch;
      user.name = "John Doe";
      user.profilePicture = "";
      user.phone = "01712-345678";
      user.email = email;
      user.password = password;
      user.isAuthenticated = true;
      user.isFingerPrintSaved = true;
      saveChanges();
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> loginWithBiometric() async {
    return true;
  }

  saveChanges() {
    if (userBox.isEmpty) {
      userBox.add(user);
    } else {
      userBox.putAt(0, user);
    }
  }

  logout() {
    user.isAuthenticated = false;
    saveChanges();
  }
}
