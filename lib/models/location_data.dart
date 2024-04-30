import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData {
  final LatLng latlng;
  final String address;
  LocationData({required this.address, required this.latlng});
}
