import 'package:flutter/material.dart';

class GradientIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final LinearGradient gradient;
  final VoidCallback onPressed;

  const GradientIconButton(
      {super.key,
      required this.icon,
      required this.size,
      required this.gradient,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return gradient
              .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
        },
        child: Icon(
          icon,
          size: size,
          color: Colors
              .white, // The color property here is not used since ShaderMask will override it
        ),
      ),
    );
  }
}
