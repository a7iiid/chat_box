import 'package:chat_app/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class CoustomTextFormFilde extends StatelessWidget {
  const CoustomTextFormFilde(
      {super.key,
      required this.controlar,
      required this.hint,
      required this.label,
      required this.error,
      this.obscuer = false});

  final TextEditingController controlar;
  final String hint;
  final String label;
  final String error;
  final bool obscuer;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlar,
      obscureText: obscuer,
      decoration: InputDecoration(
        hintText: hint,
        label: Text(
          label,
          style: AppStyle.inputeLabel,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return error;
        }
        return null;
      },
    );
  }
}
