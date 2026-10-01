import 'package:pharmacy/core/network/api_client.dart';
import 'package:pharmacy/features/auth/data/ds/remote/auth_remote_ds.dart';
import 'package:pharmacy/features/auth/data/models/auth_session_model.dart';
import 'package:pharmacy/features/auth/data/models/auth_user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  const AuthRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    return AuthSessionModel.fromJson(response.data ?? {});
  }

  @override
  Future<AuthSessionModel> register({
    required String email,
    required String password,
    String? name,
    String? phone,
  }) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
        'phone': phone,
      },
    );

    return AuthSessionModel.fromJson(response.data ?? {});
  }

  @override
  Future<void> requestPasswordReset({required String email}) async {
    await apiClient.post('/auth/forgot-password', data: {'email': email});
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await apiClient.post(
      '/auth/reset-password',
      data: {'token': token, 'password': newPassword},
    );
  }

  @override
  Future<AuthSessionModel> socialLogin({
    required String provider,
    required String accessToken,
  }) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      '/auth/social-login',
      data: {'provider': provider, 'access_token': accessToken},
    );

    return AuthSessionModel.fromJson(response.data ?? {});
  }

  @override
  Future<AuthSessionModel> refreshSession({
    required String refreshToken,
  }) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {'refresh_token': refreshToken},
    );

    return AuthSessionModel.fromJson(response.data ?? {});
  }

  @override
  Future<AuthUserModel> getCurrentUser() async {
    final response = await apiClient.get<Map<String, dynamic>>('/auth/me');

    return AuthUserModel.fromJson(response.data ?? {});
  }

  @override
  Future<void> logout() async {
    await apiClient.post('/auth/logout');
  }
}
