import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/otp_response_model.dart';
import '../../../../auth/server/default_db/sharedprefs_method.dart';
import '../../../../constants/const_string.dart';

part 'forgot_screen_event.dart';
part 'forgot_screen_state.dart';

class ForgotScreenBloc extends Bloc<ForgotScreenEvent, ForgotScreenState> {
  final AuthenticationApiCall apiRepository;

  ForgotScreenBloc({required this.apiRepository}) : super(ForgotScreenInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<ValidateEmailEvent>(_onValidateEmail);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<ForgotScreenState> emit) async {
    emit(ForgotScreenLoading());

    try {
      if (!_isValidEmail(event.email)) {
        emit(ForgotScreenError(error: 'Please enter a valid email address'));
        return;
      }

      final Map<String, dynamic> dataBody = {
        'email': event.email,
      };

      final result = await apiRepository.getOtpforResetPasswordApiCall(dataBody: dataBody);
      if(result.isSuccess){
        SharedPrefsHelper.instance.setBool(isEmailFromSignUp, false);
        emit(ForgotScreenSuccess(message: 'OTP sent successfully to your email', email: event.email, otpResponse: result.data));
      }else{
        emit(ForgotScreenError(error: result.error));
      }
    } catch (e) {
      emit(ForgotScreenError( error: 'An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> _onValidateEmail(ValidateEmailEvent event, Emitter<ForgotScreenState> emit) async {
    if (event.email.isEmpty) {
      emit(ForgotScreenError(error: 'Email cannot be empty'));
    } else if (!_isValidEmail(event.email)) {
      emit(ForgotScreenError(error: 'Please enter a valid email address'));
    } else {
      emit(ForgotScreenValidEmail(event.email));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
}
