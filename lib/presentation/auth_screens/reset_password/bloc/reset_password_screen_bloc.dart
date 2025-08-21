import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/password_setup_response_model.dart';

part 'reset_password_screen_event.dart';
part 'reset_password_screen_state.dart';

class ResetPasswordScreenBloc
    extends Bloc<ResetPasswordScreenEvent, ResetPasswordScreenState> {
  final AuthenticationApiCall repository;

  ResetPasswordScreenBloc({required this.repository})
    : super(ResetPasswordScreenInitial()) {
    on<ResetPasswordInitialScreen>(_onInitialScreen);
    on<ResetPasswordSubmitted>(_onPasswordSubmitted);
  }

  Future<void> _onInitialScreen(
    ResetPasswordInitialScreen event,
    Emitter<ResetPasswordScreenState> emit,
  ) async {
    emit(ResetPasswordScreenInitial());
  }

  Future<void> _onPasswordSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordScreenState> emit,
  ) async {
    emit(ResetPasswordScreenLoading());

    try {
      final dataBody = {
        "email": event.email,
        "password": event.password
      };
      final result = await repository.resetPasswordApiCall(dataBody: dataBody);
      if (result.isSuccess) {
        emit(ResetPasswordScreenSuccess(response: result.data));
      } else {
        emit(ResetPasswordScreenFailure(error: result.error));
      }
    } catch (error) {
      emit(
        ResetPasswordScreenFailure(error: 'Unexpected error occurred: $error'),
      );
    }
  }
}
