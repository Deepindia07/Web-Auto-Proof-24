part of 'about_app_bloc.dart';

abstract class AboutAppState {}

class AboutAppLoading extends AboutAppState {}

class AboutAppLoaded extends AboutAppState {
  final String version;

  AboutAppLoaded({required this.version});
}

class AboutAppError extends AboutAppState {
  final String message;

  AboutAppError(this.message);
}
