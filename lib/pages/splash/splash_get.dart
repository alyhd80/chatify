import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/cacheManager/user.cache.dart';
import 'package:chatify/contants/config.dart';
import 'package:chatify/services/offlineMessages_servuces.dart';
import 'package:chatify/services/tokenFresher_service.dart';
import 'package:get/get.dart';

import '../../init.dart';

class SplashGet extends GetxController {
  @override
  void onInit() {
    _init();

    super.onInit();
  }

  Future<void> _init() async {
    await UserCacheManager.checkLogIn();
    if (UserCacheManager.isUserLogIn) {
      Config.me = UserCacheManager.getUserData();

      ///refresh token
      final service = TokenFresherService();
      await service.call({
        "userId": Config.me!.userId,
        "userName": Config.me!.username,
      });
      Config.me = UserCacheManager.getUserData();
      AppInit().initSocketClient();
      await HiveCacheManager().init();

      ///get latest offline messages
      final offlineMsgServices = OfflineMessagesServices();
     await offlineMsgServices.call({
        'userId': Config.me!.userId,
      });

      ///Route user to messages list
      Get.offAllNamed(PageRoutes.messages);
    } else {
      Get.offAllNamed(PageRoutes.welcome);
    }
  }
}
