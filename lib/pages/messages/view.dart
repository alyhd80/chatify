import 'package:chatify/contants/colors.dart';
import 'package:chatify/pages/messages/messages_get.dart';
import 'package:chatify/pages/messages/view.chats.dart';
import 'package:chatify/pages/messages/view.rooms.dart';
import 'package:chatify/pages/messages/view.tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../contants/config.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> with TickerProviderStateMixin {
  TabController? _controller;
  final messagesGet = Get.put(MessagesGet());

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MESSAGES'),
        leading: IconButton(
            onPressed: () => Get.toNamed(PageRoutes.settings),
            icon: const Icon(CupertinoIcons.line_horizontal_3_decrease)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
        ],
      ),
      body: Stack(
        children: [
          TabBarView(controller: _controller, children: [
            MessagesChatsTab(),
            MessagesRoomsTab(),
          ]),
          MessagesTabbar(controller: _controller!),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 5),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: MyColors.primaryColor,
                    child: const Icon(Icons.add),
                    onPressed: () {
                      messagesGet.addContact();
                    },
                  )),
            ),
          ),

        ],
      ),
    );
  }
}
