import 'package:pharmacy/features/auth/domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  AuthUserModel({
    required super.id,
    super.email,
    super.name,
    super.phone,
    super.avatarUrl,
    super.emailVerified,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      emailVerified: json['email_verified'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'avatar_url': avatarUrl,
      'email_verified': emailVerified,
    };
  }
}
