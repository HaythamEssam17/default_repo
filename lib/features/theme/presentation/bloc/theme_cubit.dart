import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void setThemeMode(ThemeMode mode) {
    emit(mode);
  }

  void toggleTheme() {
    emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  ThemeMode fromJson(Map<String, dynamic> json) {
    final value = json['themeMode'] as String?;

    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Map<String, dynamic> toJson(ThemeMode state) {
    return {'themeMode': state.name};
  }
}
