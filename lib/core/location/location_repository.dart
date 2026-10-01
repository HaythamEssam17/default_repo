import '../error/result.dart';
import 'model/location_point.dart';

abstract interface class LocationRepository {
  Future<Result<LocationPoint>> getCurrentLocation();

  Future<Result<bool>> requestPermission();

  Future<Result<bool>> isLocationServiceEnabled();

  Future<Result<bool>> openLocationSettings();

  Future<Result<bool>> openAppSettings();
}
