import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';


import '../components/gas_station_info.dart';
import '../models/gas_station_model.dart';
import '../modules/distance_calculator.dart';
import '../modules/is_operating_calculator.dart';
import '../modules/min_max_price_finder.dart';
import '../modules/price_range_calculator.dart';
import '../services/mapbox.dart';
import '../style/constants.dart';
import 'package:http/http.dart' as http;

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
  List<GasStationEntity> gasStations = [];
  List<GasStationEntity> inMapStations = [];

  GasStationEntity? selectedGasStation;
  bool _isTapped = false;

  // for min max price range
  List<double> priceRange = [0, 1000];

  Future<double> findAndDrawRoute() async {
    String startPoint = '${currentLocation!.longitude},${currentLocation!.latitude}';
    String endPoint = '${selectedGasStation!.gasStation.stationLocation.longitude},${selectedGasStation!.gasStation.stationLocation.latitude}';

    String apiUrl = 'https://api.mapbox.com/directions/v5/$profile/$startPoint;$endPoint?geometries=$geometries&annotations=distance&access_token=$accessToken';

    double distance = 0;

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {

      List<LatLng> coordinates = parseRouteCoordinates(response.body);
      distance = parseDistance1(response.body);

      _mapController.clearLines();
      _mapController.addLine(
        LineOptions(
          geometry: coordinates,
          lineColor: '#ff0000',
          lineWidth: 4.0,
        ),
      );
    } else {
      print('Error: ${response.statusCode} - ${response.reasonPhrase}');
    }

    return distance;
  }

  void listenToGasStations() {
    gasStationSubscription = gasStationCollection
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      setState(() {
        gasStations = snapshot.docs.map((doc) {
          GasStation gasStation = GasStation.fromFirestore(doc);
          return GasStationEntity(gasStation: gasStation,  gasStationEntity: Symbol("GasStationCircle", SymbolOptions(
            geometry: LatLng(gasStation.stationLocation.latitude, gasStation.stationLocation.longitude),
            iconImage: (gasStation.isOpen && isStoreOpen(gasStation.operatingHours))?"lib/assets/images/GasStation.png":"lib/assets/images/GasStationClosed.png",
            iconSize: 0.3,
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
    for (GasStationEntity gasStation in gasStations) {
      if (_isTapped && selectedGasStation!.gasStation.stationId == gasStation.gasStation.stationId) {
        setState(() {
          selectedGasStation = gasStation;
        });
      }

      if (inMapStations.any((element) => element.gasStation.stationId == gasStation.gasStation.stationId)) {
        GasStationEntity entityToUpdate = inMapStations.firstWhere((entity) => entity.gasStation.stationId == gasStation.gasStation.stationId);

        _mapController.updateSymbol(entityToUpdate.gasStationEntity, SymbolOptions(
          geometry: LatLng(gasStation.gasStation.stationLocation.latitude, gasStation.gasStation.stationLocation.longitude),
          iconImage: (gasStation.gasStation.isOpen && isStoreOpen(gasStation.gasStation.operatingHours))?"lib/assets/images/GasStation.png":"lib/assets/images/GasStationClosed.png"
          ),
        );

      } else {
        _mapController.addSymbol(gasStation.gasStationEntity.options).then((value) {
          inMapStations.add(GasStationEntity(gasStation: gasStation.gasStation, gasStationEntity: value));
        });
      }
    }
  }

  void _onSymbolTapped(Symbol symbol) {
    if (_isTapped && symbol != selectedGasStation!.gasStationEntity) {
      _mapController.updateSymbol(selectedGasStation!.gasStationEntity, const SymbolOptions(iconSize: 0.3));

      setState(() {
        selectedGasStation = inMapStations.firstWhere((element) => element.gasStationEntity == symbol);
      });

      _mapController.updateSymbol(selectedGasStation!.gasStationEntity, const SymbolOptions(iconSize: 0.4));
    } else {

      setState(() {
        _isTapped = !_isTapped;
      });

      if (_isTapped) {
        selectedGasStation = inMapStations.firstWhere((element) => element.gasStationEntity == symbol);
        _mapController.updateSymbol(selectedGasStation!.gasStationEntity, const SymbolOptions(iconSize: 0.4));
      } else {
        _mapController.updateSymbol(symbol, const SymbolOptions(iconSize: 0.3));
      }
    }

    if (_isTapped) {
      _mapController.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(selectedGasStation!.gasStation.stationLocation.latitude, selectedGasStation!.gasStation.stationLocation.longitude), 14.0,
          )
      );
    }
  }

  _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
    _mapController.onSymbolTapped.add(_onSymbolTapped);
    _mapController.setSymbolIconAllowOverlap(true);
    _mapController.setSymbolIconIgnorePlacement(true);
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
              circleStrokeColor: "#da002b",
              circleStrokeWidth: 3.0,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: Constants.defaultPadding),
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Constants.irish5,
            shape: CircleBorder(),
            onPressed: () async {
              if (_isTapped) {
                double distance = await findAndDrawRoute();
                double aveGasPrice = priceRangeCalculator(priceRange, selectedGasStation!.gasStation.fuel);
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    animType: AnimType.scale,
                    borderSide: BorderSide(
                        color: Constants.irish2,
                        width: 5
                    ),
                    body: Padding(
                      padding: const EdgeInsets.only(left: Constants.defaultPadding/2, right: Constants.defaultPadding/2, bottom: Constants.defaultPadding*1.2),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              'lib/assets/images/Map-04.png',
                              width: 50,
                            ),
                            SizedBox(width: Constants.defaultPadding),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'BEST ROUTE FOUND!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Constants.irish3,
                                  ),
                                ),
                                Text(
                                  "Estimated fuel cost: ₱${((distance*aveGasPrice)/(16.1*1000)).toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                )..show();
              } else {
                TextEditingController _fuelConsumptionController = TextEditingController();
                String _selectedFuelType = 'Diesel';
                String _selectedSortBy = 'Nearest';

                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.noHeader,
                    animType: AnimType.scale,
                    borderSide: BorderSide(
                        color: Constants.irish2,
                        width: 5
                    ),
                    btnOkColor: Colors.grey,
                    btnOkText: "Save",
                    btnOkIcon: Icons.save,
                    btnOkOnPress: (){},
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Average Fuel Consumption (KM/L)',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _fuelConsumptionController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Enter fuel consumption',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Fuel Type',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  DropdownButton<String>(
                                    value: _selectedFuelType,
                                    onChanged: (String? newValue) {

                                      _selectedFuelType = newValue!;

                                    },
                                    items: ['Diesel', 'Gasoline', 'Electric (upcoming)']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                        onTap: () {
                                          // Disable selection for 'Electric (upcoming)'
                                          if (value == 'Electric (upcoming)') {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Electric is an upcoming feature'),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sort by',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  DropdownButton<String>(
                                    value: _selectedSortBy,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedSortBy = newValue!;
                                      });
                                    },
                                    items: ['Nearest', 'Cheapest']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                )..show();
              }
            },
            child: _isTapped?const Icon(Icons.directions_sharp, color: Colors.white,):const Icon(Icons.filter_list_outlined, color: Colors.white),
          )
        ),
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
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,

                  ),

                  if(!_isLoaded)
                    Container(
                      color: Colors.black45,
                    ),

                  if(!_isLoaded)
                    const Center(
                      child: CircularProgressIndicator(color: Constants.primaryColor,),
                    )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.maxFinite,
                child: _isTapped
                    ? GasStationInfo(gasStation: selectedGasStation!.gasStation)
                    : _isLoaded
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: gasStations.length,
                  itemBuilder: (context, index) {
                    GasStation gasStation = gasStations[index].gasStation;
                    return Transform.scale(
                      scale: 0.92,
                      child: Card(
                        margin: const EdgeInsets.only(top: 10),
                        color: Constants.secondaryColor,
                        child: FutureBuilder<String>(
                            future: calculateDistance(currentLocation! , gasStation.stationLocation),
                            builder: (context, snapshot) {
                              return GestureDetector(
                                onTap: ()=>_onSymbolTapped(inMapStations.firstWhere((element) => element.gasStation.stationId == gasStation.stationId).gasStationEntity),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Constants.defaultPadding),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 2.0),
                                        blurRadius: 2,
                                        spreadRadius: 1.0,
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    tileColor: Colors.white,
                                    title: Text(gasStation.stationName, style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),),
                                    subtitle: Text(
                                        (snapshot.connectionState == ConnectionState.waiting
                                            || snapshot.connectionState == ConnectionState.none)
                                            ? "Calculating..."
                                            : snapshot.data!,
                                        style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold)
                                    ),
                                    trailing: priceRangeWidget(priceRange, gasStation.fuel),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    );
                  },
                )
                    : const Center(child: CircularProgressIndicator(color: Constants.primaryColor,))
              )
            )
          ],
        ),
      ),
    );
  }
}