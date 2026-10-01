import 'package:get_it/get_it.dart';

import '../domain/repositories/notifications_repository.dart';
import '../data/repositories/notifications_repo_impl.dart';
import '../data/ds/remote/notifications_remote_ds.dart';
import '../data/ds/remote/notifications_remote_ds_impl.dart';
import '../domain/usecases/notifications_usecase.dart';
import '../presentation/bloc/notifications_cubit.dart';

void notificationsModule(GetIt sl) {
  // DataSource
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(sl()),
  );

  // UseCase
  sl.registerLazySingleton(() => NotificationsUseCase(sl()));

  // Bloc
  sl.registerLazySingleton(
    () => NotificationsCubit(sl()),
  );
}
