part of 'l10n_switcher_bloc.dart';

@immutable
abstract class LocalizationsEvent {}

class ChangeLanguageEvent extends LocalizationsEvent {
  final Locale locale;

  ChangeLanguageEvent(this.locale);
}

class LoadSavedLanguageEvent extends LocalizationsEvent {}
