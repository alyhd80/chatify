import 'package:chatify/models/me.dart';
import 'package:get_storage/get_storage.dart';

class UserCacheManager {
  UserCacheManager._();

  static bool isUserLogIn = false;

  static const String User_Id_Key = "--user-id-key";
  static const String User_Name_Key = "--user-name-key";
  static const String User_Fullname_Key = "--user-fullname-key";
  static const String User_Token_Key = "--user-token-key";

  static Me getUserData() {
    final box = GetStorage();
    return Me(
        userId: box.read(User_Id_Key),
        username: box.read(User_Name_Key),
        fullname: box.read(User_Fullname_Key) ?? "",
        token: box.read(User_Token_Key));
  }

  static Future<void> save(
      {String? userId,
      String? fullName,
      String? username,
      String? token}) async {
    final box = GetStorage();
    if (userId != null) await box.write(User_Id_Key, userId);
    if (username != null) await box.write(User_Name_Key, username);
    if (fullName != null) await box.write(User_Fullname_Key, fullName);
    if (token != null) await box.write(User_Token_Key, token);
  }

  static Future<void> checkLogIn() async {
    final box = GetStorage();

    final userId = await box.read(User_Id_Key);
    final username = await box.read(User_Name_Key);
    final userfullname = await box.read(User_Fullname_Key);
    final usertoken = await box.read(User_Token_Key);
    if (userId != null) {
      print("user id : " + userId);
      print("user name : " + username);
      print("user fullname : " + userfullname);
      print("user token : " + usertoken);
    }
    UserCacheManager.isUserLogIn = userId != null ? true : false;
  }

  static Future<void> clear() async {
    final box = GetStorage();
    await box.erase();
  }
}
