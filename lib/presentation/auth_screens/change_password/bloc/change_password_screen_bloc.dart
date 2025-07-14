import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'change_password_screen_event.dart';
part 'change_password_screen_state.dart';

class ChangePasswordScreenBloc extends Bloc<ChangePasswordScreenEvent, ChangePasswordScreenState> {
  final AuthenticationApiCall repository;

  ChangePasswordScreenBloc({required this.repository}) : super(ChangePasswordScreenInitial()) {
    on<ChangePasswordSubmitted>(_onChangePasswordSubmitted);
  }

  Future<void> _onChangePasswordSubmitted(
      ChangePasswordSubmitted event,
      Emitter<ChangePasswordScreenState> emit,
      ) async {
    try {
      emit(ChangePasswordScreenLoading());

      // Call the API to change password
      // final response = await repository.changePassword(
      //   oldPassword: event.oldPassword,
      //   newPassword: event.newPassword,
      // );

      // if (response.isSuccess) {
      //   emit(ChangePasswordScreenSuccess(
      //     message: response.message ?? 'Password changed successfully',
      //   ));
      // } else {
      //   emit(ChangePasswordScreenFailure(
      //     error: response.error ?? 'Failed to change password',
      //   ));
      // }
    } catch (error) {
      emit(ChangePasswordScreenFailure(
        error: error.toString(),
      ));
    }
  }
}