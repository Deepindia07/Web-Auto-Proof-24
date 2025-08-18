import 'package:auto_proof/auth/data/models/user_response_model.dart';
import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final AuthenticationApiCall authenticationApiCall;

  HomeScreenBloc({required this.authenticationApiCall}) : super(HomeScreenInitial()) {
/*    on<GetProfileEvent>(_onGetProfile);*/
    on<UpdateProfileImageEvent>(_onChangeProfileImage);
  }

  /*Future<void> _onGetProfile(GetProfileEvent event, Emitter<HomeScreenState> emit) async {
    try {
      emit(HomeScreenLoading());

      final result = await authenticationApiCall.userProfileApiCall(
        dataBody: event.dataBody,
        id: event.userId!,
      );

      if (result.isSuccess) {
        final userProfile = result.data;
        SharedPrefsHelper.instance.setString(companyId, userProfile.user!.companyId.toString());
        print("company Id :====================> ${SharedPrefsHelper.instance.getString(companyId)}");
        emit(HomeScreenProfileLoaded(userProfile: userProfile));
      } else {
        emit(HomeScreenError(message: result.error ));
      }
    } catch (error) {
      emit(HomeScreenError(message: 'Unexpected error: $error'));
      debugPrint(error.toString());
    }
  }*/

  Future<void> _onChangeProfileImage(UpdateProfileImageEvent event, Emitter<HomeScreenState> emit) async {
    try {
      emit(HomeScreenProfileImageUpdating());

      final result = await authenticationApiCall.userProfileImageApiCall(
        formData:  event.multipartBody,
      );

      if (result.isSuccess) {
        final profileResult = await authenticationApiCall.userProfileApiCall(
          dataBody: event.profileDataBody,

        );

        if (profileResult.isSuccess) {
          emit(HomeScreenProfileImageUpdated(
            message: 'Profile image updated successfully',
            userProfile: profileResult.data,
          ));
        } else {
          emit(HomeScreenError(message: profileResult.error ));
        }
      } else {
        emit(HomeScreenProfileImageUpdateError(
          message: result.error ,
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