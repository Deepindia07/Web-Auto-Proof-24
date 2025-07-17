import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/user_response_model.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final AuthenticationApiCall authenticationApiCall;

  HomeScreenBloc({required this.authenticationApiCall}) : super(HomeScreenInitial()) {
    on<GetProfileEvent>(_onGetProfile);
  }

  Future<void> _onGetProfile(GetProfileEvent event, Emitter<HomeScreenState> emit) async {
    try {
      emit(HomeScreenLoading());

      final result = await authenticationApiCall.userProfileApiCall(
        dataBody: event.dataBody,
        id: event.userId!,
      );

      if (result.isSuccess) {
        final userProfile = result.data;
        emit(HomeScreenProfileLoaded(userProfile: userProfile));
      } else {
        emit(HomeScreenError(message: result.error ?? 'Failed to load profile'));
      }
    } catch (error) {
      emit(HomeScreenError(message: 'Unexpected error: $error'));
      debugPrint(error.toString());
    }
  }
}
