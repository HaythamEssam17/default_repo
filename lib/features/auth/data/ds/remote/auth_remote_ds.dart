import 'package:pharmacy/features/auth/data/models/auth_session_model.dart';
import 'package:pharmacy/features/auth/data/models/auth_user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  Future<AuthSessionModel> register({
    required String email,
    required String password,
    String? name,
    String? phone,
  });

  Future<void> requestPasswordReset({required String email});

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<AuthSessionModel> socialLogin({
    required String provider,
    required String accessToken,
  });

  Future<AuthSessionModel> refreshSession({required String refreshToken});

  Future<AuthUserModel> getCurrentUser();

  Future<void> logout();
}
