import 'package:cache_geo_path/services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Position? position;
  @override
  void initState() {
    get();
    super.initState();
  }

  Future<void> get() async {
    GetLocation location = GetLocation();
    position = await location.getCurrentLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Location Coordinates :',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'latitude : ${position?.latitude}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'longitude : ${position?.longitude}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
