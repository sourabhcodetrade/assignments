import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_example/models/location_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controller/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? currentLocation;
  bool isVisible = true;
  List<Position> positions = [];

  List<LatLng> listLatLng = [
    const LatLng(26.9239, 75.8267),
    const LatLng(26.9253, 75.8237),
    const LatLng(26.9855, 75.8513),
    const LatLng(26.9247, 75.8246),
    const LatLng(26.9117, 75.8486)
  ];
  List<LocationData> locationDataList = [];

  Set<Marker> markers = {};

  @override
  void initState() {
    fetchCurrentLocation();
    createMarkers(listLatLng);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isVisible,
        child: FloatingActionButton(
          onPressed: () async {
            setState(() {
              isVisible = false;
            });
            Fluttertoast.showToast(
                msg: '📍 Fetching Current Location',
                gravity: ToastGravity.TOP,
                toastLength: Toast.LENGTH_SHORT);
            currentLocation = await GetLocation().getCurrentLocation();
            cameraToPosition(currentLocation!);
            setState(() {
              isVisible = true;
            });
          },
          child: const Icon(CupertinoIcons.location),
        ),
      ),
      body: currentLocation == null
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.blueAccent,
            ))
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: currentLocation ?? const LatLng(0.0, 0.0),
                      zoom: 16),
                  buildingsEnabled: true,
                  markers: markers,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: (value) async {
                    List<Placemark> result = await placemarkFromCoordinates(
                        value.latitude, value.longitude);
                    Fluttertoast.showToast(
                        msg:
                            '📍 ${result[0].name}, ${result[0].locality},${result[0].subAdministrativeArea}');
                  },
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.03, // Adjust this value as needed
                  minChildSize: 0.03,
                  maxChildSize: 0.4,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ColoredBox(
                            color: Colors.white,
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: locationDataList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(locationDataList[index].address),
                                  leading: const Text(
                                    "📍",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  textColor: Colors.black,
                                  onTap: () {
                                    changeCameraPosition(
                                        locationDataList[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            alignment: Alignment.center,
                            child: Container(
                              height: 4,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
    );
  }

  void createMarkers(List<LatLng> locationsList) async {
    if (locationsList.isNotEmpty) {
      for (int i = 0; i < locationsList.length; i++) {
        List<Placemark> result = await placemarkFromCoordinates(
            locationsList[i].latitude, locationsList[i].longitude);
        String address =
            '${result[0].name}, ${result[0].locality},${result[0].subAdministrativeArea}';
        locationDataList
            .add(LocationData(address: address, latlng: locationsList[i]));

        markers.add(
          Marker(
            markerId: MarkerId('$i'),
            position: locationsList[i],
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueMagenta),
            draggable: false,
            infoWindow: InfoWindow(title: address),
          ),
        );
        if (i == locationsList.length - 1) {
          setState(() {});
        }
      }
    }
  }

  void changeCameraPosition(LocationData locationData) async {
    GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: locationData.latlng,
      zoom: 16,
    )));
    Fluttertoast.showToast(
        msg: '📍 ${locationData.address}',
        gravity: ToastGravity.TOP,
        toastLength: Toast.LENGTH_SHORT);
    setState(() {});
  }

  void fetchCurrentLocation() async {
    currentLocation = (await GetLocation().getCurrentLocation())!;
    setState(() {});
    onChangedLocation();
  }

  void onChangedLocation() {
    Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.bestForNavigation,
    )).listen((event) async {
      setState(() {
        currentLocation = LatLng(event.latitude, event.longitude);
      });
      positions.insert(0, event);
      cameraToPosition(currentLocation!);
      print(positions);
    });
  }

  Future<void> cameraToPosition(LatLng pos) async {
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: pos,
      zoom: 16,
    )));
  }
}
