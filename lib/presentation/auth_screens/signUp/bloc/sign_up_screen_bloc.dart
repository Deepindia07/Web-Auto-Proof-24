import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/logger/app_logger.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/otp_response_model.dart';
import '../../../../auth/data/models/registeration_response_model.dart';

part 'sign_up_screen_event.dart';
part 'sign_up_screen_state.dart';

class SignUpScreenBloc extends Bloc<SignUpScreenEvent, SignUpScreenState> {
  final AuthenticationApiCall apiRepository;

  SignUpScreenBloc({required this.apiRepository})
    : super(SignUpScreenInitial()) {
    on<SendOtpEmailEvent>(_sendOtpOnEmail);
    on<SendOtpEmailSignUpEvent>(_getOtpOnSignUp);
    on<RegisterUser>(_onRegisterUser);
    on<ResetToInitialState>(_resetToInitialState);
  }

  Future<void> _sendOtpOnEmail(
    SendOtpEmailEvent event,
    Emitter<SignUpScreenState> emit,
  ) async {
    emit(SendOtpScreenLoading());

    try {
      final Map<String, dynamic> dataBody = {
        "email": event.email.trim().toLowerCase(),
      };
      appLogger.w("email data :$dataBody");
      final result = await apiRepository.getOtpforEmailVerificationApiCall(
        dataBody: dataBody,
      );

      if (result.isSuccess) {
        SharedPrefsHelper.instance.setBool(isEmailFromSignUp, true);
        emit(SendOtpOnEmailSuccess(result.data));
      } else {
        emit(SendOtpOnEmailError(result.error));
      }
    } catch (e) {
      emit(
        SendOtpOnEmailError(
          "Failed to send verification code: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> _getOtpOnSignUp(
    SendOtpEmailSignUpEvent event,
    Emitter<SignUpScreenState> emit,
  ) async {
    emit(SignUpSendOtpScreenLoading());

    try {
      final Map<String, dynamic> dataBody = {
        "email": event.email.trim().toLowerCase(),
      };
      appLogger.w("email data :$dataBody");
      final result = await apiRepository.getOtpOnSignUp(dataBody: dataBody);

      if (result.isSuccess) {
        SharedPrefsHelper.instance.setBool(isEmailFromSignUp, true);
        emit(SignUpSendOtpOnEmailSuccess(result.data));
      } else {
        emit(SignUpSendOtpOnEmailError(result.error));
      }
    } catch (e) {
      emit(
        SignUpSendOtpOnEmailError(
          "Failed to send verification code: ${e.toString()}",
        ),
      );
    }
  }

  Future<void> _onRegisterUser(
    RegisterUser event,
    Emitter<SignUpScreenState> emit,
  ) async {
    emit(SignUpScreenLoading());

    try {
      // Validate required fields
      if (event.firstName.trim().isEmpty ||
          event.lastName.trim().isEmpty ||
          event.email.trim().isEmpty ||
          event.phoneNumber.trim().isEmpty ||
          event.password.isEmpty) {
        emit(SignUpScreenError('All fields are required'));
        return;
      }

      // Validate email format
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(event.email.trim())) {
        emit(SignUpScreenError('Please enter a valid email address'));
        return;
      }

      // Check if email is verified
      if (!event.isEmailVerified) {
        emit(SignUpScreenError('Please verify your email address first'));
        return;
      }

      // Check terms and conditions
      if (!event.termsAndConditions) {
        emit(SignUpScreenError('Please agree to the Terms & Privacy'));
        return;
      }

      final Map<String, dynamic> dataBody = {
        "firstName": event.firstName.trim(),
        "lastName": event.lastName.trim(),
        "email": event.email.trim().toLowerCase(),
        "countryCode": event.countryCode,
        "phoneNumber": event.phoneNumber.trim(),
        "password": event.password,
        "isEmailVerified": event.isEmailVerified,
        "termsAndConditions": event.termsAndConditions,
      };

      final result = await apiRepository.registerApiCall(dataBody: dataBody);

      if (result.isSuccess) {
        emit(SignUpScreenSuccess(result.data));
      } else {
        emit(SignUpScreenError(result.error));
      }
    } catch (error) {
      emit(
        SignUpScreenError('An unexpected error occurred: ${error.toString()}'),
      );
    }
  }

  void _resetToInitialState(
    ResetToInitialState event,
    Emitter<SignUpScreenState> emit,
  ) {
    emit(SignUpScreenInitial());
  }
}
