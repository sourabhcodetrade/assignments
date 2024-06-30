import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:camera_ui/permission_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final platform = const MethodChannel('channel');
  String imagePath = '';

  @override
  void initState() {
    PermissionManager.instance
        .askPermissions([Permission.camera, Permission.storage]);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !CustomDialog.isDialogVisible) {
      PermissionManager.instance
          .askPermissions([Permission.camera, Permission.storage]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagePath.isNotEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(imagePath),
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  )
                : const SizedBox.shrink(),
            ElevatedButton(
              onPressed: _getCamera,
              child: const Text("Camera"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCamera() async {
    try {
      imagePath = await platform.invokeMethod("cameraOn");
      if (imagePath.isNotEmpty) {
        BotToast.showCustomNotification(
          toastBuilder: (cancelFunc) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: SizedBox()),
                      Text(
                        "Success",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            );
          },
        );
        setState(() {});
      } else {
        BotToast.showCustomNotification(
          toastBuilder: (cancelFunc) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: SizedBox()),
                      Text(
                        "Something went wrong",
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    } on PlatformException catch (e) {
      BotToast.showCustomNotification(
        toastBuilder: (cancelFunc) {
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: SizedBox()),
                    Text(
                      "Something went wrong",
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          );
        },
      );

      log('error');
      log(e.toString());
    }
  }
}
