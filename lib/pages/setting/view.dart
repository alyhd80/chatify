import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatify/contants/config.dart';
import 'package:chatify/contants/text_styles.dart';
import 'package:chatify/pages/setting/setting_get.dart';
import 'package:chatify/pages/setting/setting_item_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final settingsGet = SettingsGet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 30, top: 15),
              child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    SettingsGet().uploadAvatar();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  child: Obx(
                    () => ((SettingsGet.profileAvatar.value != null &&
                            SettingsGet.profileAvatar.value!.path != ''))
                        ? CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: 80,
                            backgroundImage:
                                FileImage(SettingsGet.profileAvatar.value!),
                          )
                        : CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.blue.shade300,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: CachedNetworkImage(
                                imageUrl:
                                    Config.showAvatarBaseUrl(Config.me!.userId),
                                placeholder: (context, string) => Text(string),
                                errorWidget: (context,url,error)=>Icon(Icons.person,color: Colors.green,size: 50,),
                              ),
                            )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0, top: 15),
              child: Text(
                Config.me!.fullname,
                style: MyTextStyles.header,
              ),
            ),
            SettingItemWidget(
              onTapped: () => {},
              title: "Privacy Policy",
              isInRed: false,
              prefixIcon: Icons.settings,
            ),
            SettingItemWidget(
              onTapped: () => SettingsGet().LogOut(),
              title: "Sign Out",
              isInRed: true,
              prefixIcon: Icons.exit_to_app_rounded,
            )
          ],
        ),
      ),
    );
  }
}
