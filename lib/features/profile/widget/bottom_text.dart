import 'package:flutter/material.dart';
import 'package:reqres/common_widget/custom_text_button.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class BottomText extends StatelessWidget {
  const BottomText({
    super.key,
    required this.txtPrimary,
    required this.txtSecondary,
    required this.onPressed,
  });
  final String txtPrimary;
  final String txtSecondary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        txtPrimary,
        style:
            whiteTextStyle1.copyWith(fontSize: 13, fontWeight: FontWeight.w500),
      ),
      CustomTextButton(onPressed: onPressed, text: txtSecondary)
    ]);
  }
}
