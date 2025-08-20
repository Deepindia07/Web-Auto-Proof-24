import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../auth/server/network/auth_network_imple_service.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final AuthenticationApiCall authenticationApiCall;
  DeleteAccountBloc({required this.authenticationApiCall})
    : super(DeleteAccountInitial()) {
    on<DeleteAccountApiEvent>(_onDeleteAccountApiEvent);
  }

  Future<void> _onDeleteAccountApiEvent(
    DeleteAccountApiEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(DeleteAccountLoading());
    try {
      final result = await authenticationApiCall.deleteAccountMethod();
      if (result.isSuccess) {
        emit(DeleteAccountSuccess());
      } else {
        DeleteAccountError();
      }
    } catch (e) {
      DeleteAccountError();
    }
  }
}
