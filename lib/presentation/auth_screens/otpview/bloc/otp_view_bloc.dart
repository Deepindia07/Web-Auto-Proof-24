import 'dart:async';

import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/logger/app_logger.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/verify_otp_response_model.dart';

part 'otp_view_event.dart';
part 'otp_view_state.dart';

class OtpViewBloc extends Bloc<OtpViewEvent, OtpViewState> {
  final AuthenticationApiCall apiService;

  OtpViewBloc({required this.apiService}) : super(OtpViewInitial()) {
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<VerifyPhoneOtpEvent>(_onVerifyPhoneOtpEvent);
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<OtpViewState> emit,
  ) async {
    emit(OtpViewLoading());

    try {
      final dataBody = {'email': event.email, 'otp': event.otp};

      final result = await apiService.verifyOtpForResetPasswordApiCall(
        dataBody: dataBody,
      );

      if (result.isSuccess) {
        SharedPrefsHelper.instance.setBool(
          isVerifiedEmail,
          result.data.isEmailVerified ?? false,
        );
        final emailverified = SharedPrefsHelper.instance.getBool(
          isVerifiedEmail,
        );
        appLogger.w("is email is verified:= $emailverified");
        emit(OtpViewSuccess(response: result.data));
      } else {
        emit(OtpViewFailure(error: result.error ?? 'Verification failed'));
      }
    } catch (error) {
      appLogger.e("Error in _onVerifyOtp: $error");
      emit(OtpViewFailure(error: 'An unexpected error occurred'));
    }
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<OtpViewState> emit,
  ) async {
    emit(OtpViewLoading());

    try {
      final Map<String, dynamic> dataBody = {
        "email": event.email.trim().toLowerCase(),
      };

      appLogger.w("Resending OTP for email: $dataBody");

      final result = await apiService.getOtpforEmailVerificationApiCall(
        dataBody: dataBody,
      );

      if (result.isSuccess) {
        SharedPrefsHelper.instance.setBool(isEmailFromSignUp, true);
        appLogger.i("OTP resent successfully");
        emit(OtpResendSuccess(message: 'OTP sent successfully'));
      } else {
        appLogger.e("Failed to resend OTP: ${result.error}");
        emit(OtpResendFailure(error: result.error));
      }
    } catch (error) {
      appLogger.e("Error in _onResendOtp: $error");
      emit(
        OtpResendFailure(error: 'Failed to resend OTP: ${error.toString()}'),
      );
    }
  }

  Future<void> _onVerifyPhoneOtpEvent(
    VerifyPhoneOtpEvent event,
    Emitter<OtpViewState> emit,
  ) async {
    emit(OtpVerifyPhoneLoading());
    try {
      final dataBody = {"otp": event.otp, "phoneNumber": event.phone};

      final result = await apiService.verifyOtpForPhoneApiCall(
        dataBody: dataBody,
      );
      if (result.isSuccess) {
        SharedPrefsHelper.instance.setBool(
          isVerifiedPhone,
          result.data.isEmailVerified ?? false,
        );
        final isVeriwfiedPhone = SharedPrefsHelper.instance.getBool(
          isVerifiedPhone,
        );
        appLogger.w("is phone is verified := $isVeriwfiedPhone");
        emit(OtpVerifyPhoneSuccess(response: result.data));
      } else {
        emit(OtpVerifyPhoneError(error: result.error));
      }
    } catch (e) {
      appLogger.e("Error in _onVerifyOtp: $e");
      emit(OtpViewFailure(error: 'An unexpected error occurred'));
    }
  }
}
