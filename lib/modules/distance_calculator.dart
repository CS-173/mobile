import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

Future<String> calculateDistance(
    LocationData start,
    GeoPoint end
    ) async {
  double distanceInMeters = Geolocator.distanceBetween(
    start.latitude!,
    start.longitude!,
    end.latitude,
    end.longitude,
  );

  if (distanceInMeters > 1000) {
    distanceInMeters / 1000;
  }

  return distanceInMeters.toStringAsFixed(2);
}
