

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_chat_application/app/utils/constants/constants.dart';

import '../../../utils/routes/routes.dart';

class SplashController extends GetxController {
  Future<void> redirect(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () {
      final session = Constants.supabase.auth.currentSession;
      if (session == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.chatScreen, (route) => false);
      }
    });
  }
}