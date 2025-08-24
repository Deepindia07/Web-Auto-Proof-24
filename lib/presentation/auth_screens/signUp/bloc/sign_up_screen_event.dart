part of 'sign_up_screen_bloc.dart';

abstract class SignUpScreenEvent extends Equatable{}

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

  @override
  // TODO: implement props
  List<Object?> get props =>  [];
}

class SendOtpEmailEvent extends SignUpScreenEvent {
  final String email;

  SendOtpEmailEvent({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props =>  [];
}

class SendOtpEmailSignUpEvent extends SignUpScreenEvent {
  final String email;

  SendOtpEmailSignUpEvent({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props =>  [];
}

class ResetToInitialState extends SignUpScreenEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class SendOtpPhoneEvent extends SignUpScreenEvent{
  final String phoneNumber;
   SendOtpPhoneEvent({required this.phoneNumber});
  @override
  List<Object> get props => [];
}