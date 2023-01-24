import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/models/message.dart';
import 'package:chatify/models/user.dart';
import 'package:chatify/pages/chat/chat_get.dart';
import 'package:chatify/pages/messages/messages_get.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'contants/config.dart';

class AppInit {
  static final AppInit _singleton = AppInit._internal();

  factory AppInit() {
    return _singleton;
  }

  AppInit._internal();

  IO.Socket? socket;
  User? currentChatUser;

  void iniSocketClientDisconect() {
    AppInit().socket?.disconnect();
  }

  void initSocketClient() {
    // IO.Socket socket = IO.io('${Config.socketServicesBaseUrl}?token=${Config.me!.token}',
    //
    //     IO.OptionBuilder()
    //         .setTransports(["websocket"])
    //         .disableAutoConnect()
    //         .enableForceNew()
    //         .build());

    AppInit().socket = IO.io(
        '${Config.socketServicesBaseUrl}?token=${Config.me!.token}',
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .enableForceNew()
            .build());

    AppInit().socket?.onConnect((data) => print('Connected '));
    AppInit().socket?.onDisconnect((data) => print('Disconnected : '));
    AppInit().socket?.on('onMessage',
        (data) => {print("message  : ${data}"), _onMessageHandler(data)});
    AppInit().socket?.connect();
  }

  _onMessageHandler(Map<String, dynamic> json) {
    final message = Message(
        date: DateTime.now(),
        message: json["message"],
        user: User.fromSicketJson(json["from"]));
    if (message.user?.id == currentChatUser?.id) {
      try{
        final chatGet = Get.find<ChatGet>();
        message.seen=true; ///when user is inside chat page
        chatGet.messages.add(message);
        chatGet.onUpdateStream.sink.add(true);
      }catch(err){}
    }
    HiveCacheManager().update(message.user!.id, message);
    final messagesGet = Get.find<MessagesGet>();
    messagesGet.contactsStream.sink.add(true);


  }
}
