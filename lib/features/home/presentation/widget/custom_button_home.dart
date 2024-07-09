import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reqres/theme_manager/color_manager.dart';

class CustomButtonHome extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? child;
  final Size? size;

  const CustomButtonHome(
      {required this.onPressed,
      this.backgroundColor,
      this.foregroundColor,
      this.child,
      this.size,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: size,
          backgroundColor: backgroundColor ?? ColorManager.btn1,
          foregroundColor: foregroundColor ?? Colors.white,
        ),
        child: child);
  }
}
