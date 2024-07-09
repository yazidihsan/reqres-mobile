import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.type = 'normal'});
  final String text;
  final String type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case 'golden-gradient':
        return ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  ColorManager.golden1,
                  ColorManager.golden2,
                  ColorManager.golden3,
                  ColorManager.golden4,
                  ColorManager.golden5,
                  ColorManager.golden6,
                  ColorManager.golden7,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: Text(text,
                style: whiteTextStyle1.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 14)));
      case 'sky-gradient':
        return ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  ColorManager.sky1,
                  ColorManager.sky2,
                  ColorManager.sky3,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: Text(text,
                style: whiteTextStyle1.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 14)));
      default:
        return Text(text,
            style: whiteTextStyle1.copyWith(
                fontWeight: FontWeight.bold, fontSize: 14));
    }
  }
}
