import 'package:dio/dio.dart';

class NetworkInfo {
  final Dio dio;

  const NetworkInfo({required this.dio});

  Future<bool> get isConnected async {
    try {
      await dio.head(
        '/',
        options: Options(
          sendTimeout: const Duration(seconds: 2),
          receiveTimeout: const Duration(seconds: 2),
        ),
      );

      return true;
    } catch (_) {
      return false;
    }
  }
}
