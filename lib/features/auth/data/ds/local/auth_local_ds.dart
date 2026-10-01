import 'package:pharmacy/features/auth/data/models/auth_session_model.dart';

abstract interface class AuthLocalDataSource {
  Future<void> saveSession(AuthSessionModel session);

  Future<AuthSessionModel?> getSession();

  Future<String?> getAccessToken();

  Future<String?> getRefreshToken();

  Future<bool> hasSession();

  Future<void> clearSession();
}
