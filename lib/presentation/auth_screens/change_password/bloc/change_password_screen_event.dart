part of 'change_password_screen_bloc.dart';

abstract class ChangePasswordScreenEvent extends Equatable {
  const ChangePasswordScreenEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordSubmitted extends ChangePasswordScreenEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordSubmitted({
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [oldPassword, newPassword];
}
