part of 'client_signature_screen_bloc.dart';

@immutable
abstract class ClientSignatureScreenEvent {}

class SaveSignatureEvent extends ClientSignatureScreenEvent {
  final SignatureController signatureController;
  final String clientName;
  final String reportId;

  SaveSignatureEvent({
    required this.signatureController,
    required this.clientName,
    required this.reportId,
  });
}

class ValidateSignatureEvent extends ClientSignatureScreenEvent {
  final String reportId;

  ValidateSignatureEvent({required this.reportId});
}

class ClearSignatureEvent extends ClientSignatureScreenEvent {}

class LoadSignatureEvent extends ClientSignatureScreenEvent {
  final String reportId;

  LoadSignatureEvent({required this.reportId});
}

class OnSubmittingInspectionDataEvent extends ClientSignatureScreenEvent{
  CarDetails? carDetails;
  OwnerDetails? ownerDetails;
  ClientDetails? clientDetails;
  Map<String, Map<String, String>>? carImages; // from car image step
  Map<String, String>? clientSignature;
  Map<String, String>? ownerSignature;

  OnSubmittingInspectionDataEvent({
    this.carDetails,
    this.ownerDetails,
    this.clientDetails,
    this.carImages,
    this.clientSignature,
    this.ownerSignature,
  });
}
