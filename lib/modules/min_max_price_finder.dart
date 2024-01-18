import 'dart:math';

import '../models/gas_station_model.dart';

List<double> findOverallMinMaxFuelPrices(List<GasStationEntity> gasStations) {
  List<double> prices = [];

  for (GasStationEntity gasStationCircle in gasStations) {
    for (Fuel fuel in gasStationCircle.gasStation.fuel) {
      prices.add(fuel.fuelPrice);
    }
  }
  
  return [prices.reduce((min, current) => min < current ? min : current), prices.reduce((max, current) => max > current ? max : current)];
}