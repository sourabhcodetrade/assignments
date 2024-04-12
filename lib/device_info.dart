import 'package:device_info_plus/device_info_plus.dart';

class Info {
  static DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  AndroidDeviceInfo? androidDeviceInfo;
  IosDeviceInfo? iosInfo;

 static  Future<AndroidDeviceInfo> getAndroidinfo() async {
    return await deviceInfo.androidInfo;
  }

 static Future<IosDeviceInfo> getIosinfo() async {
    return await deviceInfo.iosInfo;
  }
}
