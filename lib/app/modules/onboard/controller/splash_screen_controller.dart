

import 'package:flutter/material.dart';
import 'package:supabase_chat_application/app/utils/constants/constants.dart';
import '../../../utils/routes/routes.dart';

class SplashController  {
  Future<void> redirect(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () {
      final session = Constants.supabase.auth.currentSession;
      if (session == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.choiceScreen, (route) => false);
      }
    });
  }
}
