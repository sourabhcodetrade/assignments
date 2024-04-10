// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool dialogVisible = false;
  String text = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    askPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      print("resumed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Permission',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertDialog(context, String text) {
    dialogVisible = true;
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: true,
        child: CupertinoAlertDialog(
          title: const Text("Permission Denied"),
          content: Text("Allow $text to access"),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text('Settings'),
              onPressed: () => openAppSettings(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> askPermission() async {
    try {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
        Permission.location
      ].request();

      statuses.forEach((permission, status) async {
        if (status.isDenied || status.isPermanentlyDenied) {
          setState(() {
            text = '$text,$permission';
          });
          // if (!dialogVisible) {
          showAlertDialog(context, text);
          // }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
