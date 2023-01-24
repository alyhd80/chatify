import 'package:get/get.dart';

import '../../cacheManager/user.cache.dart';
import '../../contants/config.dart';
import '../../services/register_services.dart';

class RegisterGet extends GetxController {
  var fullname = ''.obs;
  var username = ''.obs;
  var password = ''.obs;

  var loading = false.obs;

  void createNewAccount() async {
    if (fullname.value.isEmpty ||
        username.value.isEmpty ||
        password.value.isEmpty) {
      Config.errorHandler(
          title: 'Empty fields', message: 'Please enter all the fields!');
      return;
    }

    if (!loading.value) {
      loading.value = true;

      try {
        final service = RegisterService();
        var result = await service.call({
          "fullname": fullname.value,
          "username": username.value,
          "password": password.value
        });
        loading.value = false;
        if (result) {
          Config.me=UserCacheManager.getUserData();
          Get.offAllNamed(PageRoutes.splash);
        }
      } catch (er) {
        Config.errorHandler(title: 'Error', message: er.toString());
        loading.value = false;
      }
    }
  }
}
