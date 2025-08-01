import 'dart:io';
import 'package:dio/dio.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mime/mime.dart'; // For MIME type detection
import 'package:http_parser/http_parser.dart'; // Add this import for MediaType

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
      debugPrint("Personal update error: $e");
      emit(CollectInformationScreenError(error: "Failed to update personal information: $e"));
    }
  }

  /// Handle company information update with multipart form data
  Future<void> _onUpdateCompanyInformation(
      UpdateCompanyInformationEvent event,
      Emitter<CollectInformationScreenState> emit,
      ) async {
    emit(CollectInformationScreenLoading());

    try {
      FormData formData = FormData();
      formData.fields.add(const MapEntry('userType', 'company'));

      // Add personal information fields
      formData.fields.add(MapEntry('personalInfo[firstName]', event.firstName));
      formData.fields.add(MapEntry('personalInfo[lastName]', event.lastName));
      formData.fields.add(MapEntry('personalInfo[email]', event.email));
      formData.fields.add(MapEntry('personalInfo[phoneNumber]', event.phoneNumber));
      formData.fields.add(MapEntry('personalInfo[countryCode]', event.countryCode));
      formData.fields.add(MapEntry('personalInfo[address]', event.address));

      // Add company information fields
      formData.fields.add(MapEntry('companyInfo[companyName]', event.companyName));
      formData.fields.add(MapEntry('companyInfo[website]', event.website));
      formData.fields.add(MapEntry('companyInfo[VatNumber]', event.vatNumber));
      formData.fields.add(MapEntry('companyInfo[companyRegistrationNumber]', event.companyRegistrationNumber));

      // Handle shareCapital as numeric value - ensure it's a valid number
      String shareCapitalValue = event.shareCapital;
      // Remove any non-numeric characters except decimal point
      shareCapitalValue = shareCapitalValue.replaceAll(RegExp(r'[^\d.]'), '');
      // Ensure it's a valid number, default to 0 if invalid
      double? shareCapitalNum = double.tryParse(shareCapitalValue);
      if (shareCapitalNum == null) {
        shareCapitalNum = 0.0;
      }
      formData.fields.add(MapEntry('companyInfo[shareCapital]', shareCapitalNum.toString()));

      formData.fields.add(MapEntry('companyInfo[termAndConditions]', event.termAndConditions));
      formData.fields.add(MapEntry('companyInfo[companyPolicy]', event.companyPolicy));

      // Add company logo file if provided with proper MIME type detection
      if (event.companyLogo != null) {
        try {
          final file = event.companyLogo!;
          final fileName = file.path.split('/').last;
          String? mimeType = lookupMimeType(file.path);
          if (mimeType == null || !mimeType.startsWith('image/')) {
            debugPrint("Invalid file type: $mimeType. Only images are allowed.");
            emit(CollectInformationScreenError(error: "Only image files are allowed for company logo"));
            return;
          }

          debugPrint("File MIME type: $mimeType");
          debugPrint("File name: $fileName");
          debugPrint("File path: ${file.path}");

          formData.files.add(MapEntry(
            'companyInfo[companyLogo]',
            await MultipartFile.fromFile(
              file.path,
              filename: fileName,
              contentType: MediaType.parse(mimeType),
            ),
          ));
          debugPrint("Company logo file added successfully");
        } catch (fileError) {
          debugPrint("Error processing file: $fileError");
          emit(CollectInformationScreenError(error: "Error processing company logo file: $fileError"));
          return;
        }
      }

      debugPrint("Company Info FormData fields: ${formData.fields.length}");
      debugPrint("Company Info FormData files: ${formData.files.length}");

      // Debug print all form fields to verify data
      for (var field in formData.fields) {
        debugPrint("Field: ${field.key} = ${field.value}");
      }

      final result = await authenticationApiCall.userProfileImageApiCall(
        formData: formData,
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
      debugPrint("Company update error: $e");
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