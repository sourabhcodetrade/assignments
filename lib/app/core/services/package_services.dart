import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

final class PackageServices {
  late final AndroidDeviceInfo androidInfo;
  late final IosDeviceInfo iosInfo;

  Future<void> getDeviceInfo() async {
    try {
      final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) androidInfo = await deviceInfo.androidInfo;
      if (Platform.isIOS) iosInfo = await deviceInfo.iosInfo;
    } catch (e) {
      debugPrint("$e");
    }
  }

  Future<String> getDeviceId() async {
    String deviceId = "";
    if (Platform.isAndroid) deviceId = androidInfo.id;
    if (Platform.isIOS) deviceId = iosInfo.identifierForVendor ?? '';
    return deviceId;
  }

  Future<String> getAppVersion() async {
    String appVersion =  (await PackageInfo.fromPlatform()).version;
    return appVersion;
  }
}
