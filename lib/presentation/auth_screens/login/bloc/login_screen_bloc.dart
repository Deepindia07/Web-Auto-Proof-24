import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/login_response_model.dart';
import '../../../../auth/data/models/forgot_response_model.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final AuthenticationApiCall authRepository;

  LoginScreenBloc({required this.authRepository}) : super(LoginScreenInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginReset>(_onLoginReset);
    on<EmailValidationCheck>(_onEmailValidationCheck);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginScreenState> emit,
      ) async {

    emit(LoginLoading());

    final dataBody = {
      'email_or_phoneNumber': event.emailOrPhone,
      'password': event.password,
    };
    print("${dataBody}");
    final resultResponse = await authRepository.loginApiCall(dataBody: dataBody);
    if (resultResponse.isSuccess){
      SharedPrefsHelper.instance.setString(localToken, "${resultResponse.data.token}");
      SharedPrefsHelper.instance.setString(userId, "${resultResponse.data.user!.userId}");
      SharedPrefsHelper.instance.setString(emailKey, resultResponse.data.user!.email.toString());
      SharedPrefsHelper.instance.setString(isFirstTime, "isFirstTime");
      print("token: = ${SharedPrefsHelper.instance.getString(localToken)}");
      emit(LoginSuccess(loginResponse: resultResponse.data));
    } else {
      emit(LoginFailure(error: resultResponse.error));
      print("${resultResponse.error}");
    }
  }

  void _onLoginReset(LoginReset event, Emitter<LoginScreenState> emit,) {
    emit(LoginScreenInitial());
  }

  Future<void> _onEmailValidationCheck(
      EmailValidationCheck event,
      Emitter<LoginScreenState> emit,
      ) async {

    emit(EmailValidationLoading());

    final dataBody = {
      'email': event.emailOrPhone,
    };

    print("Validating email/phone: ${dataBody}");

    try {
      final resultResponse = await authRepository.forgotEmailCheckerApiCall(dataBody: dataBody);

      if (resultResponse.isSuccess) {
        emit(EmailValidationSuccess(
          emailOrPhone: event.emailOrPhone,
          forgotResponse: resultResponse.data,
        ));
        print("Email validation successful");
      } else {
        emit(EmailValidationFailure(error: resultResponse.error));
        print("Email validation failed: ${resultResponse.error}");
      }
    } catch (error) {
      emit(EmailValidationFailure(error: 'Failed to validate email/phone'));
      print("Email validation error: $error");
    }
  }
}
