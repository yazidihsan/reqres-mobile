import 'package:flutter/material.dart';

class InnerShadowImage extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const InnerShadowImage(
      {super.key, required this.child, this.borderRadius = 17});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
        IgnorePointer(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: CustomPaint(
              size: Size(359, 190),
              painter: InnerShadowPainter(borderRadius: borderRadius),
              child: Container(
                width: 359,
                height: 190,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InnerShadowPainter extends CustomPainter {
  final double borderRadius;

  InnerShadowPainter({required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = Colors.black
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final RRect outerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(-20, 0, size.width + 30, size.height + 30),
      Radius.circular(borderRadius),
    );

    final RRect innerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height - 70),
      Radius.circular(borderRadius),
    );

    final Path outerPath = Path()..addRRect(outerRect);
    final Path innerPath = Path()..addRRect(innerRect);
    final Path shadowPath =
        Path.combine(PathOperation.difference, outerPath, innerPath);

    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
