import 'package:flutter/cupertino.dart';

class Shop {
  String guid;
  String name;
  String logo;
  String address;
  String phone;
  String contactPerson;
  double latitude;
  double longitude;

  Shop({@required this.guid, @required this.name, @required this.logo, @required this.address, @required this.phone, @required this.contactPerson, this.latitude, this.longitude});
}
