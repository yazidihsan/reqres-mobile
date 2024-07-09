import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class RoundedCard extends StatelessWidget {
  final String icon;
  final String text;

  const RoundedCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.whiteWithOpacity4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 20,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: whiteTextStyle1.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
