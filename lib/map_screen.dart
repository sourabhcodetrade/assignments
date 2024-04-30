import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng latLng = const LatLng(26.9124, 75.7873);
  String address =  'Jaipur';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 12
        ),
        buildingsEnabled: true,
        markers: {
          Marker(
            markerId: const MarkerId('1'),
            position: latLng,
            draggable: true,
            onDragEnd: (value) => setMarker(value),
            infoWindow: InfoWindow(title: address),
          ),

        },

        onTap: (value) {
          setMarker(value);
        },
      ),
    );
  }


  setMarker(LatLng value) async{
    latLng = value;
    List<Placemark> result = await placemarkFromCoordinates(value.latitude, value.longitude);

    if(result.isNotEmpty){
      address = '${result[0].name}, ${result[0].locality},${result[0].administrativeArea}';
    }

    setState(() {
      Fluttertoast.showToast(msg: '📍 $address');
    });

  }
  addMarker(LatLng value) async{
    latLng = value;
    List<Placemark> result = await placemarkFromCoordinates(value.latitude, value.longitude);

    if(result.isNotEmpty){
      address = '${result[0].name}, ${result[0].locality},${result[0].subAdministrativeArea}';
    }


    setState(() {
      Fluttertoast.showToast(msg: '📍 $address');
    });

  }


}


