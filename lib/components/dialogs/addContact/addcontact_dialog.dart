import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/dialogs/addContact/addContact_get.dart';
import 'package:chatify/components/loading.dart';
import 'package:chatify/components/textfields/primary_textfield.dart';
import 'package:chatify/contants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactDialog extends StatelessWidget {
  AddContactDialog({Key? key}) : super(key: key);
  final addContactGet = AddContactGet();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: AlertDialog(
          backgroundColor: Colors.green.shade200.withOpacity(0.5),
          content: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add Contact",
                      style: MyTextStyles.header2,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: PrimaryTextField(
                    hint: "Enter User name",
                    maxLength: 40,
                    prefixIcon: Icons.person,
                    onChanged: (newWal) {
                      addContactGet.username.value = newWal;
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Obx(() => addContactGet.loading.value
                        ? MyLoading()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              UnderLineButton(
                                  title: "cansel",
                                  onPressed: () {
                                    Get.back();
                                  }),
                              PrimaryButton(
                                title: "add",
                                onPressed: () {
                                  addContactGet.add();
                                },
                              )
                            ],
                          )))
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
