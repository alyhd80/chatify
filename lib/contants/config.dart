import 'package:chatify/contants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../models/me.dart';

class Config {
  Config._();

  static const httpsServicesBaseUrl = "http://10.0.2.2:8888";
  static const socketServicesBaseUrl = "http://10.0.2.2:8888";

  static String showAvatarBaseUrl(String userId) =>
      '${Config.httpsServicesBaseUrl}/avatar/${userId}';

  static Me? me;

  static ThemeData primaryThemeData = ThemeData(
      primarySwatch: Colors.green,
      fontFamily: "Nexa",
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8)),
          focusColor: Colors.black,
          iconColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(8)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      appBarTheme: const AppBarTheme(
          toolbarHeight: 69,
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black, size: 24),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: MyTextStyles.appbar));

  static void errorHandler({String title = '', String message = ''}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.grey.withOpacity(0.2),
      colorText: Colors.black,
      icon: Icon(
        Icons.error,
        color: Colors.red,
      ),
      duration: const Duration(seconds: 4),
    );
  }
}

class PageRoutes {
  PageRoutes._();

  static const String welcome = "/welcome";
  static const String register = "/register";
  static const String signIn = "/sign-in";
  static const String messages = "/messages";
  static const String settings = "/settings";
  static const String splash = "/splash";
  static const String chat = "/chat";
}
