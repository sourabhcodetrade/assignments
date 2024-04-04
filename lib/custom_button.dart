import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
