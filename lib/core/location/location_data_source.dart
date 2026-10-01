import 'package:geolocator/geolocator.dart';

import 'model/location_point.dart';

abstract interface class LocationDataSource {
  Future<LocationPoint> getCurrentLocation();

  Future<LocationPermission> requestPermission();

  Future<LocationPermission> checkPermission();

  Future<bool> isLocationServiceEnabled();

  Future<bool> openLocationSettings();

  Future<bool> openAppSettings();
}
