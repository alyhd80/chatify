import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/contants/config.dart';
import 'package:chatify/init.dart';
import 'package:chatify/models/contact.dart';
import 'package:chatify/models/user.dart';
import 'package:chatify/pages/messages/messages_get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/message.dart';

class ChatGet extends GetxController {
  User? user;
  Contact? contact;
  var message = "".obs;
  AppInit appInit = AppInit();
  List<Message> messages = [];
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  final onUpdateStream = PublishSubject<bool>();

  @override
  void onInit() {
    // TODO: implement onInit
    user = Get.arguments;
    appInit.currentChatUser = user;
    print('${user?.id.toString()}    ${user?.fullname.toString()}');

    onUpdateStream.listen((_) {
      Future.delayed(Duration(milliseconds: 100)).then((_) =>
          scrollController.jumpTo(scrollController.position.maxScrollExtent));
    });
    initContact();
    super.onInit();
  }
  initContact()async{
   contact =(await HiveCacheManager().get(user!.id)) as Contact?;
  await  HiveCacheManager().updateLastSeen(user!.id);
   (Get.find<MessagesGet>()).contactsStream.sink.add(true);
   messages.clear();
   messages.addAll(contact?.messages??[]);
   onUpdateStream.sink.add(true);
   Future.delayed(Duration(milliseconds: 100)).then((_) =>
       scrollController.jumpTo(scrollController.position.maxScrollExtent));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    appInit.currentChatUser = null;
    super.dispose();
  }

  void userInfo() {}

  void send() {
    if (message.value.isEmpty) return;
    appInit.socket?.emit(
        "send-message", {"message": message.value, "to": user?.id ?? ""});
    final myMessage = Message(
        user: Config.me!.exportToUser(),
        message: message.value,
        date: DateTime.now(),seen: true);
    messages.add(myMessage);
    HiveCacheManager().update(user!.id, myMessage);
    message.value = "";
    controller.clear();
    onUpdateStream.sink.add(true);
    // messages=messages.reversed.toList();
  }
}
