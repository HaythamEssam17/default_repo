import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pharmacy/core/enums/auth_status.dart';
import 'package:pharmacy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:pharmacy/features/auth/presentation/pages/login_home_page.dart';

import '../../core/di/injection.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import 'auth_router_refresh_notifier.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final AuthCubit _authCubit = getIt<AuthCubit>();

  static final AuthRouterRefreshNotifier _authRefreshNotifier =
      AuthRouterRefreshNotifier(_authCubit);

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,

    initialLocation: '/splash',

    refreshListenable: _authRefreshNotifier,

    redirect: (context, state) {
      final authStatus = _authCubit.authStatus;
      final location = state.matchedLocation;

      final isSplash = location == '/splash';
      final isAuthRoute =
          location == '/login' ||
          location == '/register' ||
          location == '/forgot-password' ||
          location == '/reset-password';

      // ------------------------------------------------------------
      // 1. App is restoring the previous session.
      // ------------------------------------------------------------
      if (authStatus == AuthStatus.initial ||
          authStatus == AuthStatus.loading) {
        return isSplash ? null : '/splash';
      }

      // ------------------------------------------------------------
      // 2. User is authenticated.
      // ------------------------------------------------------------
      if (authStatus == AuthStatus.authenticated) {
        if (isSplash || isAuthRoute) {
          return '/';
        }

        return null;
      }

      // ------------------------------------------------------------
      // 3. User is not authenticated.
      // ------------------------------------------------------------
      if (authStatus == AuthStatus.unauthenticated ||
          authStatus == AuthStatus.failure) {
        if (isAuthRoute) {
          return null;
        }

        return '/login';
      }

      return null;
    },

    routes: [
      // --------------------------------------------------------------
      // Splash
      // --------------------------------------------------------------
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) {
          return const SplashPage();
        },
      ),

      // --------------------------------------------------------------
      // Login
      // --------------------------------------------------------------
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) {
          return const LoginHomePage();
        },
      ),

      // --------------------------------------------------------------
      // Register
      // --------------------------------------------------------------
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) {
          return const _PlaceholderPage(title: 'Register');
        },
      ),

      // --------------------------------------------------------------
      // Forgot Password
      // --------------------------------------------------------------
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) {
          return const _PlaceholderPage(title: 'Forgot Password');
        },
      ),

      // --------------------------------------------------------------
      // Reset Password
      // --------------------------------------------------------------
      GoRoute(
        path: '/reset-password',
        name: 'reset-password',
        builder: (context, state) {
          return const _PlaceholderPage(title: 'Reset Password');
        },
      ),

      // --------------------------------------------------------------
      // Home
      // --------------------------------------------------------------
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) {
          return const _PlaceholderPage(title: 'Home');
        },
      ),
    ],
  );
}

class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
