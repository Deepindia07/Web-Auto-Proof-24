import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../constants/const_string.dart';

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
      final dataBody ={
          "oldPassword":event.oldPassword,
          "newPassword":event.newPassword
      };
      final response = await repository.changePasswordApiCall(
        id: SharedPrefsHelper.instance.getString(userId),
        dataBody: dataBody
      );

      if (response.isSuccess) {
        emit(ChangePasswordScreenSuccess(
          message: response.data.message ?? 'Password changed successfully',
        ));
      } else {
        emit(ChangePasswordScreenFailure(
          error: response.error,
        ));
      }
    } catch (error) {
      emit(ChangePasswordScreenFailure(
        error: error.toString(),
      ));
    }
  }
}