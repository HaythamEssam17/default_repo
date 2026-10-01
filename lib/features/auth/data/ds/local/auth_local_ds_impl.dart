import 'dart:convert';

import 'package:pharmacy/features/auth/data/ds/local/auth_local_ds.dart';
import 'package:pharmacy/features/auth/data/models/auth_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _sessionKey = 'auth_session';

  final SharedPreferences storage;

  const AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> saveSession(AuthSessionModel session) async {
    await storage.setString(_sessionKey, jsonEncode(session.toJson()));
  }

  @override
  Future<AuthSessionModel?> getSession() async {
    final value = storage.getString(_sessionKey);

    if (value == null || value.isEmpty) {
      return null;
    }

    try {
      final json = jsonDecode(value) as Map<String, dynamic>;

      return AuthSessionModel.fromJson(json);
    } catch (_) {
      await clearSession();
      return null;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    final session = await getSession();
    return session?.accessToken;
  }

  @override
  Future<String?> getRefreshToken() async {
    final session = await getSession();
    return session?.refreshToken;
  }

  @override
  Future<bool> hasSession() async {
    final session = await getSession();

    return session != null && session.accessToken.isNotEmpty;
  }

  @override
  Future<void> clearSession() async {
    await storage.remove(_sessionKey);
  }
}
