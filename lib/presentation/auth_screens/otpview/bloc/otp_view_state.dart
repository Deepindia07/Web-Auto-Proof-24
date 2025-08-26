part of 'otp_view_bloc.dart';

@immutable
abstract class OtpViewState {}

class OtpViewInitial extends OtpViewState {}

class OtpViewLoading extends OtpViewState {}

class OtpViewSuccess extends OtpViewState {
  final VerifyOtpResponseModel response;

  OtpViewSuccess({required this.response});
}

class OtpViewFailure extends OtpViewState {
  final String error;

  OtpViewFailure({required this.error});
}

class OtpResendSuccess extends OtpViewState {
  final String message;

  OtpResendSuccess({required this.message});
}

class OtpResendFailure extends OtpViewState {
  final String error;

  OtpResendFailure({required this.error});
}

class OtpVerifyPhoneLoading extends OtpViewState{

}

class OtpVerifyPhoneSuccess extends OtpViewState{
  final VerifyOtpResponseModel response;

  OtpVerifyPhoneSuccess ({required this.response});

}

class OtpVerifyPhoneError extends OtpViewState{
  final String error ;
  OtpVerifyPhoneError({required this.error});
}