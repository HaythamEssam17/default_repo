import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../ds/local/auth_local_ds.dart';
import '../ds/remote/auth_remote_ds.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await remoteDataSource.login(
        email: email,
        password: password,
      );

      await localDataSource.saveSession(session);

      return Right(session);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Result<AuthSession>> register({
    required String email,
    required String password,
    String? name,
    String? phone,
  }) async {
    try {
      final session = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );

      await localDataSource.saveSession(session);

      return Right(session);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Result<void>> requestPasswordReset({required String email}) async {
    try {
      await remoteDataSource.requestPasswordReset(email: email);

      return const Right(null);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Result<void>> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        token: token,
        newPassword: newPassword,
      );

      return const Right(null);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Result<AuthSession>> socialLogin({
    required String provider,
    required String accessToken,
  }) async {
    try {
      final session = await remoteDataSource.socialLogin(
        provider: provider,
        accessToken: accessToken,
      );

      await localDataSource.saveSession(session);

      return Right(session);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Result<AuthSession>> restoreSession() async {
    try {
      final localSession = await localDataSource.getSession();

      if (localSession == null) {
        return const Left(UnauthorizedFailure(message: 'No active session.'));
      }

      if (!localSession.isExpired) {
        return Right(localSession);
      }

      final refreshToken = localSession.refreshToken;

      if (refreshToken == null || refreshToken.isEmpty) {
        await localDataSource.clearSession();

        return const Left(UnauthorizedFailure(message: 'Session expired.'));
      }

      final refreshedSession = await remoteDataSource.refreshSession(
        refreshToken: refreshToken,
      );

      await localDataSource.saveSession(refreshedSession);

      return Right(refreshedSession);
    } catch (e) {
      await localDataSource.clearSession();

      return Left(_mapException(e));
    }
  }

  @override
  Future<Result<AuthUser>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();

      return Right(user);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      try {
        await remoteDataSource.logout();
      } catch (_) {
        // Local session must still be cleared.
      }

      await localDataSource.clearSession();

      return const Right(null);
    } catch (e) {
      return Left(_mapException(e));
    }
  }

  Failure _mapException(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;

      switch (statusCode) {
        case 400:
          return ValidationFailure(
            message: _extractMessage(error),
            exception: error,
          );

        case 401:
          return UnauthorizedFailure(
            message: _extractMessage(error),
            exception: error,
          );

        case 403:
          return ForbiddenFailure(
            message: _extractMessage(error),
            exception: error,
          );

        case 404:
          return NotFoundFailure(
            message: _extractMessage(error),
            exception: error,
          );
      }

      if (error.type == DioExceptionType.connectionError) {
        return NetworkFailure(exception: error);
      }

      return ServerFailure(message: _extractMessage(error), exception: error);
    }

    return UnknownFailure(exception: error);
  }

  String _extractMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];

      if (message != null) {
        return message.toString();
      }
    }

    return error.message ?? 'An unexpected error occurred.';
  }
}
