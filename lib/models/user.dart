import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String fullname;
  @HiveField(2)
  String username;

  User({required this.id, required this.fullname, required this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["_id"],
        fullname: json["fullName"],
        username: json["userName"]);
  }

  factory User.fromSicketJson(Map<String, dynamic> json) {
    return User(
        id: json["userId"],
        fullname: json["fullname"],
        username: json["username"]);
  }
}
