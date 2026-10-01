abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageSuccess extends LanguageState {}

class LanguageError extends LanguageState {
  final String message;
  LanguageError(this.message);
}
