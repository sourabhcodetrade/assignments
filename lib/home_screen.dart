// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
      checkPermissionStatus();
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(4),
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              onPressed: () {
                checkPermission(Permission.camera, context, 'Camera');
              },
              child: const Text(
                'Click Image',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(4),
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              onPressed: () {
                checkPermission(Permission.storage, context, 'Storage');
              },
              child: const Text(
                'Storage Permission',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(4),
                backgroundColor: MaterialStatePropertyAll(Colors.teal),
              ),
              onPressed: () {
                checkPermission(Permission.location, context, 'Location');
              },
              child: const Text(
                'Location Permission',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getImageFromCamera(BuildContext context) async {
    XFile? selectedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
  }

  Future<void> checkPermission(
      Permission permission, BuildContext context, String text) async {
    final status = await permission.request();

    if (status.isGranted) {
      switch (permission) {
        case Permission.camera:
          if (context.mounted) getImageFromCamera(context);
          break;
        case Permission.location:
          break;
        case Permission.storage:
          break;
      }
    } else if (status.isDenied) {
      if (context.mounted) showAlertDialog(context, text);
    } else if (status.isLimited) {
      if (context.mounted) getImageFromCamera(context);
    } else if (status.isPermanentlyDenied) {
      if (context.mounted) showAlertDialog(context, text);
    } else {
      if (context.mounted) showAlertDialog(context, text);
    }
  }

  void showAlertDialog(context, String text) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Permission Denied"),
        content: Text("Allow to access $text"),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Settings'),
            onPressed: () => openAppSettings(),
          ),
        ],
      ),
    );
  }

  Future<void> checkPermissionStatus() async {
    final cameraPermissionStatus = await Permission.camera.status;
    final locationPermissionStatus = await Permission.location.status;
    final storagePermissionStatus = await Permission.storage.status;

    if(cameraPermissionStatus == PermissionStatus.granted && storagePermissionStatus == PermissionStatus.granted && locationPermissionStatus == PermissionStatus.granted ){
      if(context.mounted) Navigator.pop(context);
    }


  }
}
