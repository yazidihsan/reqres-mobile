import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleApp extends StatelessWidget {
  final String title;
  const TitleApp({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toString(),
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
    );
  }
}
