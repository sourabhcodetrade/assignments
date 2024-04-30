import 'package:flutter/material.dart';
import 'package:google_map_example/views/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/location.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    fetchCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(
              size: 200, // Adjust size as needed
              textColor: Colors.white,
            ),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }


  Future<void> fetchCurrentLocation() async {
    LatLng target = (await GetLocation().getCurrentLocation())! ;
    if(mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MapScreen(target: target),));
    }
  }
}
