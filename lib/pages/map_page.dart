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
  bool _isLoaded = false;

  // for firestore
  List<GasStationCircle> gasStations = [];
  List<GasStationCircle> inMapStations = [];

  GasStationCircle? selectedGasStation;
  bool _isTapped = false;

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
            circleRadius: 5.0,
            circleOpacity: 1,
            circleStrokeColor: "#FFFFFF",
            circleStrokeWidth: 2,
            circleStrokeOpacity: 0
            ))
          );
        }).toList();
      });

      if(_isLoaded) {
        updateMap();
      }
    });
  }

  void updateMap() {
    for (GasStationCircle gasStation in gasStations) {
      if (inMapStations.any((element) => element.gasStation.stationId == gasStation.gasStation.stationId)) {
        GasStationCircle circleToUpdate = inMapStations.firstWhere((circle) => circle.gasStation.stationId == gasStation.gasStation.stationId);
        _mapController.updateCircle(circleToUpdate.gasStationCircle, CircleOptions(
          geometry: LatLng(gasStation.gasStation.stationLocation.latitude, gasStation.gasStation.stationLocation.longitude),
          circleOpacity: gasStation.gasStation.isOpen?10:0,
        ));
      } else {
        _mapController.addCircle(gasStation.gasStationCircle.options).then((value) {
          inMapStations.add(GasStationCircle(gasStation: gasStation.gasStation, gasStationCircle: value));
        });
      }
    }
  }

  void _onCircleTapped(Circle circle) {
    setState(() {
      _isTapped = !_isTapped;
    });

    if (_isTapped) {
      if (circle.options.circleColor == "#2697FF") {
        selectedGasStation = inMapStations.firstWhere((element) => element.gasStationCircle == circle);
        _mapController.updateCircle(selectedGasStation!.gasStationCircle, const CircleOptions(circleStrokeOpacity: 1));
      }
    } else {
      _mapController.updateCircle(selectedGasStation!.gasStationCircle, const CircleOptions(circleStrokeOpacity: 0));
    }
  }

  _onMapCreated(MapboxMapController controller) {
    _mapController = controller;

    _mapController.onCircleTapped.add(_onCircleTapped);
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

        setState(() {
          _isLoaded = true;
        });
        updateMap();
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
              child: Stack(
                children: [
                  MapboxMap(
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

                  if(!_isLoaded)
                    Center(
                    child: CircularProgressIndicator(),
                  ),

                  if(!_isLoaded)
                    Container(
                      color: Colors.black45,
                    )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(Constants.defaultPadding),
                  child: _isTapped
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