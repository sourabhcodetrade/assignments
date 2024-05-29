import 'dart:async';
import 'package:firebase_auth_project/app/core/manager/get_it_manager.dart';
import 'package:firebase_auth_project/app/core/services/package_services.dart';
import 'package:flutter/material.dart';

final AppState appState = AppState();

final class AppState {
  static final AppState instance = AppState._();
  factory AppState() => instance;
  AppState._();

  late Size _screenSize;
  String _deviceId = '', _appVersion = '';

  //getter
  String get deviceId => _deviceId;

  String get appVersion => _appVersion;
  double getScreenHeight({double percent = 1}) => _screenSize.height * percent;

  double getScreenWidth({double percent = 1}) => _screenSize.width * percent;

  //setter
  set setScreenSize(BuildContext context) =>
      _screenSize = MediaQuery.of(context).size;

  //methods to initialise
  Future<void> setInitialValue() async {
    await getIt<PackageServices>().getDeviceInfo();
    await _setDeviceId();
    await _setPackageInfo();
  }

  Future<void> _setDeviceId() async {
    if (_deviceId.isNotEmpty) {
      debugPrint("Device id is already set");
    }
    try {
      _deviceId = await getIt<PackageServices>().getDeviceId();
      debugPrint("Device id is => $deviceId");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _setPackageInfo() async {
    if (_appVersion.isNotEmpty) {
      debugPrint("Device id is already set");
    }
    try {
      _appVersion = await getIt<PackageServices>().getAppVersion();
      debugPrint("App Version is => $_appVersion");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
