import 'package:chatify/contants/config.dart';
import 'package:chatify/models/user.dart';
import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 1)
class Message extends HiveObject {
  @HiveField(0)
  final User? user;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  bool seen = false;

  Message(
      {required this.user,
      required this.message,
      required this.date,
      this.seen = false});

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      user: User.fromSicketJson(json["from"]),
      message: json["message"],
      date: DateTime.now());

  bool isMyMessage() {
    return Config.me!.userId == user!.id;
  }
}
