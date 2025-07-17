import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../auth/server/default_db/sharedprefs_method.dart';

part 'l10n_switcher_event.dart';
part 'l10n_switcher_state.dart';

class LocalizationsBlocController extends Bloc<LocalizationsEvent, LocalizationsState> {
  static const String _localeKey = 'selected_locale';

  // Supported locales by user end
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('fr'),
  ];

  LocalizationsBlocController() : super(const LocalizationsInitial(Locale('en'))) {
    on<LoadSavedLanguageEvent>(_onLoadSavedLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);

    // Load saved language on initialization
    add(LoadSavedLanguageEvent());
  }

  Future<void> _onLoadSavedLanguage(
      LoadSavedLanguageEvent event,
      Emitter<LocalizationsState> emit,
      ) async {
    try {
      final savedLocaleCode = await SharedPrefsHelper.instance.getString(_localeKey);

      if (savedLocaleCode != null) {
        final savedLocale = Locale(savedLocaleCode);

        // Verify the saved locale is supported
        if (supportedLocales.contains(savedLocale)) {
          emit(LocalizationsChanged(savedLocale));
        } else {
          // Fallback to default locale if saved locale is not supported
          emit(const LocalizationsChanged(Locale('en')));
        }
      } else {
        emit(const LocalizationsChanged(Locale('en')));
      }
    } catch (e) {
      emit(LocalizationsError(state.locale, 'Failed to load saved language: $e'));
    }
  }

  Future<void> _onChangeLanguage(
      ChangeLanguageEvent event,
      Emitter<LocalizationsState> emit,
      ) async {
    try {
      emit(LocalizationsLoading(state.locale));
      if (!supportedLocales.contains(event.locale)) {
        emit(LocalizationsError(state.locale, 'Unsupported locale: ${event.locale}'));
        return;
      }
      await SharedPrefsHelper.instance.setString(_localeKey, event.locale.languageCode);
      await Future.delayed(const Duration(milliseconds: 300));
      emit(LocalizationsChanged(event.locale));
    } catch (e) {
      emit(LocalizationsError(state.locale, 'Failed to change language: $e'));
    }
  }
  Locale get currentLocale => state.locale;

  // Helper method to check if a locale is supported
  bool isLocaleSupported(Locale locale) => supportedLocales.contains(locale);
}
