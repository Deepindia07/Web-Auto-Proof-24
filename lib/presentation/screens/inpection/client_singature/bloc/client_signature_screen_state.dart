part of 'client_signature_screen_bloc.dart';

@immutable
abstract class ClientSignatureScreenState {}

class ClientSignatureScreenInitial extends ClientSignatureScreenState {}

class ClientSignatureScreenLoading extends ClientSignatureScreenState {}

class ClientSignatureScreenSaved extends ClientSignatureScreenState {
  final SignatureClientModels signatureModel;

  ClientSignatureScreenSaved({required this.signatureModel});
}

class ClientSignatureScreenValidated extends ClientSignatureScreenState {
  final SignatureClientModels signatureModel;

  ClientSignatureScreenValidated({required this.signatureModel});
}

class ClientSignatureScreenLoaded extends ClientSignatureScreenState {
  final SignatureClientModels signatureModel;

  ClientSignatureScreenLoaded({required this.signatureModel});
}

class ClientSignatureScreenCleared extends ClientSignatureScreenState {}

class ClientSignatureScreenError extends ClientSignatureScreenState {
  final String message;

  ClientSignatureScreenError({required this.message});
}

class OnSubmittingInspectionDataLoading extends ClientSignatureScreenState {}

class OnSubmittingInspectionDataLoaded extends ClientSignatureScreenState {
  final dynamic response;

  OnSubmittingInspectionDataLoaded({required this.response});
}

class OnSubmittingInspectionDataLoadedError extends ClientSignatureScreenState {
  final String message;

  OnSubmittingInspectionDataLoadedError({required this.message});
}
