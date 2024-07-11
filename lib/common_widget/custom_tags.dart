import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class CustomTags extends StatelessWidget {
  const CustomTags({super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.whiteWithOpacity9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              title,
              style: whiteTextStyle1.copyWith(
                  fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: ColorManager.white,
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
