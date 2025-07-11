import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
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
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<OtpViewState> emit) async {
    emit(OtpViewLoading());

    try {
      final dataBody = {
        'otp': event.otp,
        'email': event.email,
      };

      final result = await apiService.verifyOtpForResetPasswordApiCall(dataBody: dataBody);

      if (result.isSuccess) {
        emit(OtpViewSuccess(response: result.data!));
      } else {
        emit(OtpViewFailure(error: result.error ?? 'Verification failed'));
      }
    } catch (error) {
      emit(OtpViewFailure(error: 'An unexpected error occurred'));
    }
  }

  Future<void> _onResendOtp(ResendOtpEvent event, Emitter<OtpViewState> emit) async {
    emit(OtpViewLoading());

    try {
      // Call your resend OTP API here
      // final result = await apiService.resendOtpApiCall();

      // For now, simulating success
      await Future.delayed(Duration(seconds: 2));
      emit(OtpResendSuccess());
    } catch (error) {
      emit(OtpResendFailure(error: 'Failed to resend OTP'));
    }
  }
}

