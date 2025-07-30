part of 'login_screen_bloc.dart';

@immutable
abstract class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object?> get props => [];
}

class LoginScreenInitial extends LoginScreenState {}

class LoginLoading extends LoginScreenState {}

class LoginSuccess extends LoginScreenState {
  final LoginResponseModel? loginResponse;


  const LoginSuccess({required this.loginResponse});

  @override
  List<Object?> get props => [loginResponse];
}

class EmployeeLoginSuccess extends LoginScreenState {
  final EmployeeLoginResponseModel employeeLoginResponseModel;

  const EmployeeLoginSuccess({required this.employeeLoginResponseModel});

  @override
  List<Object?> get props => [employeeLoginResponseModel];
}

class LoginFailure extends LoginScreenState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class EmailValidationLoading extends LoginScreenState {}

class EmailValidationSuccess extends LoginScreenState {
  final String emailOrPhone;
  final ForgotResponseModel forgotResponse;

  const EmailValidationSuccess({
    required this.emailOrPhone,
    required this.forgotResponse,
  });

  @override
  List<Object> get props => [emailOrPhone, forgotResponse];
}

class EmailValidationFailure extends LoginScreenState {
  final String error;

  const EmailValidationFailure({required this.error});

  @override
  List<Object> get props => [error];
}