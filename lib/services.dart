import 'package:geolocator/geolocator.dart';

class GetLocation {
  double? latitude;
  double? longitude;

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    } else {
      Position position;
      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
        );
        longitude = position.longitude;
        latitude = position.latitude;
        return position;
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }
    return null;
  }
}
