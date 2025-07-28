part of 'client_signature_screen_bloc.dart';

@immutable
abstract class ClientSignatureScreenState {}

class ClientSignatureScreenInitial extends ClientSignatureScreenState {}

class ClientSignatureScreenLoading extends ClientSignatureScreenState {}

class ClientSignatureScreenLoaded extends ClientSignatureScreenState {
  final ClientSignatureModel? signatureModel;

  ClientSignatureScreenLoaded({this.signatureModel});
}

class ClientSignatureScreenSaved extends ClientSignatureScreenState {
  final ClientSignatureModel signatureModel;

  ClientSignatureScreenSaved({required this.signatureModel});
}

class ClientSignatureScreenValidated extends ClientSignatureScreenState {
  final ClientSignatureModel signatureModel;

  ClientSignatureScreenValidated({required this.signatureModel});
}

class ClientSignatureScreenError extends ClientSignatureScreenState {
  final String message;

  ClientSignatureScreenError({required this.message});
}

class ClientSignatureScreenCleared extends ClientSignatureScreenState {}

