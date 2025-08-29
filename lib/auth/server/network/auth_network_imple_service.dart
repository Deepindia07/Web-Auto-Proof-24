import 'dart:convert';
import 'dart:developer';
import 'package:auto_proof/presentation/screens/company/models/get_company_model.dart';
import 'package:auto_proof/auth/data/models/change_password_response_model.dart';
import 'package:auto_proof/auth/data/models/check_out_response_model.dart';
import 'package:auto_proof/auth/data/models/contact_us_response_model.dart';
import 'package:auto_proof/auth/data/models/employee_login_response_model.dart';
import 'package:auto_proof/auth/data/models/forgot_response_model.dart';
import 'package:auto_proof/auth/data/models/get_all_inpection_list_response_model.dart';
import 'package:auto_proof/auth/data/models/login_response_model.dart';
import 'package:auto_proof/auth/data/models/otp_response_model.dart';
import 'package:auto_proof/auth/data/models/password_setup_response_model.dart';
import 'package:auto_proof/auth/data/models/post_inspector_role_response_model.dart';
import 'package:auto_proof/auth/data/models/registeration_response_model.dart';
import 'package:auto_proof/auth/data/models/user_response_model.dart';
import 'package:auto_proof/auth/data/models/verify_otp_response_model.dart';
import 'package:auto_proof/auth/server/dio_service/dio_service.dart';
import 'package:auto_proof/auth/server/dio_service/error/exception.dart';
import 'package:auto_proof/auth/server/network/auth_abstract_network_imple.dart';
import 'package:auto_proof/constants/const_api_endpoints.dart';
import 'package:auto_proof/presentation/screens/notification/model/get_notification_model.dart';
import 'package:auto_proof/presentation/screens/subscription/models/get_subscription_model.dart';
import 'package:auto_proof/presentation/screens/team_View/models/get_single_team_model.dart';
import 'package:auto_proof/presentation/screens/vehicles_screen/models/get_single_vehicle_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../constants/const_string.dart';
import '../../../presentation/screens/company/models/update_company_model.dart';
import '../../../presentation/screens/team_View/models/update_team_info_model.dart';
import '../../../presentation/screens/vehicles_screen/models/get_vehicle_model.dart';
import '../default_db/sharedprefs_method.dart';

class AuthenticationApiCall implements AuthAbstraction {
  late DioClient dioClient;

  AuthenticationApiCall() {
    dioClient = DioClient();
  }

  @override
  Future<Result<LoginResponseModel, String>> loginApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
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
  Future<Result<EmployeeLoginResponseModel, String>> loginEmployeeApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.inspectionLoginEnd,
        data: dataBody,
      );
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
  Future<Result<ForgotResponseModel, String>> forgotEmailCheckerApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.forgetPassword,
        data: dataBody,
      );
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
  Future<Result<OtpResponseModel, String>> getOtpforResetPasswordApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.sendOtpEmail,
        data: dataBody,
      );
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
  Future<Result<OtpForEmailResponseModel, String>>
  getOtpforEmailVerificationApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.sendOtpEmail,
        data: dataBody,
      );
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

  Future<Result<OtpForEmailResponseModel, String>> getOtpOnSignUp({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.sendOtpApi,
        data: dataBody,
      );
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

  Future<Result<OtpForEmailResponseModel, String>> getOtpOnSmS({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.sendOtpOnSMS,
        data: dataBody,
      );
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
  Future<Result<PasswordSetupResponseModel, String>> resetPasswordApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.resetPassword,
        data: dataBody,
      );
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
  Future<Result<RegistrationResponseModel, String>> registerApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.register,
        data: dataBody,
      );
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
  Future<Result<ChangePasswordResponseModels, String>> changePasswordApiCall({
    Map<String, dynamic>? dataBody,
    required id,
  }) async {
    final token = SharedPrefsHelper.instance.getString(localToken);
    try {
      final response = await dioClient.put(
        "${ApiEndPoints.createNewPassword}$id",
        data: dataBody,
      );
      print(
        "payload:=========>> ${ApiEndPoints.createNewPassword}$id---$token",
      );
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
  Future<Result<UserResponseModel, String>> userProfileApiCall({
    Map<String, dynamic>? dataBody,
    String? id,
  }) async {
    try {
      final token = SharedPrefsHelper.instance.getString(localToken);
      debugPrint("🔹 Sending GET to ${ApiEndPoints.profileApiEnd}");
      debugPrint("🔹 Token: $token");

      final response = await dioClient.get(
        ApiEndPoints.profileApiEnd,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
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
          headers: {'Accept': 'application/json'},
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
  Future<Result<UserResponseModel, String>> userUpdateProfileApiCall({
    Map<String, dynamic>? dataBody,
    required String id,
  }) async {
    try {
      final response = await dioClient.put(
        ApiEndPoints.updateProfileApiEnd,
        data: dataBody,
      );

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
  Future<Result<PostInspectorRoleResponseModel, String>>
  postInspectorRoleApiCall({
    Map<String, dynamic>? dataBody,
    required String adminId,
  }) async {
    try {
      debugPrint(
        "🔹 Sending GET to ${ApiEndPoints.teamApiEnd}/$adminId/create-inspector-member",
      );
      debugPrint("🔹 Sending data   $dataBody");
      final response = await dioClient.post(
        "${ApiEndPoints.teamApiEnd}/$adminId/create-inspector-member",
        data: dataBody,
      );
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
  Future<Result<List<GetTeamUserData>, String>> getAllInspectionListApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.get(
        ApiEndPoints.getInspectionApiEnd,
        data: dataBody,
      );
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final List<dynamic> inspectionsList =
          data['inspections'] ?? data['data'] ?? [];
      final List<GetTeamUserData> inspections = inspectionsList
          .map((json) => GetTeamUserData.fromJson(json))
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
  Future<Result<ContactUsResponseModel, String>> contactUsApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.contactUsEnd,
        data: dataBody,
      );
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

  Future<Result<ContactUsResponseModel, String>> createCompanyApiCall({
    Map<String, dynamic>? dataBody,
    /*  Uint8List? imageBytes, // image file bytes
    String? fileName,*/
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.createCompanyProfile,
        data: dataBody,
      );

      /*  //////

      // Send request as multipart
      final response = await dioClient.post(
        ApiEndPoints.createCompanyProfile,
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }),
      );*/

      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final companyResponse = ContactUsResponseModel.fromJson(data);

      return Result.success(companyResponse);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  /*  Future<Result<ContactUsResponseModel, String>> createCompanyApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.post(
        ApiEndPoints.createCompanyProfile,
        data: dataBody,
      );
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
  }*/

  Future<Result<GetCompanyModel, String>> getCompanyApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.get(ApiEndPoints.getCompanyProfile);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final getResponse = GetCompanyModel.fromJson(data);
      return Result.success(getResponse);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  Future<Result<GetNotificationModel, String>> getNotificationApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.get(ApiEndPoints.getNotificationApi);
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final getResponse = GetNotificationModel.fromJson(data);
      return Result.success(getResponse);
    } on DioException catch (dioError) {
      debugPrint("error generated: => ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("error generated: => ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }

  @override
  Future<Result<GetVehicleModel, String>> vehicleListApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient.get(
        ApiEndPoints.vehicleListEnd,
        data: dataBody,
      );
      final Map<String, dynamic> data = response.data;
      debugPrint("API Response Data: ${response.data}");
      final otpResponse = GetVehicleModel.fromJson(data);
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
  Future<Result<GetSingleVehicleModel, String>> getDetailsVehicleListApiCall({
    Map<String, dynamic>? dataBody,
    required String id,
  }) async {
    try {
      final response = await dioClient.get(
        "${ApiEndPoints.singleVehicleListEnd}/$id",
        data: dataBody,
      );

      debugPrint("API Raw Response Type: ${response.data.runtimeType}");
      debugPrint("API Raw Response: ${response.data}");

      Map<String, dynamic> data = {};

      if (response.data is Map) {
        // ✅ Safe cast
        data = Map<String, dynamic>.from(response.data as Map);
      } else if (response.data is String) {
        // ✅ Sometimes backend sends JSON as raw string
        data = jsonDecode(response.data) as Map<String, dynamic>;
      } else {
        throw Exception("Unexpected response type: ${response.data.runtimeType}");
      }

      final vehicleResponse = GetSingleVehicleModel.fromJson(data);
      return Result.success(vehicleResponse);
    } on DioException catch (dioError) {
      debugPrint("Dio error: ${dioError.toString()}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint("Unexpected error: ${error.toString()}");
      return Result.failure('Unexpected error occurred: $error');
    }
  }



  Future<Result<CheckOutResponseModel, String>> inspectionApiCall({
    Map<String, dynamic>? dataBody,
  }) async {
    try {
      debugPrint("inspection final dataBody=========>>>>> ${jsonEncode(dataBody)}");
      final response = await dioClient.post(
        ApiEndPoints.checkOutEnd,
        data: dataBody,
      );
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

  @override
  Future<Result<VerifyOtpResponseModel, String>>
  verifyOtpForResetPasswordApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      log(ApiEndPoints.verifyOtpEmail);
      log("Request Body: $dataBody");

      final response = await dioClient.post(
        ApiEndPoints.verifyOtpEmail,
        data: dataBody, // This will be sent as raw JSON
      );

      log("Status Code: ${response.statusCode}");
      log("Response: ${response.data}");

      if (response.statusCode == 200) {
        final otpResponse = VerifyOtpResponseModel.fromJson(response.data);
        return Result.success(otpResponse);
      } else {
        final message =
            (response.data is Map && response.data['message'] != null)
            ? response.data['message']
            : 'Error ${response.statusCode}';
        return Result.failure(message);
      }
    } on DioException catch (dioError) {
      log("Dio Error: ${handleDioError(dioError)}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      return Result.failure('Unexpected error occurred: $error');
    }
  }



  Future<Result<VerifyOtpResponseModel, String>>
  verifyOtpForPhoneApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      log(ApiEndPoints.verifyOtpOnSMS);
      log("Request Body: $dataBody");

      final response = await dioClient.post(
        ApiEndPoints.verifyOtpOnSMS,
        data: dataBody, // This will be sent as raw JSON
      );

      log("Status Code: ${response.statusCode}");
      log("Response: ${response.data}");

      if (response.statusCode == 200) {
        final otpResponse = VerifyOtpResponseModel.fromJson(response.data);
        return Result.success(otpResponse);
      } else {
        final message =
        (response.data is Map && response.data['message'] != null)
            ? response.data['message']
            : 'Error ${response.statusCode}';
        return Result.failure(message);
      }
    } on DioException catch (dioError) {
      log("Dio Error: ${handleDioError(dioError)}");
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      return Result.failure('Unexpected error occurred: $error');
    }
  }



  ///get single team member ---

  Future<Result<GetSingleTeamMemberModel, String>> getSingleTeamMember({
    required String id,
  }) async {
    try {
      final response = await dioClient.get("${ApiEndPoints.getTeamMember}$id");
      final Map<String, dynamic> data = response.data;
      debugPrint("Api response data : ${response.data}");
      final dataResponse = GetSingleTeamMemberModel.fromJson(data);
      return Result.success(dataResponse);
    } on DioException catch (dioError) {
      debugPrint("Api response data : $dioError");
      return Result.failure(handleDioError(dioError).toString());
    } catch (e,s) {
      debugPrint("error generated: => ${e.toString()}");
      debugPrint("error generated: => ${s.toString()}");
      return Result.failure('Unexpected error occurred: $e');
    }
  }

  Future<Result<UpdateTeamInfoModel, String>> updateTeamMemberInfoEvent({
    required String id,
    required Map<String, dynamic> dataBody,
  }) async {
    try {
      log("dataBody----_${dataBody}");
      final response = await dioClient.put(
        "${ApiEndPoints.updateTeamMemberInfo}$id",
        data: dataBody,
      );
      final Map<String, dynamic> data = response.data;
      debugPrint("Api response data : ${response.data}");
      final dataResponse = UpdateTeamInfoModel.fromJson(data);
      return Result.success(dataResponse);
    } on DioException catch (dioError) {
      debugPrint("Api response data : $dioError");
      return Result.failure(handleDioError(dioError).toString());
    } catch (e) {
      debugPrint("error generated: => ${e.toString()}");
      return Result.failure('Unexpected error occurred: $e');
    }
  }

  Future<Result<UpdateTeamInfoModel, String>> deleteAccountMethod() async {
    try {
      final response = await dioClient.delete(ApiEndPoints.deleteAccount);
      return Result.success(response.data);
    } on DioException catch (dioError) {
      debugPrint("Api response data : $dioError");
      return Result.failure(handleDioError(dioError).toString());
    } catch (e) {
      debugPrint("error generated: => ${e.toString()}");
      return Result.failure('Unexpected error occurred: $e');
    }
  }

  Future<Result<UpdateAccountModel, String>> updateCompanyApi() async {
    try {
      final response = await dioClient.put(ApiEndPoints.updateCompanyProfile);

      final Map<String, dynamic> data = response.data;
      debugPrint("Api response data : ${response.data}");
      final dataResponse = UpdateAccountModel.fromJson(data);

      return Result.success(dataResponse);
    } on DioException catch (dioError) {
      debugPrint("Api response data : $dioError");
      return Result.failure(handleDioError(dioError).toString());
    } catch (e) {
      debugPrint("error generated: => ${e.toString()}");
      return Result.failure('Unexpected error occurred: $e');
    }
  }

  Future<Result<GetSubscriptionPlanModel, String>>
  getSubscriptionApiCall() async {
    try {
      final response = await dioClient.get(ApiEndPoints.getSubscriptionPlans);

      final Map<String, dynamic> data = response.data;
      debugPrint("Api response data : ${response.data}");
      final dataResponse = GetSubscriptionPlanModel.fromJson(data);
      return Result.success(dataResponse);
    } on DioException catch (dioError) {
      debugPrint("Api response data : $dioError");
      return Result.failure(handleDioError(dioError).toString());
    } catch (e) {
      debugPrint("error generated: => ${e.toString()}");
      return Result.failure('Unexpected error occurred: $e');
    }
  }
}
