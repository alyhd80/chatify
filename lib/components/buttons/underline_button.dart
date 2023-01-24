import 'package:flutter/material.dart';

import '../../contants/text_styles.dart';

class UnderLineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const UnderLineButton({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: MyTextStyles.button.copyWith(
            color: Colors.black, decoration: TextDecoration.underline),
      ),
    );
  }
}
