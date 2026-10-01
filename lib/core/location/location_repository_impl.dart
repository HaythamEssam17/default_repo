import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../error/failure.dart';
import '../error/result.dart';
import 'location_data_source.dart';
import 'location_repository.dart';
import 'model/location_point.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  const LocationRepositoryImpl({required this.dataSource});

  @override
  Future<Result<LocationPoint>> getCurrentLocation() async {
    try {
      final serviceEnabled = await dataSource.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return const Left(
          LocationFailure(message: 'Location service is disabled.'),
        );
      }

      final permission = await dataSource.checkPermission();

      if (permission == LocationPermission.denied) {
        final requestedPermission = await dataSource.requestPermission();

        if (requestedPermission == LocationPermission.denied) {
          return const Left(
            PermissionFailure(message: 'Location permission was denied.'),
          );
        }
      }

      final finalPermission = await dataSource.checkPermission();

      if (finalPermission == LocationPermission.deniedForever) {
        return const Left(
          PermissionFailure(
            message: 'Location permission is permanently denied.',
          ),
        );
      }

      final location = await dataSource.getCurrentLocation();

      return Right(location);
    } catch (e) {
      return Left(
        LocationFailure(
          message: 'Unable to get current location.',
          exception: e,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> requestPermission() async {
    try {
      final permission = await dataSource.requestPermission();

      return Right(
        permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse,
      );
    } catch (e) {
      return Left(
        LocationFailure(
          message: 'Unable to request location permission.',
          exception: e,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> isLocationServiceEnabled() async {
    try {
      return Right(await dataSource.isLocationServiceEnabled());
    } catch (e) {
      return Left(
        LocationFailure(
          message: 'Unable to check location service.',
          exception: e,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> openLocationSettings() async {
    try {
      return Right(await dataSource.openLocationSettings());
    } catch (e) {
      return Left(
        LocationFailure(
          message: 'Unable to open location settings.',
          exception: e,
        ),
      );
    }
  }

  @override
  Future<Result<bool>> openAppSettings() async {
    try {
      return Right(await dataSource.openAppSettings());
    } catch (e) {
      return Left(
        LocationFailure(message: 'Unable to open app settings.', exception: e),
      );
    }
  }
}
