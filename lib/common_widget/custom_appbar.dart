import 'package:flutter/material.dart';
import 'package:reqres/common_widget/custom_text_button.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
      {super.key,
      required this.title,
      this.centerTitle,
      this.onPressed,
      this.leftIcon,
      this.rightIcon,
      this.rightTitle,
      this.style});

  final IconData? leftIcon;
  final VoidCallback? onPressed;
  final String title;
  final String? centerTitle;
  final IconData? rightIcon;
  final String? rightTitle;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            2.0.spaceY,
            InkWell(
              onTap: onPressed,
              child: Icon(
                leftIcon,
                color: ColorManager.white,
                size: 18,
              ),
            ),
            4.0.spaceX,
            Text(
              title,
              style: whiteTextStyle1.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
        Center(
          child: Text(
            centerTitle ?? '',
            style: whiteTextStyle1.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        rightTitle == null
            ? Icon(
                rightIcon,
                color: ColorManager.white,
                size: 18,
              )
            : CustomTextButton(
                type: 'bluesky',
                text: rightTitle!,
                isBottom: false,
              ),
      ],
    );
  }
}
