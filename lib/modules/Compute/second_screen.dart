import 'dart:async';
import 'dart:ui';

import 'package:compute/compute.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'location.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late Position position;


  Future<void> fetchLocation(final RootIsolateToken token) async{
    position = await compute(getCurrentLocation,token);
    print('Isolate location = $position');

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
              onPressed: () async{
                final RootIsolateToken? token = RootIsolateToken.instance;
                await fetchLocation(token!);
              },
              child: const Text("check"),
            ),
          ],
        ),
      ),
    );
  }
}
