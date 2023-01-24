import 'dart:convert';

import 'package:chatify/contants/config.dart';
import 'package:chatify/services/base.dart';
import 'package:http/http.dart' as http;

import '../cacheManager/user.cache.dart';

class RegisterService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/register');

  Future<bool> call(Map<String, dynamic> args) async {
    final client = http.Client();
    final response = await client.post(url, body: args);
    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Config.errorHandler(
          title: decodedResponse["error_code"],
          message: decodedResponse["message"]);

      await UserCacheManager.save(
          fullName: args["fullname"],
          userId: decodedResponse["data"]["insertedId"],
          username: args["username"],
          token: decodedResponse["data"]["token"]);

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
