import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/routes/routes.dart';

class SignUpController {
   bool isLoading = false;

  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static final TextEditingController emailController =
      TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  static final TextEditingController usernameController =
      TextEditingController();

  Future<void> signUp(BuildContext context) async {
    isLoading = true;
    final isValid = formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    final email = emailController.value.text;
    final password = passwordController.value.text;
    final username = usernameController.value.text;
    try {
      await Constants.supabase.auth.signUp(
          email: email, password: password, data: {'username': username});
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.chatScreen);
      }
    } on AuthException catch (error) {
      EasyLoading.showError(error.message,
          duration: const Duration(seconds: 2));
    } catch (error) {
      EasyLoading.showError('unexpectedErrorMessage',
          duration: const Duration(seconds: 2));
    }
    isLoading = false;
  }
}
