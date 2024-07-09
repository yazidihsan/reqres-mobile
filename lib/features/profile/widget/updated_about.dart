import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';
import 'package:reqres/theme_manager/space_manager.dart';

class UpdatedAbout extends StatelessWidget {
  const UpdatedAbout({
    super.key,
    required this.title,
    required this.data,
  });
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title:',
            style: whiteTextStyle7.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            )),
        2.0.spaceX,
        Text(
          data,
          style: whiteTextStyle1.copyWith(
              fontSize: 13, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
