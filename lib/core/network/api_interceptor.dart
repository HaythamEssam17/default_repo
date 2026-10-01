import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add auth token / headers here later.

    options.headers.addAll({
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    });

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Global logging / token refresh can be handled here later.

    handler.next(err);
  }
}
