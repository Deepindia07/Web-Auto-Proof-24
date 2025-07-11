part of 'forgot_screen_bloc.dart';

@immutable
abstract class ForgotScreenState extends Equatable {
  const ForgotScreenState();

  @override
  List<Object> get props => [];
}

class ForgotScreenInitial extends ForgotScreenState {}

class ForgotScreenLoading extends ForgotScreenState {}

class ForgotScreenSuccess extends ForgotScreenState {
  final String message;
  final String email;
  final OtpResponseModel otpResponse;

  const ForgotScreenSuccess({
    required this.message,
    required this.email,
    required this.otpResponse,
  });

  @override
  List<Object> get props => [message, email, otpResponse];
}

class ForgotScreenError extends ForgotScreenState {
  final String error;

  const ForgotScreenError({required this.error});

  @override
  List<Object> get props => [error];
}

class ForgotScreenValidEmail extends ForgotScreenState {
  final String email;

  const ForgotScreenValidEmail(this.email);

  @override
  List<Object> get props => [email];
}
