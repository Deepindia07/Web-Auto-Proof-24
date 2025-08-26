part of 'otp_view_bloc.dart';

@immutable
abstract class OtpViewEvent {}

class VerifyOtpEvent extends OtpViewEvent {
  final String otp;
  final String email;

  VerifyOtpEvent({required this.otp, required this.email});
}

class ResendOtpEvent extends OtpViewEvent {
  final String email;

  ResendOtpEvent({required this.email});
}


class VerifyPhoneOtpEvent extends OtpViewEvent{
  final String otp;
  final String phone ;

  VerifyPhoneOtpEvent({required this.otp,required this.phone});
}

