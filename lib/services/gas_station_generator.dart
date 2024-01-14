import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/gas_station_model.dart';

Future<void> addGasStationToFirestore(Map<String, dynamic> jsonData) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference gasStationsCollection = FirebaseFirestore.instance.collection('gas_stations');

    // Create a new document with an auto-generated ID
    DocumentReference newGasStationRef = gasStationsCollection.doc();

    // Convert JSON data to GasStation object
    GasStation newGasStation = GasStation(
      stationId: newGasStationRef.id,
      stationName: jsonData['stationName'] ?? '',
      stationLocation: jsonData['stationLocation'] ?? GeoPoint(0.0, 0.0),
      isOpen: jsonData['isOpen'] ?? false,
      paymentMethods: Map<String, bool>.from(jsonData['paymentMethods'] ?? {}),
      operatingHours: Map<String, List<int>>.from(
        (jsonData['operatingHours'] as Map<String, dynamic>?)?.map(
              (key, value) => MapEntry(key, (value as List<dynamic>?)?.cast<int>() ?? []),
        ) ?? {},
      ),
      fuel: List<Fuel>.from(
        (jsonData['fuel'] as List<dynamic>? ?? []).map(
              (fuelData) => Fuel.fromMap(fuelData),
        ),
      ),
    );

    // Convert GasStation object to a map
    Map<String, dynamic> gasStationData = {
      'stationName': newGasStation.stationName,
      'stationLocation': newGasStation.stationLocation,
      'isOpen': newGasStation.isOpen,
      'paymentMethods': newGasStation.paymentMethods,
      'operatingHours': newGasStation.operatingHours,
      'fuel': newGasStation.fuel.map((fuel) => fuel.toMap()).toList(),
    };

    // Add the new document to the collection
    await newGasStationRef.set(gasStationData);

    print('Gas station added successfully!');
  } catch (e) {
    print('Error adding gas station: $e');
  }
}