part of 'change_password_screen_bloc.dart';

abstract class ChangePasswordScreenState extends Equatable {
  const ChangePasswordScreenState();

  @override
  List<Object> get props => [];
}

class ChangePasswordScreenInitial extends ChangePasswordScreenState {}

class ChangePasswordScreenLoading extends ChangePasswordScreenState {}

class ChangePasswordScreenSuccess extends ChangePasswordScreenState {
  final String message;

  const ChangePasswordScreenSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ChangePasswordScreenFailure extends ChangePasswordScreenState {
  final String error;

  const ChangePasswordScreenFailure({required this.error});

  @override
  List<Object> get props => [error];
}
