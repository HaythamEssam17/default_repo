import 'package:get_it/get_it.dart';
import 'package:pharmacy/core/di/core_dependencies.dart';
import 'package:pharmacy/core/di/location_dependencies.dart';
import 'package:pharmacy/core/di/network_dependencies.dart';
import 'package:pharmacy/core/di/storage_dependencies.dart';
import 'package:pharmacy/features/auth/di/auth_module.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  await registerStorageDependencies(getIt);
  registerNetworkDependencies(getIt);
  registerLocationDependencies(getIt);
  registerCoreDependencies(getIt);
  registerAuthDependencies(getIt);
}
