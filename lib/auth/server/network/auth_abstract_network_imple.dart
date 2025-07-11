import '../../data/models/login_response_model.dart';
import '../dio_service/error/exception.dart';

abstract class AuthAbstraction{
  Future<Result<LoginResponseModel, String>> loginApiCall({Map<String, dynamic>? dataBody});
}