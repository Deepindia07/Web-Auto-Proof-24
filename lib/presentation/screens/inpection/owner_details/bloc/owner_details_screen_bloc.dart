import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../../auth/server/network/auth_network_imple_service.dart';
import '../../car_details/model/car_details_model.dart';

part 'owner_details_screen_event.dart';
part 'owner_details_screen_state.dart';

class OwnerDetailsScreenBloc extends Bloc<OwnerDetailsScreenEvent, OwnerDetailsScreenState> {
  late OwnerDetails _currentCarDetails = OwnerDetails();
  AuthenticationApiCall? authenticationApiCall;
  OwnerDetailsScreenBloc({ this.authenticationApiCall}) : super(OwnerDetailsScreenInitial()) {
    on<UpdateOwnerDetailsEvent>(_onUpdateOwnerDetails);
    on<ResetOwnerDetailsEvent>(_onResetOwnerDetails);
    on<OnSubmittingAgentDataEvent>(_onSubmitAgentData);
  }

  void _onUpdateOwnerDetails(UpdateOwnerDetailsEvent event, Emitter<OwnerDetailsScreenState> emit) {
    _currentCarDetails = event.carDetailsModel;
    emit(OwnerDetailsScreenLoaded(carOwnerDetails: event.carDetailsModel));
  }


  OwnerDetails getCurrentCarDetails() {
    return _currentCarDetails;
  }

  void _onResetOwnerDetails(ResetOwnerDetailsEvent event, Emitter<OwnerDetailsScreenState> emit) {
    emit(OwnerDetailsScreenInitial());
  }

  Future<void> _onSubmitAgentData(
      OnSubmittingAgentDataEvent event,
      Emitter<OwnerDetailsScreenState> emit,
      ) async {
    try {
      emit(OnSubmittingAgentLoading());

      final carDetailsModel = CarDetailsModel(
        checkType: "check-out",
        carDetails: event.carDetails,
        ownerDetails: event.ownerDetails,
        inspectorId:event.inspectorId,
      );

      debugPrint("inspection final dataBody=========>>>>> ${jsonEncode(carDetailsModel.toJson())}");

      final response = await authenticationApiCall?.inspectionApiCall(
        dataBody: carDetailsModel.toJson(),
      );

      if (response!.isSuccess) {

        emit(OnSubmittingAgentLoadedSuccess(message: "${response.data.message}"));
      }
      else {
        print("Failed to submit inspection data");
        emit(OnSubmittingAgentLoadedError(
          message: 'Failed to submit inspection data',
        ));
      }
    } catch (error) { print("Failed to submit inspection data$error");
      emit(OnSubmittingAgentLoadedError(
        message: error.toString(),
      ));
    }
  }
}