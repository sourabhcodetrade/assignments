import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

void getCurrentLocationIsolate(SendPort sendPort) async {
  try {
    final RootIsolateToken? token = RootIsolateToken.instance;
    BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied.');
      }
    }

    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    sendPort.send(position.longitude.toString());
  } catch (e) {
    sendPort.send('Error: $e');
  }
}
