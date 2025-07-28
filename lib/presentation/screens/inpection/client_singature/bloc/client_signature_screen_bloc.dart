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

  /*void _onSaveSignature(SaveSignatureEvent event, Emitter<ClientSignatureScreenState> emit) async {
    try {
      emit(ClientSignatureScreenLoading());

      if (event.signatureController.isEmpty) {
        emit(ClientSignatureScreenError(message: 'Please provide a signature before saving'));
        return;
      }

      // Convert signature to image
      final Uint8List? signatureImage = (await event.signatureController.toPngBytes()) as Uint8List?;

      if (signatureImage == null) {
        emit(ClientSignatureScreenError(message: 'Failed to capture signature'));
        return;
      }

      // Convert to base64 for storage
      final String base64Signature = base64Encode(signatureImage);

      // Save to local storage (optional)
      final String? filePath = await _saveSignatureToFile(signatureImage, event.reportId);

      // Create signature model
      final signatureModel = ClientSignatureModel(
        signatureData: base64Signature,
        signatureDate: DateTime.now(),
        clientName: event.clientName,
        reportId: event.reportId,
        isValidated: false,
        signaturePath: filePath,
      );

      _currentSignature = signatureModel;

      // Here you can also save to your preferred storage (SharedPreferences, SQLite, API, etc.)
      await _saveToStorage(signatureModel);

      emit(ClientSignatureScreenSaved(signatureModel: signatureModel));
    } catch (e) {
      emit(ClientSignatureScreenError(message: 'Failed to save signature: ${e.toString()}'));
    }
  }*/

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

      // Update signature as validated
      final validatedSignature = _currentSignature!.copyWith(isValidated: true);
      _currentSignature = validatedSignature;

      // Update in storage
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

      // Load from storage
      final signatureModel = await _loadFromStorage(event.reportId);
      _currentSignature = signatureModel;

      emit(ClientSignatureScreenLoaded(signatureModel: signatureModel));
    } catch (e) {
      emit(ClientSignatureScreenError(message: 'Failed to load signature: ${e.toString()}'));
    }
  }

  // Helper method to save signature image to local file
 /* Future<String?> _saveSignatureToFile(Uint8List signatureBytes, String reportId) async {
    try {
      // final directory = await getApplicationDocumentsDirectory();
      final fileName = 'signature_${reportId}_${DateTime.now().millisecondsSinceEpoch}.png';
      // final file = File('${directory.path}/$fileName');

      await file.writeAsBytes(signatureBytes as List<int>);
      return file.path;
    } catch (e) {
      print('Error saving signature file: $e');
      return null;
    }
  }*/

  // Save to persistent storage (you can implement SharedPreferences, SQLite, or API call)
  Future<void> _saveToStorage(ClientSignatureModel signatureModel) async {
    // Example using shared preferences (you'll need to add shared_preferences dependency)
    // final prefs = await SharedPreferences.getInstance();
    // final key = 'signature_${signatureModel.reportId}';
    // await prefs.setString(key, jsonEncode(signatureModel.toJson()));

    // For now, just print the data (replace with your actual storage implementation)
    print('Saving signature: ${signatureModel.toString()}');
  }

  // Load from persistent storage
  Future<ClientSignatureModel?> _loadFromStorage(String reportId) async {
    // Example using shared preferences
    // final prefs = await SharedPreferences.getInstance();
    // final key = 'signature_$reportId';
    // final jsonString = prefs.getString(key);
    //
    // if (jsonString != null) {
    //   final json = jsonDecode(jsonString);
    //   return ClientSignatureModel.fromJson(json);
    // }

    return null;
  }

  // Get base64 signature data for API calls or other purposes
  String? getSignatureBase64() {
    return _currentSignature?.signatureData;
  }

  // Get signature file path
  String? getSignatureFilePath() {
    return _currentSignature?.signaturePath;
  }

  // Check if signature is validated
  bool isSignatureValidated() {
    return _currentSignature?.isValidated ?? false;
  }

  // Get current signature model
  ClientSignatureModel? getCurrentSignature() {
    return _currentSignature;
  }
}
