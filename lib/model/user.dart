import 'package:emplog/utils/constants.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(adapterName: "UserAdapter", typeId: tableUser)
class User {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String profilePicture;
  @HiveField(3)
  String phone;
  @HiveField(4)
  String email;
  @HiveField(5)
  String position;
  @HiveField(6)
  String password;
  @HiveField(7)
  bool isAuthenticated;
  @HiveField(8)
  bool isFingerPrintSaved;
  @HiveField(9)
  String token;
  @HiveField(10)
  int expiresIn;

  User({this.id, this.name, this.profilePicture, this.phone, this.email, this.position, this.password, this.isAuthenticated, this.isFingerPrintSaved, this.token, this.expiresIn});
}
