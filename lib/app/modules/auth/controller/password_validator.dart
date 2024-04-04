import 'package:flutter/material.dart';

bool validatePassword(String password, BuildContext context) {
  String errorMessage = '';

  // Password length greater than 6
  if (password.length < 6) {
    errorMessage += 'Password must be longer than 6 characters.\n';
  }

  // Contains at least one uppercase letter
  if (!password.contains(RegExp(r'[A-Z]'))) {
    errorMessage += '• Uppercase letter is missing.\n';
  }

  // Contains at least one lowercase letter
  if (!password.contains(RegExp(r'[a-z]'))) {
    errorMessage += '• Lowercase letter is missing.\n';
  }

  // Contains at least one digit
  if (!password.contains(RegExp(r'[0-9]'))) {
    errorMessage += '• Digit is missing.\n';
  }

  // Contains at least one special character
  if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
    errorMessage += '• Special character is missing.\n';
  }

  if (errorMessage.isEmpty) {
    return true;
  } else {
    // Show Snackbar with error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage.trim()),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
    return false;
  }
}
