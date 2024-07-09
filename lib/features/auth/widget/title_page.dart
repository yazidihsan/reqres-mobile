import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/font_family_manager.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          whiteTextStyle1.copyWith(fontWeight: FontWeight.w700, fontSize: 24),
    );
  }
}
