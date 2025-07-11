import 'package:auto_proof/auth/server/dio_service/dio_service.dart';
import 'package:auto_proof/auth/server/network/auth_abstract_network_imple.dart';
import 'package:auto_proof/constants/const_api_endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/login_response_model.dart';
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
      final loginResponse = LoginResponseModel.fromJson(response);
      return Result.success(loginResponse);
    } on DioException catch (dioError) {
      return Result.failure(handleDioError(dioError).toString());
    } catch (error) {
      debugPrint(error.toString());
      return Result.failure('Unexpected error occurred: $error');
    }
  }

}