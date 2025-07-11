part of 'forgot_screen_bloc.dart';

@immutable
abstract class ForgotScreenEvent extends Equatable {
  const ForgotScreenEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends ForgotScreenEvent {
  final String email;

  const SendOtpEvent(this.email);

  @override
  List<Object> get props => [email];
}

class ValidateEmailEvent extends ForgotScreenEvent {
  final String email;

  const ValidateEmailEvent(this.email);

  @override
  List<Object> get props => [email];
}
