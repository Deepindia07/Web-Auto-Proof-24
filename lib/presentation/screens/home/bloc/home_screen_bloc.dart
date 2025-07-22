import 'package:auto_proof/auth/data/models/user_update_profile_reponse_model.dart';
import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/user_response_model.dart';
import '../../../../constants/const_string.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final AuthenticationApiCall authenticationApiCall;

  HomeScreenBloc({required this.authenticationApiCall}) : super(HomeScreenInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileImageEvent>(_onChangeProfileImage); // Add this line
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
        SharedPrefsHelper.instance.setString(companyId, userProfile.user!.companyId.toString());
        emit(HomeScreenProfileLoaded(userProfile: userProfile));
      } else {
        emit(HomeScreenError(message: result.error ?? 'Failed to load profile'));
      }
    } catch (error) {
      emit(HomeScreenError(message: 'Unexpected error: $error'));
      debugPrint(error.toString());
    }
  }

  Future<void> _onChangeProfileImage(UpdateProfileImageEvent event, Emitter<HomeScreenState> emit) async {
    try {
      emit(HomeScreenProfileImageUpdating());

      final result = await authenticationApiCall.userProfileImageApiCall(
        multipartBody: event.multipartBody,
      );

      if (result.isSuccess) {
        final profileResult = await authenticationApiCall.userProfileApiCall(
          dataBody: event.profileDataBody,
          id: event.userId,
        );

        if (profileResult.isSuccess) {
          emit(HomeScreenProfileImageUpdated(
            message: 'Profile image updated successfully',
            userProfile: profileResult.data,
          ));
        } else {
          emit(HomeScreenError(message: profileResult.error ?? 'Failed to reload profile'));
        }
      } else {
        emit(HomeScreenProfileImageUpdateError(
          message: result.error ?? 'Failed to update profile image',
        ));
      }
    } catch (error) {
      emit(HomeScreenProfileImageUpdateError(
        message: 'Unexpected error: $error',
      ));
      debugPrint(error.toString());
    }
  }
}