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

