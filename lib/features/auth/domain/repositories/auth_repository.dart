import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../entities/auth_user.dart';

abstract interface class AuthRepository {
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  });

  Future<Result<AuthSession>> register({
    required String email,
    required String password,
    String? name,
    String? phone,
  });

  Future<Result<void>> requestPasswordReset({required String email});

  Future<Result<void>> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<Result<AuthSession>> socialLogin({
    required String provider,
    required String accessToken,
  });

  Future<Result<AuthSession>> restoreSession();

  Future<Result<AuthUser>> getCurrentUser();

  Future<Result<void>> logout();
}
