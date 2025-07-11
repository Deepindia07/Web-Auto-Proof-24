part of 'reset_password_screen_bloc.dart';

@immutable
sealed class ResetPasswordScreenState extends Equatable {}

final class ResetPasswordScreenInitial extends ResetPasswordScreenState {
  @override
  List<Object> get props => [];
}

final class ResetPasswordScreenLoading extends ResetPasswordScreenState {
  @override
  List<Object> get props => [];
}

final class ResetPasswordScreenSuccess extends ResetPasswordScreenState {
  final PasswordSetupResponseModel response;

   ResetPasswordScreenSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

final class ResetPasswordScreenFailure extends ResetPasswordScreenState {
  final String error;

   ResetPasswordScreenFailure({required this.error});

  @override
  List<Object> get props => [error];
}

