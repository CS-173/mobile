import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mobile/services/mapbox.dart';

import '../components/gas_station_info.dart';
import '../models/gas_station_model.dart';
import '../modules/distance_calculator.dart';
import '../modules/is_operating_calculator.dart';
import '../modules/min_max_price_finder.dart';
import '../modules/price_range_calculator.dart';
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

  // for min max price range
  List<double> priceRange = [0, 1000];

  void listenToGasStations() {
    gasStationSubscription = gasStationCollection
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      setState(() {
        gasStations = snapshot.docs.map((doc) {
          GasStation gasStation = GasStation.fromFirestore(doc);
          return GasStationCircle(gasStation: gasStation,  gasStationCircle: Circle("GasStationCircle", CircleOptions(
            geometry: LatLng(gasStation.stationLocation.latitude, gasStation.stationLocation.longitude),
            circleColor: (gasStation.isOpen && isStoreOpen(gasStation.operatingHours))?"#2697FF":"#D32F38",
            circleRadius: 5.0,
            circleOpacity: 1,
            circleStrokeColor: "#FFFFFF",
            circleStrokeWidth: 2,
            circleStrokeOpacity: 0
            ))
          );
        }).toList();
        if(_isLoaded) {
          updateMap();
        }
        setState(() {
          priceRange = findOverallMinMaxFuelPrices(gasStations);
        });
      });
    });
  }

  void updateMap() {
    for (GasStationCircle gasStation in gasStations) {
      if (_isTapped && selectedGasStation!.gasStation.stationId == gasStation.gasStation.stationId) {
        setState(() {
          selectedGasStation = gasStation;
        });
      }

      if (inMapStations.any((element) => element.gasStation.stationId == gasStation.gasStation.stationId)) {
        GasStationCircle circleToUpdate = inMapStations.firstWhere((circle) => circle.gasStation.stationId == gasStation.gasStation.stationId);

        _mapController.updateCircle(circleToUpdate.gasStationCircle, CircleOptions(
          geometry: LatLng(gasStation.gasStation.stationLocation.latitude, gasStation.gasStation.stationLocation.longitude),
          circleColor: (gasStation.gasStation.isOpen && isStoreOpen(gasStation.gasStation.operatingHours))?"#2697FF":"#D32F38"
          )
        );

      } else {
        _mapController.addCircle(gasStation.gasStationCircle.options).then((value) {
          inMapStations.add(GasStationCircle(gasStation: gasStation.gasStation, gasStationCircle: value));
        });
      }
    }
  }

  void _onCircleTapped(Circle circle) {
    if (circle.options.circleColor != "#FFC226") {
      // if already pressed a circle and pressed another one
      if (_isTapped && circle != selectedGasStation!.gasStationCircle) {
        _mapController.updateCircle(selectedGasStation!.gasStationCircle, const CircleOptions(circleStrokeOpacity: 0));

        setState(() {
          selectedGasStation = inMapStations.firstWhere((element) => element.gasStationCircle == circle);
        });

        _mapController.updateCircle(selectedGasStation!.gasStationCircle, const CircleOptions(circleStrokeOpacity: 1));
      } else {
        setState(() {
          _isTapped = !_isTapped;
        });

        if (_isTapped) {
          selectedGasStation = inMapStations.firstWhere((element) => element.gasStationCircle == circle);
          _mapController.updateCircle(selectedGasStation!.gasStationCircle, const CircleOptions(circleStrokeOpacity: 1));
        } else {
          _mapController.updateCircle(circle, const CircleOptions(circleStrokeOpacity: 0));
        }
      }

      if (_isTapped) {
        _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(selectedGasStation!.gasStation.stationLocation.latitude, selectedGasStation!.gasStation.stationLocation.longitude),
            14.0,
          )
        );
      }
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
              circleRadius: 6,
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
              flex: 4,
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
                    Container(
                      color: Colors.black45,
                    ),

                  if(!_isLoaded)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(Constants.defaultPadding),
                  child: _isTapped
                    ? GasStationInfo(gasStation: selectedGasStation!.gasStation)
                    : _isLoaded
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: gasStations.length,
                          itemBuilder: (context, index) {
                            GasStation gasStation = gasStations[index].gasStation;
                            return Card(
                              margin: const EdgeInsets.only(top: 10),
                              color: Constants.secondaryColor,
                              child: FutureBuilder<String>(
                                  future: calculateDistance(currentLocation! , gasStation.stationLocation),
                                  builder: (context, snapshot) {
                                    return GestureDetector(
                                      onTap: ()=>_onCircleTapped(inMapStations.firstWhere((element) => element.gasStation.stationId == gasStation.stationId).gasStationCircle),
                                      child: ListTile(
                                        title: Text(gasStation.stationName, style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                                        subtitle: Text((snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none)?"Calculating...":snapshot.data!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                                        trailing: priceRangeCalculator(priceRange, gasStation.fuel),
                                      ),
                                    );
                                  }
                              ),
                            );
                          },
                        )
                      : const Center(child: CircularProgressIndicator())
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}