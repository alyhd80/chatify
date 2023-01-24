import 'package:flutter/material.dart';

import '../../contants/text_styles.dart';

class SettingItemWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTapped;
  final IconData prefixIcon;
  final bool isInRed;

  SettingItemWidget(
      {Key? key,
     required this.onTapped,
      required this.prefixIcon,
      required this.title,
      this.isInRed = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: onTapped,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade400, width: 1)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
            child: prefixIcon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          prefixIcon,
                          size: 20,
                          color: isInRed ? Colors.red : Colors.black,
                        ),
                      ),
                      _title
                    ],
                  )
                : Text(
                    "Sign out",
                    style: MyTextStyles.headline
                        .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }

  Widget get _title => Text(
        title,
        style: MyTextStyles.headline.copyWith(
            color: isInRed ? Colors.red : Colors.black,
            fontWeight: FontWeight.bold),
      );
}
