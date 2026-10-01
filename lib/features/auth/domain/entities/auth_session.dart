import 'auth_user.dart';

class AuthSession {
  final String accessToken;
  final String? refreshToken;
  final DateTime? expiresAt;
  final AuthUser user;

  const AuthSession({
    required this.accessToken,
    this.refreshToken,
    this.expiresAt,
    required this.user,
  });

  bool get isExpired {
    if (expiresAt == null) {
      return false;
    }

    return DateTime.now().isAfter(expiresAt!);
  }
}
