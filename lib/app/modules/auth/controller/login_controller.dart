import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/routes/routes.dart';

class LoginController  {
   bool isLoading = false;
  static final TextEditingController emailController =
      TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();

  Future<void> signIn(BuildContext context) async {
    isLoading = true;
    try {
      await Constants.supabase.auth.signInWithPassword(
          password: passwordController.value.text,
          email: emailController.value.text);
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed(Routes.choiceScreen);
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
