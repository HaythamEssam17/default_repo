import 'package:geolocator/geolocator.dart';

import 'location_data_source.dart';
import 'model/location_point.dart';

class GeolocatorDataSource implements LocationDataSource {
  @override
  Future<LocationPoint> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    return LocationPoint(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  @override
  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  @override
  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  @override
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  @override
  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }
}
