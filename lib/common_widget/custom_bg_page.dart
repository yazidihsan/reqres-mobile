import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';

class CustomBackgroundPage extends StatelessWidget {
  const CustomBackgroundPage(
      {super.key, required this.child, this.isPrimary = false});
  final Widget child;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    if (isPrimary == true) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 2.5,
          colors: [ColorManager.bg1, ColorManager.bg2, ColorManager.bg3],
          stops: const [0.0, 0.5, 1.0],
        )),
        child: child,
      );
    } else {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: ColorManager.bg3),
        child: child,
      );
    }
  }
}
