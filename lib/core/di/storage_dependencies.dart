import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/app_storage.dart';
import '../storage/shared_preferences_storage.dart';

Future<void> registerStorageDependencies(GetIt getIt) async {
  final preferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(preferences);

  getIt.registerLazySingleton<AppStorage>(
    () => SharedPreferencesStorage(preferences: getIt<SharedPreferences>()),
  );
}
