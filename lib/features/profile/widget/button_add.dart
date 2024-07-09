import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';

class ButtonAdd extends StatelessWidget {
  const ButtonAdd({super.key, required this.child, required this.onPressed});
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: ColorManager.whiteWithOpacity5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: child,
        ),
      ),
    );
  }
}
