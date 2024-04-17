import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'location_service.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late Position position;

  void fetchLocation() async {
    final RootIsolateToken? token = RootIsolateToken.instance;
    ReceivePort receiverPort = ReceivePort();
    Isolate.spawn(getCurrentLocationIsolate,
        {"token": token, "sendPort": receiverPort.sendPort});
    position = await receiverPort.first;
    print('Isolate location = $position');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                fetchLocation();
              },
              child: const Text("check"),
            ),
          ],
        ),
      ),
    );
  }
}
