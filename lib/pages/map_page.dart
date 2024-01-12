import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/services/mapbox.dart';

import '../components/gas_station_info.dart';
import '../models/gas_station_model.dart';
import '../style/constants.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapboxMapController _mapController;
  late StreamSubscription gasStationSubscription;
  final CollectionReference gasStationCollection = FirebaseFirestore.instance.collection('gas_stations');

  // for location
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData? currentLocation;

  // for firestore
  List<GasStationCircle> gasStations = [];
  List<GasStationCircle> inMapStations = [];

  GasStation? selectedGasStation;

  void listenToGasStations() {
    gasStationSubscription = gasStationCollection
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      setState(() {
        gasStations = snapshot.docs.map((doc) {
          GasStation gasStation = GasStation.fromFirestore(doc);
          return GasStationCircle(gasStation: gasStation,  gasStationCircle: Circle("GasStationCircle", CircleOptions(
            geometry: LatLng(gasStation.stationLocation.latitude, gasStation.stationLocation.longitude),
            circleColor: "#2697FF",
            circleRadius: 7.0,
            circleOpacity: 0.5,
            ))
          );
        }).toList();
      });
      updateMap();
    });
  }

  void updateMap() {
    // _mapController.clearCircles();
    
    for (GasStationCircle gasStation in gasStations) {
      if (inMapStations.any((element) => element.gasStation.stationId == gasStation.gasStation.stationId)) {
        GasStationCircle circleToUpdate = inMapStations.firstWhere((circle) => circle.gasStation.stationId == gasStation.gasStation.stationId);
        _mapController.updateCircle(circleToUpdate.gasStationCircle, CircleOptions(
          geometry: LatLng(gasStation.gasStation.stationLocation.latitude, gasStation.gasStation.stationLocation.longitude)
        ));
      } else {
        _mapController.addCircle(gasStation.gasStationCircle.options).then((value) {
          inMapStations.add(GasStationCircle(gasStation: gasStation.gasStation, gasStationCircle: value));
        });
      }
    }
  }

  _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
  }

  _onMapStyleLoaded() {
    listenToGasStations();
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
            14.0,
          ),
        );

        _mapController.addCircle(
            CircleOptions(
              circleOpacity: 1,
              circleRadius: 5,
              circleColor: "#FFC226",
              geometry: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
            )
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
    gasStationSubscription.cancel();
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
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(Constants.defaultPadding),
                  child: selectedGasStation != null
                    ? GasStationInfo(gasStations: gasStations)
                    : Center(child: CircularProgressIndicator()),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}