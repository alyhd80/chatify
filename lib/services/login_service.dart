import 'dart:convert';

import 'package:chatify/contants/config.dart';
import 'package:chatify/services/base.dart';
import 'package:http/http.dart' as http;

import '../cacheManager/user.cache.dart';

class LoginService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/singin');


  Future<bool> call(Map<String, dynamic> args) async {
    final client = http.Client();
    final response = await client.post(url, body: args);
    final decodedResponse = jsonDecode(response.body);

    print(response.body);
    if (response.statusCode == 200) {
      Config.errorHandler(
          title: decodedResponse["error_code"],
          message: decodedResponse["message"]);

      await UserCacheManager.save(
          fullName: decodedResponse["data"]["fullName"],
          userId: decodedResponse["data"]["_id"],
          username: decodedResponse["data"]["userName"],
          token: decodedResponse["data"]["token"]);

      print(decodedResponse["data"]["fullName"]);
      print(decodedResponse["data"]["_id"]);
      print(decodedResponse["data"]["userName"]);
      print(decodedResponse["data"]["token"]);




      await Future.delayed(const Duration(seconds: 2));
      return true;
    } else {
      Config.errorHandler(
          title: decodedResponse["error_code"],
          message: decodedResponse["message"]);
      return false;
    }

    return false;
  }
}
