import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.textColor,
    // required this.gradientColor,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
  });

  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  // final List<Color> gradientColor;
  final double borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            gradient: ColorManager.btnPrimary,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                  color: ColorManager.btn1.withOpacity(0.2),
                  offset: Offset(0, elevation),
                  blurRadius: elevation)
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 13, bottom: 16),
            child: Text(
              text,
              style: whiteTextStyle1.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
