import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reqres/theme_manager/space_manager.dart';

class UserTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const UserTextField(
      {required this.controller,
      required this.title,
      this.textInputType,
      this.textInputAction,
      this.obscureText = false,
      this.suffixIcon,
      this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        8.0.spaceY,
        TextFormField(
          controller: controller,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              fillColor: Colors.white,
              filled: true,
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFBCBCBC)),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          validator: validator,
        )
      ],
    );
  }
}
