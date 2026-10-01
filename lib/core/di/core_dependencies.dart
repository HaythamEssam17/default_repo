import 'package:get_it/get_it.dart';
import 'package:pharmacy/features/language/di/language_module.dart';
import 'package:pharmacy/features/theme/di/theme_module.dart';

void registerCoreDependencies(GetIt getIt) {
  languageModule(getIt);
  themeModule(getIt);
}
