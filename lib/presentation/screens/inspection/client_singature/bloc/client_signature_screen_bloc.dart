import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:signature/signature.dart';

import '../model/model.dart';

part 'client_signature_screen_event.dart';
part 'client_signature_screen_state.dart';

class ClientSignatureScreenBloc extends Bloc<ClientSignatureScreenEvent, ClientSignatureScreenState> {
  ClientSignatureModel? _currentSignature;

  ClientSignatureScreenBloc() : super(ClientSignatureScreenInitial()) {
    // on<SaveSignatureEvent>(_onSaveSignature);
    on<ValidateSignatureEvent>(_onValidateSignature);
    on<ClearSignatureEvent>(_onClearSignature);
    on<LoadSignatureEvent>(_onLoadSignature);
  }

  void _onValidateSignature(ValidateSignatureEvent event, Emitter<ClientSignatureScreenState> emit) async {
    try {
      emit(ClientSignatureScreenLoading());

      if (_currentSignature == null) {
        emit(ClientSignatureScreenError(message: 'No signature found to validate'));
        return;
      }

      if (_currentSignature!.signatureData == null || _currentSignature!.signatureData!.isEmpty) {
        emit(ClientSignatureScreenError(message: 'Please provide a signature before validating'));
        return;
      }
      final validatedSignature = _currentSignature!.copyWith(isValidated: true);
      _currentSignature = validatedSignature;

      await _saveToStorage(validatedSignature);

      emit(ClientSignatureScreenValidated(signatureModel: validatedSignature));
    } catch (e) {
      emit(ClientSignatureScreenError(message: 'Failed to validate signature: ${e.toString()}'));
    }
  }

  void _onClearSignature(ClearSignatureEvent event, Emitter<ClientSignatureScreenState> emit) {
    _currentSignature = null;
    emit(ClientSignatureScreenCleared());
  }

  void _onLoadSignature(LoadSignatureEvent event, Emitter<ClientSignatureScreenState> emit) async {
    try {
      emit(ClientSignatureScreenLoading());

      final signatureModel = await _loadFromStorage(event.reportId);
      _currentSignature = signatureModel;

      emit(ClientSignatureScreenLoaded(signatureModel: signatureModel));
    } catch (e) {
      emit(ClientSignatureScreenError(message: 'Failed to load signature: ${e.toString()}'));
    }
  }

  Future<void> _saveToStorage(ClientSignatureModel signatureModel) async {
    print('Saving signature: ${signatureModel.toString()}');
  }

  Future<ClientSignatureModel?> _loadFromStorage(String reportId) async {
    return null;
  }
  String? getSignatureBase64() {
    return _currentSignature?.signatureData;
  }

  String? getSignatureFilePath() {
    return _currentSignature?.signaturePath;
  }

  bool isSignatureValidated() {
    return _currentSignature?.isValidated ?? false;
  }

  ClientSignatureModel? getCurrentSignature() {
    return _currentSignature;
  }

  // Future<>
}
