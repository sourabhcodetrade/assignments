import 'package:flutter/material.dart';

import '../../controller/auth_controller.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.formKey,
    required this.passwordController,
    required this.authController,
    required this.emailController,
    required this.text,
    required this.onPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final AuthController authController;
  final TextEditingController emailController;
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
