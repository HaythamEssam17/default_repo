import 'package:get_it/get_it.dart';

import '../presentation/bloc/theme_cubit.dart';

void themeModule(GetIt sl) {
  sl.registerLazySingleton<ThemeCubit>(ThemeCubit.new);
}
