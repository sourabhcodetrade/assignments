import 'package:firebase_auth_project/app/core/services/navigation_extension.dart';
import 'package:flutter/material.dart';

import 'custom_loader_widget.dart';

final class CustomDialog {
  static void hideDialog(BuildContext context) => context.pop();

  static void showLoader(BuildContext context) => showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const PopScope(
          canPop: false,
          child: AlertDialog(
            content: LoadingWidget(
              height: 200,
              width: 100,
            ),
          ),
        ),
      );
}
