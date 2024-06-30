import 'dart:convert';
import 'dart:io';

import 'package:camera_ui/permission_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'custom_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final platform = const MethodChannel('channel');
   String imagePath='';
  bool show = false;

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
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.amber,
              child: show
                  ? Image.file(File(imagePath))
                  : const SizedBox.shrink(),
            ),
            ElevatedButton(
              onPressed: () {
                _getCamera();
              },
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
      show = true;
      setState(() {});
    } on PlatformException catch (e) {
      print('error');
      print(e);
    }
  }
}
