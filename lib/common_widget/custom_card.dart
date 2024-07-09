import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child, this.isList = false});

  final Widget child;
  final bool isList;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isList == false ? ColorManager.bg4 : ColorManager.bg5,
      margin: isList == false
          ? const EdgeInsets.only(bottom: 24)
          : const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: isList == false
          ? Padding(
              padding: const EdgeInsets.only(
                  left: 13, bottom: 17, top: 8, right: 14),
              child: SizedBox(
                height: 190,
                child: child,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(
                  left: 24, top: 8, bottom: 23, right: 14),
              child: child,
            ),
    );
  }
}
