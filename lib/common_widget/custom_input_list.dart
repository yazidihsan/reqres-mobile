import 'package:flutter/material.dart';

class CustomInputList extends StatelessWidget {
  const CustomInputList(
      {super.key,
      required this.controller,
      required this.items,
      this.onSubmitted,
      required this.child});
  final TextEditingController controller;
  final Function(String)? onSubmitted;
  final List<String> items;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: child),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onSubmitted: onSubmitted,
          ),
        ),
      ],
    );
  }
}
