import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class ChipInput extends StatelessWidget {
  const ChipInput(
      {super.key,
      required this.controller,
      this.prefixIcon,
      required this.onSubmitted});
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Function(String?) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        style:
            whiteTextStyle1.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
        cursorColor: ColorManager.whiteWithOpacity1,
        decoration: InputDecoration(
            filled: true,
            fillColor: ColorManager.whiteWithOpacity4,
            contentPadding: EdgeInsets.all(24.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9.0),
                borderSide: BorderSide.none),
            prefixIconConstraints: const BoxConstraints(
                maxWidth: double.infinity, maxHeight: double.infinity),
            prefixIcon: prefixIcon),
        onSubmitted: onSubmitted);
  }
}
