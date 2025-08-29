import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';

import '../../car_details/model/car_details_model.dart';
import '../model/model.dart';

part 'client_signature_screen_event.dart';
part 'client_signature_screen_state.dart';

class ClientSignatureScreenBloc extends Bloc<ClientSignatureScreenEvent, ClientSignatureScreenState> {
  SignatureClientModels? _currentSignature;
  AuthenticationApiCall authenticationApiCall;

  ClientSignatureScreenBloc({required this.authenticationApiCall})
      : super(ClientSignatureScreenInitial()) {
    on<SaveSignatureEvent>(_onSaveSignature);
    on<ValidateSignatureEvent>(_onValidateSignature);
    on<ClearSignatureEvent>(_onClearSignature);
    on<LoadSignatureEvent>(_onLoadSignature);
    on<OnSubmittingInspectionDataEvent>(_onSubmittingInspectionData);
  }

  // Save signature from SignatureController
  void _onSaveSignature(SaveSignatureEvent event,
      Emitter<ClientSignatureScreenState> emit) async {
    try {
      emit(ClientSignatureScreenLoading());

      if (event.signatureController.isEmpty) {
        emit(ClientSignatureScreenError(message: 'No signature to save'));
        return;
      }

      // Convert signature to image
      final Uint8List? signature = await event.signatureController.toPngBytes();
      if (signature == null) {
        emit(ClientSignatureScreenError(
            message: 'Failed to generate signature image'));
        return;
      }

      // Convert to base64
      final String base64Signature = base64Encode(signature);

      // Save to file (optional)
      String? filePath;
      try {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/signature_${DateTime
            .now()
            .millisecondsSinceEpoch}.png');
        await file.writeAsBytes(signature);
        filePath = file.path;
      } catch (e) {
        print('Failed to save signature file: $e');
      }

      // Create signature model
      final signatureModel = SignatureClientModels(
        signatureBase64: base64Signature,
        signatureImagePath: filePath,
      );

      _currentSignature = signatureModel;
      await _saveToStorage(signatureModel, event.reportId);

      emit(ClientSignatureScreenSaved(signatureModel: signatureModel));
    } catch (e) {
      emit(ClientSignatureScreenError(
          message: 'Failed to save signature: ${e.toString()}'));
    }
  }

  void _onValidateSignature(ValidateSignatureEvent event,
      Emitter<ClientSignatureScreenState> emit) async {
    try {
      emit(ClientSignatureScreenLoading());

      if (_currentSignature == null) {
        emit(ClientSignatureScreenError(
            message: 'No signature found to validate'));
        return;
      }

      if (!_currentSignature!.isValid) {
        emit(ClientSignatureScreenError(
            message: 'Please provide a signature before validating'));
        return;
      }

      emit(ClientSignatureScreenValidated(signatureModel: _currentSignature!));
    } catch (e) {
      emit(ClientSignatureScreenError(
          message: 'Failed to validate signature: ${e.toString()}'));
    }
  }

  void _onClearSignature(ClearSignatureEvent event,
      Emitter<ClientSignatureScreenState> emit) {
    _currentSignature = null;
    emit(ClientSignatureScreenCleared());
  }

  void _onLoadSignature(LoadSignatureEvent event,
      Emitter<ClientSignatureScreenState> emit) async {
    try {
      emit(ClientSignatureScreenLoading());

      final signatureModel = await _loadFromStorage(event.reportId);
      _currentSignature = signatureModel;

      if (signatureModel != null) {
        emit(ClientSignatureScreenLoaded(signatureModel: signatureModel));
      } else {
        emit(ClientSignatureScreenInitial());
      }
    } catch (e) {
      emit(ClientSignatureScreenError(
          message: 'Failed to load signature: ${e.toString()}'));
    }
  }

  Future<void> _saveToStorage(SignatureClientModels signatureModel,
      String reportId) async {
    try {
      // Here you would save to your preferred storage (SharedPreferences, local database, etc.)
      print('Saving signature for report: $reportId');
      print('Signature data: ${signatureModel.toJson()}');
      // Example: await SharedPreferences.getInstance().setString('signature_$reportId', jsonEncode(signatureModel.toJson()));
    } catch (e) {
      print('Error saving signature: $e');
    }
  }

  Future<SignatureClientModels?> _loadFromStorage(String reportId) async {
    try {
      // Here you would load from your preferred storage
      print('Loading signature for report: $reportId');
      // Example:
      // final prefs = await SharedPreferences.getInstance();
      // final jsonString = prefs.getString('signature_$reportId');
      // if (jsonString != null) {
      //   return SignatureClientModels.fromJson(jsonDecode(jsonString));
      // }
      return null;
    } catch (e) {
      print('Error loading signature: $e');
      return null;
    }
  }

  String? getSignatureBase64() {
    return _currentSignature?.signatureBase64;
  }

  String? getSignatureFilePath() {
    return _currentSignature?.signatureImagePath;
  }

  SignatureClientModels? getCurrentSignature() {
    return _currentSignature;
  }

  /// On Submitting inspection data
  /// On Submitting inspection data
  ///

  Future<void> _onSubmittingInspectionData(
      OnSubmittingInspectionDataEvent event,
      Emitter<ClientSignatureScreenState> emit,
      ) async {
    try {
      emit(OnSubmittingInspectionDataLoading());

      final carDetailsModel = CarDetailsModel(
        checkType: "check-in",
        carDetails: event.carDetails,
        ownerDetails: event.ownerDetails,
        clientDetails: event.clientDetails,
        processedPhotos: ProcessedPhotos(
          photos: Photos(
            frontSide: event.carImages?["front_side"] != null
                ? FrontSide.fromJson(event.carImages!["front_side"]!)
                : null,
            rearSide: event.carImages?["rear_side"] != null
                ? FrontSide.fromJson(event.carImages!["rear_side"]!)
                : null,
          ),
          signatures: Signatures(
            clientSignature: event.clientSignature != null
                ? InspectorSignature.fromJson(event.clientSignature!)
                : null,
            inspectorSignature: event.ownerSignature != null
                ? InspectorSignature.fromJson(event.ownerSignature!)
                : null,
          ),
        ),
        comments: "Vehicle checked in, photos uploaded with client signature.",
      );

      debugPrint("inspection final dataBody=========>>>>> ${jsonEncode(carDetailsModel.toJson())}");

      final response = await authenticationApiCall.inspectionApiCall(
        dataBody: carDetailsModel.toJson(),
      );

      if (response.isSuccess) {
        emit(OnSubmittingInspectionDataLoaded(response: response.data.message));
      } else {
        emit(OnSubmittingInspectionDataLoadedError(
          message: 'Failed to submit inspection data',
        ));
      }
    } catch (error) {
      emit(OnSubmittingInspectionDataLoadedError(
        message: error.toString(),
      ));
    }
  }





}