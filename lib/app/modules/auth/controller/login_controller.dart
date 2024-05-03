import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/routes/routes.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  static final Rx<TextEditingController> emailController =
      TextEditingController().obs;
  static final Rx<TextEditingController> passwordController =
      TextEditingController().obs;

  Future<void> signIn(BuildContext context) async {
    isLoading.value = true;
    try {
      await Constants.supabase.auth.signInWithPassword(
          password: passwordController.value.text,
          email: emailController.value.text);
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
    isLoading.value = false;
  }
}
