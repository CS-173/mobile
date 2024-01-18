import 'package:flutter/material.dart';

import '../components/rectangle_icon.dart';
import '../models/gas_station_model.dart';
import '../style/constants.dart';

RectangleIcon priceRangeWidget(List<double> minMax, List<Fuel> fuelPrices) {

  double average = priceRangeCalculator(minMax, fuelPrices);

  if (minMax[0] == 0 && minMax[1] == 1000) {
    return RectangleIcon(bg: Colors.grey[200]!, name: '...', color: Colors.grey[900]!);
  } else if (average-minMax[0] > (minMax[1]-minMax[0])*0.66) {
    return RectangleIcon(bg: Constants.irish1, name: '~₱${average.toStringAsFixed(1)}', color: Constants.white);
  } else if (average-minMax[0] > (minMax[1]-minMax[0])*0.33) {
    return RectangleIcon(bg: Constants.irish4, name: '~₱${average.toStringAsFixed(1)}', color: Constants.white);
  } else {
    return RectangleIcon(bg: Constants.irish3, name: '~₱${average.toStringAsFixed(1)}', color: Constants.white);
  }
}

double priceRangeCalculator(List<double> minMax, List<Fuel> fuelPrices) {
  double average = 0.0;

  for (Fuel fuel in fuelPrices) {
    average += fuel.fuelPrice;
  }
  average /= fuelPrices.length;

  return average;
}