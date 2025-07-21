import 'package:auto_proof/auth/data/models/forgot_response_model.dart';
import 'package:auto_proof/auth/data/models/otp_response_model.dart';
import 'package:auto_proof/auth/data/models/password_setup_response_model.dart';
import 'package:auto_proof/auth/data/models/user_response_model.dart';
import 'package:auto_proof/auth/data/models/verify_otp_response_model.dart';
import 'package:auto_proof/auth/server/dio_service/dio_service.dart';
import 'package:auto_proof/auth/server/network/auth_abstract_network_imple.dart';
import 'package:auto_proof/constants/const_api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/login_response_model.dart';
import '../../data/models/registeration_response_model.dart';
import '../../data/models/user_update_profile_reponse_model.dart';
import '../dio_service/error/exception.dart';

class AuthenticationApiCall implements AuthAbstraction{
  late DioClient dioClient;

  AuthenticationApiCall(){
    dioClient = DioClient();
  }

  @override
  Future<Result<LoginResponseModel, String>> loginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.login, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final loginResponse = LoginResponseModel.fromJson(data);
      print("Login Data: ${loginResponse}");
      return Result.success(loginResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint(error.toString());
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<ForgotResponseModel, String>> forgotEmailCheckerApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.forgetPassword, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final loginResponse = ForgotResponseModel.fromJson(data);
      print("Login Data: ${loginResponse}");
      return Result.success(loginResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint(error.toString());
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<OtpResponseModel, String>> getOtpforResetPasswordApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.resetPassword, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final otpResponse = OtpResponseModel.fromJson(data);
      print("Otp Data: ${otpResponse.generatedOtp}");
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint(error.toString());
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<VerifyOtpResponseModel, String>> verifyOtpForResetPasswordApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.verifyOtpEmail, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final otpResponse = VerifyOtpResponseModel.fromJson(data);
      // print("Otp Data: ${otpResponse.generatedOtp}");
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint(error.toString());
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<PasswordSetupResponseModel, String>> resetPasswordApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.changePassword, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final otpResponse = PasswordSetupResponseModel.fromJson(data);
      // print("Otp Data: ${otpResponse.generatedOtp}");
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint(error.toString());
      return Result.failure('Unexpected error occurred: $error');
    }
  }
  @override
  Future<Result<RegistrationResponseModel, String>> registerApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.register, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final otpResponse = RegistrationResponseModel.fromJson(data);
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      return Result.failure('Unexpected error occurred: $error');
    }
  }

@override
  Future<Result<ChangePasswordResponseModel, String>> changePasswordApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.createNewPassword, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final otpResponse = ChangePasswordResponseModel.fromJson(data);
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<UserResponseModel, String>> userProfileApiCall({Map<String, dynamic>? dataBody, required String id}) async {
    try {
      final response = await dioClient.get("${ApiEndPoints.profileApiEnd}/$id", data: dataBody);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final otpResponse = UserResponseModel.fromJson(data);
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint(error.toString());
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<UserProfileImageUpdateResponseModel, String>> userProfileImageApiCall({
    required FormData multipartBody,
  }) async {
    try {
      final response = await dioClient.put(
        ApiEndPoints.profilePictureUpdate,
        data: multipartBody,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      final Map<String, dynamic> data = response.data;
      final updateResponse = UserProfileImageUpdateResponseModel.fromJson(data);
      return Result.success(updateResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint(error.toString());
      return Result.failure('Unexpected error occurred: $error');
    }
  }


  @override
  Future<Result<UserResponseModel, String>> userUpdateProfileApiCall({Map<String, dynamic>? dataBody, required String id}) async {
    try {
      final response = await dioClient.put("${ApiEndPoints.updateProfileApiEnd}/$id", data: dataBody);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final otpResponse = UserResponseModel.fromJson(data);
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }

}