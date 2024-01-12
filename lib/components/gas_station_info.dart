import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/gas_station_model.dart';

class GasStationInfo extends StatelessWidget {
  const GasStationInfo({
    super.key,
    required this.gasStations,
  });

  final List<GasStationCircle> gasStations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gasStations[0].gasStation.stationName,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
        Text(
          gasStations[0].gasStation.isOpen?"Open":"Closed",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        )
      ],
    );
  }
}