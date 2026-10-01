import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pharmacy/core/enums/auth_status.dart';
import 'package:pharmacy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:pharmacy/features/auth/presentation/bloc/auth_states.dart';

class AuthRouterRefreshNotifier extends ChangeNotifier {
  AuthRouterRefreshNotifier(AuthCubit authCubit) {
    _subscription = authCubit.stream.listen((state) {
      _status = authCubit.authStatus;
      notifyListeners();
    });

    _status = authCubit.authStatus;
  }

  late final StreamSubscription<AuthState> _subscription;

  AuthStatus _status = AuthStatus.initial;

  AuthStatus get status => _status;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
