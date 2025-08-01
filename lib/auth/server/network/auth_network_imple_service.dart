import 'package:auto_proof/auth/data/models/contact_us_response_model.dart';
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

import '../../data/models/change_password_response_model.dart';
import '../../data/models/check_out_response_model.dart';
import '../../data/models/employee_login_response_model.dart';
import '../../data/models/get_all_inpection_list_response_model.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/post_inspector_role_response_model.dart';
import '../../data/models/registeration_response_model.dart';
import '../../data/models/user_update_profile_reponse_model.dart';
import '../../data/models/vehicle_list_response_model.dart';
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
  Future<Result<EmployeeLoginResponseModel, String>> loginEmployeeApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.inspectionLoginEnd, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final loginResponse = EmployeeLoginResponseModel.fromJson(data);
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
  Future<Result<OtpForEmailResponseModel, String>> getOtpforEmailVerificationApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.sendOtpEmail, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final otpResponse = OtpForEmailResponseModel.fromJson(data);
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
      final response = await dioClient.put(ApiEndPoints.changePassword, data: dataBody);
      final Map<String, dynamic> data = response.data;
      final otpResponse = PasswordSetupResponseModel.fromJson(data);
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
  Future<Result<ChangePasswordResponseModels, String>> changePasswordApiCall({Map<String, dynamic>? dataBody, required id}) async {
    try {
      final response = await dioClient.put("${ApiEndPoints.createNewPassword}$id", data: dataBody);
      print("payload:=========>> ${ApiEndPoints.createNewPassword}$id");
      final Map<String, dynamic> data = response.data;
      final otpResponse = ChangePasswordResponseModels.fromJson(data);
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
      final response = await dioClient.get("${ApiEndPoints.profileApiEnd}", data: dataBody);
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
  Future<Result<UserResponseModel, String>> userProfileImageApiCall({
    required FormData formData,
  }) async {
    try {
      debugPrint("API Call: userProfileImageApiCall");
      debugPrint("FormData fields: ${formData.fields.length}");
      debugPrint("FormData files: ${formData.files.length}");

      final response = await dioClient.put(
        ApiEndPoints.updateProfileApiEnd,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final userResponse = UserResponseModel.fromJson(data);
      return Result.success(userResponse);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }


  @override
  Future<Result<UserResponseModel, String>> userUpdateProfileApiCall({Map<String, dynamic>? dataBody, required String id}) async {
    try {
      final response = await dioClient.put("${ApiEndPoints.updateProfileApiEnd}", data: dataBody);
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

  @override
  Future<Result<PostInspectorRoleResponseModel, String>> postInspectorRoleApiCall({Map<String, dynamic>? dataBody, required String adminId}) async {
    try {
      final response = await dioClient.post("${ApiEndPoints.teamApiEnd}/$adminId/create-inspector-member", data: dataBody);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final otpResponse = PostInspectorRoleResponseModel.fromJson(data);
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<List<Datum>, String>> getAllInspectionListApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.get(ApiEndPoints.GetinspectionApiEnd, data: dataBody);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final List<dynamic> inspectionsList = data['inspections'] ?? data['data'] ?? [];
      final List<Datum> inspections = inspectionsList
          .map((json) => Datum.fromJson(json))
          .toList();

      return Result.success(inspections);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<ContactUsResponseModel, String>> contactUsApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.contactUsEnd, data: dataBody);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final otpResponse = ContactUsResponseModel.fromJson(data);
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<VehicleListResponseModel, String>> vehicleListApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.get(ApiEndPoints.vehicleListEnd, data: dataBody);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final otpResponse = VehicleListResponseModel.fromJson(data);
      return Result.success(otpResponse);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<CheckOutResponseModel, String>> inspectionApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(ApiEndPoints.checkOutEnd, data: dataBody);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final otpResponse = CheckOutResponseModel.fromJson(data);
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