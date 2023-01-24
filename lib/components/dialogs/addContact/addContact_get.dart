import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/contants/config.dart';
import 'package:chatify/models/contact.dart';
import 'package:chatify/pages/messages/messages_get.dart';
import 'package:chatify/services/addContact_service.dart';
import 'package:get/get.dart';

class AddContactGet extends GetxController {
  var username = "".obs;
  var loading = false.obs;

  Future<void> add() async {
    if (username.value.isEmpty) {
      Config.errorHandler(
          message: "You have to enter username", title: "Error");
      return;
    }
    if (!loading.value) {
      final service = AddContactService();
      final result = await service.call({'username': username.value});

      if (result != null) {
        loading.value = false;
        final messagesGet=Get.find<MessagesGet>();
        await HiveCacheManager().save(Contact(user: result,messages: []));
        messagesGet.init();
        Get.back();
        Get.toNamed(PageRoutes.chat,arguments: result);
      }
      loading.value = false;

    }

  }
}
