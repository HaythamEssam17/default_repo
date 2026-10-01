import 'package:get_it/get_it.dart';

import '../presentation/bloc/language_cubit.dart';

void languageModule(GetIt sl) {
  sl.registerLazySingleton(LanguageCubit.new);
}
