import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/api_client.dart';
import '../data/ds/local/auth_local_ds.dart';
import '../data/ds/local/auth_local_ds_impl.dart';
import '../data/ds/remote/auth_remote_ds.dart';
import '../data/ds/remote/auth_remote_ds_impl.dart';
import '../data/repositories/auth_repo_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/get_current_user.dart';
import '../domain/usecases/login.dart';
import '../domain/usecases/logout.dart';
import '../domain/usecases/register.dart';
import '../domain/usecases/request_password_reset.dart';
import '../domain/usecases/reset_password.dart';
import '../domain/usecases/restore_session.dart';
import '../domain/usecases/social_login.dart';
import '../presentation/bloc/auth_cubit.dart';

void registerAuthDependencies(GetIt getIt) {
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storage: getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: getIt<ApiClient>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<Register>(
    () => Register(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RestoreSession>(
    () => RestoreSession(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RequestPasswordReset>(
    () => RequestPasswordReset(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<ResetPassword>(
    () => ResetPassword(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<SocialLogin>(
    () => SocialLogin(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<AuthCubit>(
    () => AuthCubit(
      loginUseCase: getIt<LoginUseCase>(),
      registerUseCase: getIt<Register>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      restoreSessionUseCase: getIt<RestoreSession>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
      requestPasswordResetUseCase: getIt<RequestPasswordReset>(),
      resetPasswordUseCase: getIt<ResetPassword>(),
      socialLoginUseCase: getIt<SocialLogin>(),
    ),
  );
}
