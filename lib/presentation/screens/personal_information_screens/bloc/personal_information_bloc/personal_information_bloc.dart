import 'dart:async';
import 'dart:developer';

import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:auto_proof/presentation/screens/personal_information_screens/models/personal_information_api_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../auth/data/models/user_response_model.dart';
import '../../../../../auth/server/network/auth_network_imple_service.dart';

part 'personal_information_event.dart';
part 'personal_information_state.dart';

class PersonalInformationBloc
    extends Bloc<PersonalInformationEvent, PersonalInformationState> {
  final AuthenticationApiCall authenticationApiCall;
  PersonalInformationBloc({required this.authenticationApiCall})
    : super(PersonalInformationInitial()) {
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
    on<GetPersonalInfoApiEvent>(_onGetPersonalInfoApiEvent);
  }

  /// Handle personal information update
  Future<void> _onUpdateProfileEvent(
    UpdateProfileEvent event,
    Emitter<PersonalInformationState> emit,
  ) async {
    emit(PersonalInformationLoading());

    try {
      log("Personal Info Payload: ${event.profile}");

      final result = await authenticationApiCall.userUpdateProfileApiCall(
        dataBody: event.profile.toJson(),
        id: '',
      );

      if (result.isSuccess) {
        emit(PersonalInformationSuccess());
      } else {
        emit(PersonalInformationError(error: result.error));
      }
    } catch (e) {
      log("Personal update error: $e");
      emit(
        PersonalInformationError(
          error: "Failed to update personal information: $e",
        ),
      );
    }
  }

  Future<void> _onGetPersonalInfoApiEvent(
    GetPersonalInfoApiEvent event,
    Emitter<PersonalInformationState> emit,
  ) async {
    emit(GetPersonalInfoLoading());
    try {
      final result = await authenticationApiCall.userProfileApiCall();

      if (result.isSuccess) {
        final userProfile = result.data;
        SharedPrefsHelper.instance.setString(
          companyId,
          userProfile.user!.companyId.toString(),
        );
        print(
          "company Id :===========> ${SharedPrefsHelper.instance.getString(companyId)}",
        );
        emit(GetPersonalInfoSuccess(userProfile: userProfile));
      } else {
        emit(GetPersonalInfoError(error: result.error));
      }
    } catch (e, s) {
      log("e-->${e.toString()}");
      log("s-->${s.toString()}");
      emit(GetPersonalInfoError(error: e.toString()));
    }
  }
}
