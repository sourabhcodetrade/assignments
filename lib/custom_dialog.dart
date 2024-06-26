import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:untitled/navigation_manager.dart';

final class CustomDialog {
  static final CustomDialog instance = CustomDialog._();

  factory CustomDialog() => instance;

  CustomDialog._();

  static bool isDialogVisible = false;

  static void showDialog(String text) => showCupertinoDialog(
        barrierDismissible: false,
        context: NavigationManager.navigatorKey.currentState!.context,
        builder: (context) => PopScope(
          canPop: false,
          child: CupertinoAlertDialog(
            title: const Text("Permission Denied"),
            content: Text("Allow $text to access"),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                child: const Text('Settings'),
                onPressed: () async {
                  isDialogVisible = false;
                  hideDialog();
                  await openAppSettings();
                },
              ),
            ],
          ),
        ),
      );

  static void hideDialog() =>
      Navigator.pop(NavigationManager.navigatorKey.currentState!.context);
}
