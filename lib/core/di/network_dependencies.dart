import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api_client.dart';
import '../network/api_interceptor.dart';
import '../network/network_info.dart';

void registerNetworkDependencies(GetIt getIt) {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    ),
  );

  dio.interceptors.add(ApiInterceptor());

  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(dio: getIt<Dio>()));

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfo(dio: getIt<Dio>()),
  );
}
