import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:deviceid/device_info.dart';
import 'package:flutter/material.dart';
// import 'package:device_info_plus/device_info_plus.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AndroidDeviceInfo data;
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    if (Platform.isAndroid) {
      data = await Info.getAndroidinfo();
    } else if (Platform.isIOS) {
      // data = await Info.getIosinfo();
    }
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SDK ${data.version.sdkInt}"),
            Text("CodeName ${data.version.codename}"),
            Text("Android Version ${data.version.release}"),
            Text("Security Patch ${data.version.securityPatch}"),
            Text("Brand ${data.brand}"),
            Text("Device  ${data.device}"),
            Text("Device ID ${data.id}"),
            Text("ChipSet ${data.hardware}"),
          ],
        ),
      ),
    );
  }
}
