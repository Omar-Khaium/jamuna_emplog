import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Color accentColor = Colors.teal;
  Color backgroundColor = Colors.white;
  Color secondaryColor = Colors.grey.shade100;
  Color textColor = Colors.grey.shade800;
  Color iconColor = Colors.grey.shade700;
  Color shadowColor = Colors.black12;
  Color hintColor = Colors.grey;
  Color errorColor = Colors.red.shade300;
  Color tagColor = Colors.teal.withOpacity(.3);
}
