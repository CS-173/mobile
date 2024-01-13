import 'package:flutter/material.dart';

import '../components/rectangle_icon.dart';
import '../models/gas_station_model.dart';

RectangleIcon priceRangeCalculator(List<double> minMax, List<Fuel> fuelPrices) {
  double average = 0.0;
  for (Fuel fuel in fuelPrices) {
    average += fuel.fuelPrice;
  }
  average /= fuelPrices.length;

  print("$minMax, $average");

  if (average-minMax[0] > (minMax[1]-minMax[0])*0.66) {
    return RectangleIcon(bg: Colors.red[300]!, name: '₱₱₱', color: Colors.red[900]!);
  } else if (average-minMax[0] > (minMax[1]-minMax[0])*0.33) {
    return RectangleIcon(bg: Colors.orange[300]!, name: '₱₱', color: Colors.orange[900]!);
  } else {
    return RectangleIcon(bg: Colors.green[300]!, name: '₱', color: Colors.green[900]!);
  }

}