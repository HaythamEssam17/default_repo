import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LanguageCubit extends HydratedCubit<Locale> {
  static const Locale defaultLocale = Locale('en');

  static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  LanguageCubit() : super(defaultLocale);

  void setLanguage(Locale locale) {
    if (!_isSupported(locale)) {
      return;
    }

    emit(locale);
  }

  void setLanguageCode(String languageCode) {
    final locale = Locale(languageCode);

    if (!_isSupported(locale)) {
      return;
    }

    emit(locale);
  }

  void toggleLanguage() {
    emit(state.languageCode == 'ar' ? const Locale('en') : const Locale('ar'));
  }

  bool _isSupported(Locale locale) {
    return supportedLocales.any(
      (supportedLocale) => supportedLocale.languageCode == locale.languageCode,
    );
  }

  @override
  Locale fromJson(Map<String, dynamic> json) {
    final languageCode = json['languageCode'] as String?;

    if (languageCode == null) {
      return defaultLocale;
    }

    return supportedLocales.firstWhere(
      (locale) => locale.languageCode == languageCode,
      orElse: () => defaultLocale,
    );
  }

  @override
  Map<String, dynamic> toJson(Locale state) {
    return {'languageCode': state.languageCode};
  }
}
