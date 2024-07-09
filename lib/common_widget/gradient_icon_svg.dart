import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientIconSvg extends StatelessWidget {
  final String svgPath;
  final double size;
  final LinearGradient gradient;

  const GradientIconSvg({
    super.key,
    required this.svgPath,
    this.size = 24.0,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          color: Colors.white,
          width: size * 0.6,
          height: size * 0.6,
        ),
      ),
    );
  }
}
