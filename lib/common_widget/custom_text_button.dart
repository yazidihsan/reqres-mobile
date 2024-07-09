import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/color_manager.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.isBottom = true,
      this.type = 'golden'});
  final VoidCallback? onPressed;
  final String text;
  final bool isBottom;
  final String type;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: isBottom == true
                ? Border(
                    bottom: BorderSide(
                      color: ColorManager.golden1,
                      width: 1.5, // Underline thickness
                    ),
                  )
                : null,
          ),
          child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (Rect bounds) {
                if (type == 'bluesky') {
                  return LinearGradient(
                    colors: [
                      ColorManager.sky1,
                      ColorManager.sky2,
                      ColorManager.sky3,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                }
                return LinearGradient(
                  colors: [
                    ColorManager.golden1,
                    ColorManager.golden2,
                    ColorManager.golden3,
                    ColorManager.golden4,
                    ColorManager.golden5,
                    ColorManager.golden6,
                    ColorManager.golden7
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: Text(
                text,
                style: whiteTextStyle1.copyWith(
                    fontWeight:
                        type == 'bluesky' ? FontWeight.w600 : FontWeight.w500,
                    fontSize: isBottom == true
                        ? 13
                        : type == 'bluesky'
                            ? 14
                            : 12),
              )),
        ));
  }
}
