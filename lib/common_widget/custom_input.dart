import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.keyboardType,
      required this.obscureText,
      this.prefixIcon,
      this.suffixIcon});

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorManager.whiteWithOpacity4,
            borderRadius: BorderRadius.circular(9),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: whiteTextStyle1.copyWith(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(top: 17, left: 18, bottom: 18),
              hintText: hintText,
              hintStyle: TextStyle(color: ColorManager.whiteWithOpacity1),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
