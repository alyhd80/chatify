import 'package:chatify/contants/colors.dart';
import 'package:chatify/contants/text_styles.dart';
import 'package:chatify/models/message.dart';
import 'package:chatify/pages/chat/chat_get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);
  final chatGet = Get.put(ChatGet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: CupertinoButton(
          padding: const EdgeInsets.only(bottom: 25),
          onPressed: () {
            ChatGet().userInfo();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                chatGet.user?.fullname ?? "",
                style: MyTextStyles.caption.copyWith(color: Colors.black),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
              )
            ],
          ),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            StreamBuilder<bool>(
              stream: chatGet.onUpdateStream.stream,
              builder: (context, snapshot) {
                final count = chatGet.messages.length;
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: chatGet.scrollController,
                    padding: const EdgeInsets.only(bottom: 150),
                    itemCount: count,
                    itemBuilder: (context, index) {
                      final message = chatGet.messages[index];
                      final isMyMessage = message.isMyMessage();
                      return ChatBubble(
                        backGroundColor: isMyMessage
                            ? MyColors.primaryColor
                            : Colors.grey.shade300,
                        margin: const EdgeInsets.only(bottom: 5, right: 10),
                        padding: const EdgeInsets.all(18),
                        alignment: isMyMessage
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        clipper: ChatBubbleClipper6(
                            type: isMyMessage
                                ? BubbleType.sendBubble
                                : BubbleType.receiverBubble,
                            radius: 20),
                        child: Text(
                          message.message,
                          style: MyTextStyles.button,
                        ),
                      );
                    });
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(top: BorderSide(width: 0.5, color: Colors.grey)),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          controller: chatGet.controller,
                          onChanged: (newVal) => chatGet.message.value = newVal,
                          minLines: 1,
                          maxLines: 8,
                          style: MyTextStyles.textfield
                              .copyWith(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              hintText: "Write a message...",
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              suffixIcon: Obx(() => IconButton(
                                  onPressed: chatGet.message.value.isNotEmpty
                                      ? chatGet.send
                                      : null,
                                  icon: Icon(Icons.send,
                                      color: chatGet.message.value.isEmpty
                                          ? Colors.grey.shade400
                                          : MyColors.primaryColor))))),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
