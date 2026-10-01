import 'package:get_it/get_it.dart';

import '../location/geolocator_data_source.dart';
import '../location/location_data_source.dart';
import '../location/location_permission_service.dart';
import '../location/location_repository.dart';
import '../location/location_repository_impl.dart';

void registerLocationDependencies(GetIt getIt) {
  getIt.registerLazySingleton<LocationPermissionService>(
    LocationPermissionService.new,
  );

  getIt.registerLazySingleton<LocationDataSource>(() => GeolocatorDataSource());

  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(dataSource: getIt<LocationDataSource>()),
  );
}
