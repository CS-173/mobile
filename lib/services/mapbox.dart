
import 'package:mapbox_gl/mapbox_gl.dart';
import 'dart:convert';
const accessToken = 'pk.eyJ1IjoiemVkZWMiLCJhIjoiY2xoZzdidjc1MDIxMDNsbnpocmloZXczeSJ9.qsTTfBC6ZB9ncP2rvbCnIw';
const mapStyle = 'mapbox://styles/zedec/clhlz7j8z00kr01pp5she116z';
const initialCameraPosition = LatLng(14.653836, 121.068427);
const double zoom = 14.0;
const String profile = 'mapbox/driving-traffic';
const String geometries = 'geojson';


List<LatLng> parseRouteCoordinates(String responseBody) {
  // Parse the response body to extract route coordinates
  final decoded = json.decode(responseBody);
  final routes = decoded['routes'] as List<dynamic>;
  final geometry = routes[0]['geometry'] as Map<String, dynamic>;
  final coordinates = geometry['coordinates'] as List<dynamic>;

  return coordinates.map((coord) {
    double lat = coord[1];
    double lng = coord[0];
    return LatLng(lat, lng);
  }).toList();
}

double parseDistance1(String responseBody) {
  // Parse the response body to extract route coordinates
  final decoded = json.decode(responseBody);
  final routes = decoded['routes'] as List<dynamic>;
  final distance = routes[0]['distance'];

  return distance;
}