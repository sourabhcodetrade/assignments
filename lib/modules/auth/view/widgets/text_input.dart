import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final IconData myIcon;
  final String myHintText;
  final String validator;
  final bool isHidden;

  const TextInputField(
      {super.key,
        required this.controller,
        required this.myIcon,
        required this.myHintText,
        required this.validator,
        this.isHidden = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isHidden,
      decoration: InputDecoration(
        icon: Icon(myIcon),
        hintText: myHintText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validator;
        }
        return null;
      },
    );
  }
}