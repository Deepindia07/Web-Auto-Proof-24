part of 'l10n_switcher_bloc.dart';

@immutable
abstract class LocalizationsState {
  final Locale locale;

  const LocalizationsState(this.locale);
}

class LocalizationsInitial extends LocalizationsState {
  const LocalizationsInitial(super.locale);
}

class LocalizationsLoading extends LocalizationsState {
  const LocalizationsLoading(super.locale);
}

class LocalizationsChanged extends LocalizationsState {
  const LocalizationsChanged(super.locale);
}

class LocalizationsError extends LocalizationsState {
  final String message;

  const LocalizationsError(super.locale, this.message);
}
