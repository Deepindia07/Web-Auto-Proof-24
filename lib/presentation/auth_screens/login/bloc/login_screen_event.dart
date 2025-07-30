part of 'login_screen_bloc.dart';

@immutable
abstract class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginScreenEvent {
  final String emailOrPhone;
  final String password;
  final String refNo;

  const LoginSubmitted({
    required this.emailOrPhone,
    required this.password,
    required this.refNo
  });

  @override
  List<Object> get props => [emailOrPhone, password, refNo];
}

class LoginReset extends LoginScreenEvent {}

class EmailValidationCheck extends LoginScreenEvent {
  final String emailOrPhone;

  const EmailValidationCheck({
    required this.emailOrPhone,
  });

  @override
  List<Object> get props => [emailOrPhone];
}
