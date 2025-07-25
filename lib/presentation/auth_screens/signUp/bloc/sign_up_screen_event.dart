part of 'sign_up_screen_bloc.dart';

@immutable
abstract class SignUpScreenEvent {}

class RegisterUser extends SignUpScreenEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String countryCode;
  final String phoneNumber;
  final String password;
  final bool isEmailVerified;
  final bool termsAndConditions;

  RegisterUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryCode,
    required this.phoneNumber,
    required this.password,
    required this.isEmailVerified,
    required this.termsAndConditions,
  });
}

class SendOtpEmailEvent extends SignUpScreenEvent {
  final String email;

  SendOtpEmailEvent({
    required this.email,
  });
}

class ResetToInitialState extends SignUpScreenEvent {}
