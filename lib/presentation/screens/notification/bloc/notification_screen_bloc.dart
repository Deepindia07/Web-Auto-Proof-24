import 'dart:async';
import 'dart:developer';

import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/get_notification_model.dart';

part 'notification_screen_event.dart';
part 'notification_screen_state.dart';

class NotificationScreenBloc
    extends Bloc<NotificationScreenEvent, NotificationScreenState> {
  final AuthenticationApiCall authenticationApiCall;
  NotificationScreenBloc({required this.authenticationApiCall})
    : super(NotificationScreenInitial()) {
    on<NotificationScreenApiEvent>(_onNotificationScreenApiEvent);
  }

  Future<void> _onNotificationScreenApiEvent(
    NotificationScreenApiEvent event,
    Emitter<NotificationScreenState> emit,
  ) async {
    emit(NotificationScreenLoading());
    try {
      final result = await authenticationApiCall.getNotificationApiCall();
      if (result.isSuccess) {
        final getNotificationModel = result.data;
        emit(
          NotificationScreenSuccess(getNotificationModel: getNotificationModel),
        );
      } else {
        emit(NotificationScreenError(error: result.error));
      }
    } catch (e, s) {
      emit(NotificationScreenError(error: e.toString()));
    }
  }
}
