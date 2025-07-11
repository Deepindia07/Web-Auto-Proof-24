part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenEvent {}

class LoginSubmitted extends LoginScreenEvent {
  final String emailOrPhone;
  final String password;

  LoginSubmitted({
    required this.emailOrPhone,
    required this.password,
  });
}

class LoginReset extends LoginScreenEvent {}