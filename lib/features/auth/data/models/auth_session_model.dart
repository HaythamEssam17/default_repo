import 'package:pharmacy/features/auth/data/models/auth_user_model.dart';

import '../../domain/entities/auth_session.dart';

class AuthSessionModel extends AuthSession {
  AuthSessionModel({
    required super.accessToken,
    required super.user,
    super.expiresAt,
    super.refreshToken,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      accessToken: json['access_token'],
      expiresAt: json['expires_at'],
      refreshToken: json['refresh_token'],
      user: AuthUserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_at': expiresAt?.toIso8601String(),
      'user': (user as AuthUserModel).toJson(),
    };
  }
}
