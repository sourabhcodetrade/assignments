import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation(final RootIsolateToken token) async {
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
      return position;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
  throw Exception('Failed to get current location');
}
