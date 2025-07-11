part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenState {}

final class LoginScreenInitial extends LoginScreenState {}

class LoginLoading extends LoginScreenState {}

class LoginSuccess extends LoginScreenState {
  final LoginResponseModel loginResponse;

  LoginSuccess({required this.loginResponse});
}

class LoginFailure extends LoginScreenState {
  final String error;

  LoginFailure({required this.error});
}