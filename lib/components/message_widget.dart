import 'package:chatify/contants/colors.dart';
import 'package:chatify/contants/config.dart';
import 'package:chatify/contants/text_styles.dart';
import 'package:chatify/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageWidget extends StatelessWidget {
  Contact contact;
  MessageWidget({Key? key, required this.contact}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final int badgeCoubt=contact.messages.where((element) => element.seen==false).toList().length;

    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(PageRoutes.chat, arguments: contact.user);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.5, color: Colors.grey.shade300),
              ),
            ),
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(padding: EdgeInsets.only(bottom: 10),
                              child: Text(contact.user.fullname,
                                style: MyTextStyles.title,),)
                          ],
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
        if(badgeCoubt>0)
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(alignment: Alignment.centerLeft,
              child: CircleAvatar(radius: 10,
            backgroundColor: MyColors.primaryColor,
            child: Text(badgeCoubt.toString(),style: MyTextStyles.small.copyWith(color: Colors.white,fontWeight: FontWeight.bold)),)),
        )
      ],
    );
  }
}
