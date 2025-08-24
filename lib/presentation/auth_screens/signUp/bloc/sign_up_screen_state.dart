part of 'sign_up_screen_bloc.dart';

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

class SendOtpScreenLoading extends SignUpScreenState {}

class SendOtpOnEmailSuccess extends SignUpScreenState {
  final OtpForEmailResponseModel response;

  SendOtpOnEmailSuccess(this.response);
}

class SendOtpOnEmailError extends SignUpScreenState {
  final String message;

  SendOtpOnEmailError(this.message);
}

class SignUpSendOtpScreenLoading extends SignUpScreenState {}

class SignUpSendOtpOnEmailSuccess extends SignUpScreenState {
  final OtpForEmailResponseModel response;

  SignUpSendOtpOnEmailSuccess(this.response);
}

class SignUpSendOtpOnEmailError extends SignUpScreenState {
  final String message;

  SignUpSendOtpOnEmailError(this.message);
}


class SignUpSendOtpPhoneLoading extends SignUpScreenState{
  List<Object> get props => [];
}

