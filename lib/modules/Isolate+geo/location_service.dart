import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

void getCurrentLocationIsolate(Map<String,dynamic> arg) async {
  final SendPort sendPort = arg['sendPort'];
  final RootIsolateToken token = arg['token'];
  BackgroundIsolateBinaryMessenger.ensureInitialized(token);
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    permission = await Geolocator.requestPermission();
  } else {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      sendPort.send(position);
    } catch (e) {
      print(e.toString());
    }
  }
}
