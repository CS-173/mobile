import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import '../services/mapbox.dart';

Future<String> calculateDistance(LocationData start, GeoPoint end) async {
  double distanceInMeters = Geolocator.distanceBetween(
    start.latitude!,
    start.longitude!,
    end.latitude,
    end.longitude,
  );

  String _unit = "meters";

  if (distanceInMeters > 1000) {
    distanceInMeters /= 1000;
    _unit = "km";
  }

  return "${distanceInMeters.toStringAsFixed(_unit=="km"?1:0)} $_unit";
}
