import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacy/app/router/app_router.dart';
import 'package:pharmacy/core/theme/app_theme.dart';
import 'package:pharmacy/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:pharmacy/features/language/presentation/bloc/language_cubit.dart';
import 'package:pharmacy/features/theme/presentation/bloc/theme_cubit.dart';

import '../core/di/injection.dart';
import '../core/localization/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: getIt<ThemeCubit>()),
        BlocProvider<LanguageCubit>.value(value: getIt<LanguageCubit>()),
        BlocProvider<AuthCubit>.value(value: getIt<AuthCubit>()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;

    final locale = context.watch<LanguageCubit>().state;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      routerConfig: AppRouter.router,

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,

      locale: locale,

      supportedLocales: LanguageCubit.supportedLocales,

      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
