sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  AuthSuccess();
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// class AuthState {
//   final AuthStatus status;
//   final AuthUser? user;
//   final String? errorMessage;

//   const AuthState({
//     this.status = AuthStatus.initial,
//     this.user,
//     this.errorMessage,
//   });

//   bool get isAuthenticated => status == AuthStatus.authenticated;

//   bool get isLoading => status == AuthStatus.loading;

//   AuthState copyWith({
//     AuthStatus? status,
//     AuthUser? user,
//     String? errorMessage,
//     bool clearUser = false,
//     bool clearError = false,
//   }) {
//     return AuthState(
//       status: status ?? this.status,
//       user: clearUser ? null : user ?? this.user,
//       errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
//     );
//   }
// }
