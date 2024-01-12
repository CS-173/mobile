import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/services/mapbox.dart';

import '../style/constants.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapboxMapController _mapController;
  // for location
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData? currentLocation;

  _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
  }

  _onMapStyleLoaded() {

  }

  Future<void> _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _configureLocationSettings();
    _getCurrentLocation();
  }

  void _configureLocationSettings() {
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 2500,
      distanceFilter: 5,
    );
  }

  void _getCurrentLocation() async {
    var location = Location();
    try {
      currentLocation = await location.getLocation();
      if (currentLocation != null) {
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            15.0,
          ),
        );
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.bgColor,
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: MapboxMap(
                accessToken: accessToken,
                initialCameraPosition: const CameraPosition(
                  target: initialCameraPosition,
                  zoom: zoom
                ),
                onMapCreated: _onMapCreated,
                onStyleLoadedCallback: _onMapStyleLoaded,
                styleString: mapStyle,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Constants.bgColor
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
