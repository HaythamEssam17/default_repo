import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/core/enums/auth_status.dart';
import 'package:pharmacy/features/auth/domain/entities/auth_user.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/request_password_reset.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/restore_session.dart';
import '../../domain/usecases/social_login.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final Register registerUseCase;
  final LogoutUseCase logoutUseCase;
  final RestoreSession restoreSessionUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final RequestPasswordReset requestPasswordResetUseCase;
  final ResetPassword resetPasswordUseCase;
  final SocialLogin socialLoginUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.restoreSessionUseCase,
    required this.getCurrentUserUseCase,
    required this.requestPasswordResetUseCase,
    required this.resetPasswordUseCase,
    required this.socialLoginUseCase,
  }) : super(AuthInitial());

  AuthStatus authStatus = AuthStatus.unauthenticated;

  AuthUser? authUser;

  Future<void> restoreSession() async {
    emit(AuthLoading());

    final result = await restoreSessionUseCase();

    result.fold(
      (failure) {
        emit(AuthError(failure.message));
      },
      (session) {
        authUser = session.user;
        authStatus = AuthStatus.authenticated;
        emit(AuthSuccess());
      },
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    final result = await loginUseCase(email: email, password: password);

    result.fold(_emitFailure, (session) {
      authUser = session.user;
      authStatus = AuthStatus.authenticated;
      emit(AuthSuccess());
    });
  }

  Future<void> register({
    required String email,
    required String password,
    String? name,
    String? phone,
  }) async {
    emit(AuthLoading());

    final result = await registerUseCase(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );

    result.fold(_emitFailure, (session) {
      authUser = session.user;
      authStatus = AuthStatus.authenticated;
      emit(AuthSuccess());
    });
  }

  Future<void> socialLogin({
    required String provider,
    required String accessToken,
  }) async {
    emit(AuthLoading());

    final result = await socialLoginUseCase(
      provider: provider,
      accessToken: accessToken,
    );

    result.fold(_emitFailure, (session) {
      authUser = session.user;
      authStatus = AuthStatus.authenticated;
      emit(AuthSuccess());
    });
  }

  Future<void> requestPasswordReset({required String email}) async {
    emit(AuthLoading());

    final result = await requestPasswordResetUseCase(email: email);

    result.fold(_emitFailure, (_) {
      authStatus = AuthStatus.unauthenticated;
      authUser = null;
      emit(AuthSuccess());
    });
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    emit(AuthLoading());

    final result = await resetPasswordUseCase(
      token: token,
      newPassword: newPassword,
    );

    result.fold(_emitFailure, (user) {
      user = user;
      authStatus = AuthStatus.unauthenticated;
      emit(AuthSuccess());
    });
  }

  Future<void> getCurrentUser() async {
    emit(AuthLoading());

    final result = await getCurrentUserUseCase();

    result.fold(_emitFailure, (user) {
      user = user;
      authStatus = AuthStatus.authenticated;
      emit(AuthSuccess());
    });
  }

  Future<void> logout() async {
    emit(AuthLoading());

    await logoutUseCase();

    authStatus = AuthStatus.unauthenticated;
    authUser = null;
    emit(AuthInitial());
  }

  void _emitFailure(Failure failure) {
    emit(AuthError(failure.message));
  }
}
