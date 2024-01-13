import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../components/rectangle_icon.dart';
import '../models/gas_station_model.dart';
import '../modules/distance_calculator.dart';
import '../style/constants.dart';


class GasStationList extends StatelessWidget {
  const GasStationList({super.key, required this.gasStations, required this.currentLocation});

  final List<GasStationCircle> gasStations;
  final LocationData currentLocation;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: gasStations.length,
      itemBuilder: (context, index) {
        GasStation gasStation = gasStations[index].gasStation;
        return Card(
          margin: const EdgeInsets.only(top: 10),
          color: Constants.secondaryColor,
          child: FutureBuilder<String>(
            future: calculateDistance(currentLocation , gasStation.stationLocation),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
                return ListTile(title: Text("Calculating Distance..."));
              } return ListTile(
                title: Text(gasStation.stationName, style: TextStyle(color: Colors.white.withOpacity(0.8)),),
                subtitle: Text(snapshot.data!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                trailing: RectangleIcon(bg: Colors.red[300]!, name: '₱₱₱', color: Colors.red[900]!,),
              );
            }
          ),
        );
      },
    );
  }
}
