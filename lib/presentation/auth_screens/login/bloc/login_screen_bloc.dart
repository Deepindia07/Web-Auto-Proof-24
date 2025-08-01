import 'dart:math';

import 'package:auto_proof/auth/data/models/employee_login_response_model.dart';
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
  final String userRole; // Add userRole parameter

  LoginScreenBloc({
    required this.authRepository,
    required this.userRole, // Add this parameter
  }) : super(LoginScreenInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginReset>(_onLoginReset);
    on<EmailValidationCheck>(_onEmailValidationCheck);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginScreenState> emit,
      ) async {

    emit(LoginLoading());

    try {
      // Check if user role is employee/instructor to use employee login
      if (userRole == "instructor" || userRole == "employee") {
        await _handleEmployeeLogin(event, emit);
      } else {
        await _handleRegularLogin(event, emit);
      }
    } catch (error) {
      emit(LoginFailure(error: 'Login failed: $error'));
      print("Login error: $error");
    }
  }

  Future<void> _handleEmployeeLogin(
      LoginSubmitted event,
      Emitter<LoginScreenState> emit,
      ) async {

    final dataBody = {
      'refCode': event.refNo,
    };

    print("Employee login data: ${dataBody}");

    final resultResponse = await authRepository.loginEmployeeApiCall(dataBody: dataBody);

    if (resultResponse.isSuccess) {
      // Handle employee login success
      SharedPrefsHelper.instance.setString(localToken, "${resultResponse.data.token}");
      SharedPrefsHelper.instance.setString(userId, "${resultResponse.data.inspector!.inspectorId}");
      SharedPrefsHelper.instance.setString(emailKey, resultResponse.data.inspector!.email.toString());
      SharedPrefsHelper.instance.setString(isFirstTime, "isFirstTime");
      SharedPrefsHelper.instance.setString("userRole", userRole); // Store user role

      print("Employee token: = ${SharedPrefsHelper.instance.getString(localToken)}");
      emit(EmployeeLoginSuccess(employeeLoginResponseModel: resultResponse.data));
    } else {
      emit(LoginFailure(error: resultResponse.error));
      print("Employee login error: ${resultResponse.error}");
    }
  }

  Future<void> _handleRegularLogin(
      LoginSubmitted event,
      Emitter<LoginScreenState> emit,
      ) async {

    final dataBody = {
      'email_or_phoneNumber': event.emailOrPhone,
      'password': event.password,
    };

    print("Regular login data: ${dataBody}");

    final resultResponse = await authRepository.loginApiCall(dataBody: dataBody);

    if (resultResponse.isSuccess) {
      SharedPrefsHelper.instance.setString(localToken, "${resultResponse.data.token}");
      SharedPrefsHelper.instance.setString(userId, "${resultResponse.data.user!.userId}");
      SharedPrefsHelper.instance.setString(emailKey, resultResponse.data.user!.email.toString());
      SharedPrefsHelper.instance.setString(isFirstTime, "isFirstTime");
      SharedPrefsHelper.instance.setString("userRole", userRole);

      print("Regular token: = ${SharedPrefsHelper.instance.getString(localToken)}");
      emit(LoginSuccess(loginResponse: resultResponse.data));
    } else {
      emit(LoginFailure(error: resultResponse.error));
      print("Regular login error: ${resultResponse.error}");
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
