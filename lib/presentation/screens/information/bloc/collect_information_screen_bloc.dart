import 'dart:io';

import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/user_response_model.dart';

part 'collect_information_screen_event.dart';
part 'collect_information_screen_state.dart';

class CollectInformationScreenBloc extends Bloc<CollectInformationScreenEvent, CollectInformationScreenState> {
  final AuthenticationApiCall authenticationApiCall;

  CollectInformationScreenBloc({required this.authenticationApiCall}) : super(CollectInformationScreenInitial()) {

    on<UpdatePersonalInformationEvent>(_onUpdatePersonalInformation);
    on<UpdateCompanyInformationEvent>(_onUpdateCompanyInformation);
    on<ResetCollectInformationStateEvent>(_onResetState);
  }

  /// Handle personal information update
  Future<void> _onUpdatePersonalInformation(
      UpdatePersonalInformationEvent event,
      Emitter<CollectInformationScreenState> emit,
      ) async {
    emit(CollectInformationScreenLoading());

    try {
      final Map<String, dynamic> payload = {
        "userType": "individual",
        "personalInfo": {
          "firstName": event.firstName,
          "lastName": event.lastName,
          "email": event.email,
          "phoneNumber": event.phoneNumber,
          "countryCode": event.countryCode,
          "address": event.address,
        }
      };

      debugPrint("Personal Info Payload: $payload");

      final result = await authenticationApiCall.userUpdateProfileApiCall(
        dataBody: payload,
        id: event.userId,
      );

      if (result.isSuccess) {
        emit(CollectInformationScreenPersonalSuccess(
          userResponse: result.data,
          message: "Personal information updated successfully",
        ));
      } else {
        emit(CollectInformationScreenError(error: result.error ?? "Unknown error occurred"));
      }
    } catch (e) {
      emit(CollectInformationScreenError(error: "Failed to update personal information: $e"));
    }
  }

  /// Handle company information update
  Future<void> _onUpdateCompanyInformation(
      UpdateCompanyInformationEvent event,
      Emitter<CollectInformationScreenState> emit,
      ) async {
    emit(CollectInformationScreenLoading());

    File? logoFile;
    if (event.companyLogo != null) {
      logoFile = event.companyLogo!;
      debugPrint("Company logo file: ${logoFile.path}");
    }

    try {
      final Map<String, dynamic> payload = {
        "userType": "company",
        "personalInfo": {
          "firstName": event.firstName,
          "lastName": event.lastName,
          "email": event.email,
          "phoneNumber": event.phoneNumber,
          "countryCode": event.countryCode,
          "address": event.address,
        },
        "companyInfo": {
          "companyName": event.companyName,
          "website": event.website,
          "VatNumber": event.vatNumber,
          "companyRegistrationNumber": event.companyRegistrationNumber,
          "shareCapital": event.shareCapital,
          "termAndConditions": event.termAndConditions,
          "companyPolicy": event.companyPolicy,
          "companyLogo":logoFile
        }
      };

      debugPrint("Company Info Payload: $payload");

      final result = await authenticationApiCall.userUpdateProfileApiCall(
        dataBody: payload,
        id: event.userId,
      );
      if (result.isSuccess) {
        emit(CollectInformationScreenCompanySuccess(
          userResponse: result.data,
          message: "Company information updated successfully",
        ));
      } else {
        emit(CollectInformationScreenError(error: result.error ?? "Unknown error occurred"));
      }
    } catch (e) {
      emit(CollectInformationScreenError(error: "Failed to update company information: $e"));
    }
  }

  /// Reset the state
  void _onResetState(
      ResetCollectInformationStateEvent event,
      Emitter<CollectInformationScreenState> emit,
      ) {
    emit(CollectInformationScreenInitial());
  }
}