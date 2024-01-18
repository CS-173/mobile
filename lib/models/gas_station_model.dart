import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GasStation {
  String stationId;
  String stationName;
  GeoPoint stationLocation;
  bool isOpen;
  Map<String, bool> paymentMethods;
  Map<String, List<int>> operatingHours;
  List<Fuel> fuel;

  GasStation({
    required this.stationId,
    required this.stationName,
    required this.stationLocation,
    required this.isOpen,
    required this.paymentMethods,
    required this.operatingHours,
    required this.fuel,
  });

  factory GasStation.fromFirestore(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return GasStation(
      stationId: document.id,
      stationName: data['stationName'] ?? '',
      stationLocation: data['stationLocation'] ?? const GeoPoint(0.0, 0.0),
      isOpen: data['isOpen'] ?? false,
      paymentMethods: Map<String, bool>.from(data['paymentMethods'] ?? {}),
      operatingHours: Map<String, List<int>>.from(
        (data['operatingHours'] as Map<String, dynamic>?)?.map(
              (key, value) => MapEntry(key, (value as List<dynamic>?)?.cast<int>() ?? []),
        ) ?? {},
      ),
      fuel: List<Fuel>.from(
        (data['fuel'] as List<dynamic>? ?? []).map(
              (fuelData) => Fuel.fromMap(fuelData),
        ),
      ),
    );
  }
}

class Fuel {
  double fuelPrice;
  String fuelName;
  bool fuelAvailable;

  Fuel({
    required this.fuelPrice,
    required this.fuelName,
    required this.fuelAvailable,
  });

  factory Fuel.fromMap(Map<String, dynamic> fuelData) {
    return Fuel(
      fuelPrice: fuelData['fuelPrice'].toDouble() ?? 0.0,
      fuelName: fuelData['fuelName'] ?? '',
      fuelAvailable: fuelData['fuelAvailable'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fuelPrice': fuelPrice,
      'fuelName': fuelName,
      'fuelAvailable': fuelAvailable,
    };
  }
}

class GasStationEntity {
  final GasStation gasStation;
  final Symbol gasStationEntity;

  GasStationEntity({required this.gasStation, required this.gasStationEntity});
}