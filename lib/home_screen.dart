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
  late Map<Permission, PermissionStatus> statuses;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero, () {
      getAllPermission(context);
    });
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
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Permission Denied"),
        content: Text("Allow $text to access"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Settings'),
            onPressed: () => openAppSettings(),
          ),
        ],
      ),
    );
  }

  Future<void> getAllPermission(BuildContext context) async {
    statuses = await [
      Permission.camera,
      Permission.location,
      Permission.storage,
    ].request();

    statuses.forEach((permission, status) {
      if (status.isDenied) {
        permission.request();
      } else if (status.isGranted) {
      } else if (status.isPermanentlyDenied) {
        setState(() {
          text = text + permission.toString();
        });
        if (!dialogVisible) {
          showAlertDialog(context, text);
        }
        print("isPermanentlyDenied called");
      }
    });
  }
}
