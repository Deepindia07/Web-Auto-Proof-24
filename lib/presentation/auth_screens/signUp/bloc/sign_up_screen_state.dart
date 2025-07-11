part of 'sign_up_screen_bloc.dart';

@immutable
abstract class SignUpScreenState {}

class SignUpScreenInitial extends SignUpScreenState {}

class SignUpScreenLoading extends SignUpScreenState {}

class SignUpScreenSuccess extends SignUpScreenState {
  final RegistrationResponseModel response;

  SignUpScreenSuccess(this.response);
}

class SignUpScreenError extends SignUpScreenState {
  final String message;

  SignUpScreenError(this.message);
}
