part of 'reset_password_screen_bloc.dart';

@immutable
sealed class ResetPasswordScreenEvent extends Equatable {}

class ResetPasswordInitialScreen extends ResetPasswordScreenEvent {
  final String? email;
  final String? password;

   ResetPasswordInitialScreen({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class ResetPasswordSubmitted extends ResetPasswordScreenEvent {
  final String email;
  final String password;

   ResetPasswordSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
