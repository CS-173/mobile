import 'package:flutter/material.dart';
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

  _onMapCreated(MapboxMapController controller) {
    _mapController = controller;
  }

  _onMapStyleLoaded() {

  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
