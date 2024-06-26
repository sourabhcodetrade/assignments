import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';
import 'package:untitled/custom_dialog.dart';
import 'package:untitled/permissions_exception.dart';
import 'package:untitled/permissions_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final List<Permission> _permissions = [
    Permission.location,
    Permission.storage,
    Permission.camera,
  ];

  @override
  void initState() {
    PermissionHandler.instance.askPermissions(_permissions);
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
    Logger().i(state.name);
    if (state == AppLifecycleState.resumed && !CustomDialog.isDialogVisible) {
      PermissionHandler.instance.askPermissions(_permissions);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {},
              child: const Text("Give Permission"),
            ),
          ),
        ],
      ),
    );
  }
}

extension _Helper on _HomeScreenState {}
