class AuthUser {
  final String id;
  final String? email;
  final String? name;
  final String? phone;
  final String? avatarUrl;
  final bool emailVerified;

  const AuthUser({
    required this.id,
    this.email,
    this.name,
    this.phone,
    this.avatarUrl,
    this.emailVerified = false,
  });
}
