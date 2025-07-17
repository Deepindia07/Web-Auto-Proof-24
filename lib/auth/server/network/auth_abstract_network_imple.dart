import '../../data/models/forgot_response_model.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/otp_response_model.dart';
import '../../data/models/password_setup_response_model.dart';
import '../../data/models/registeration_response_model.dart';
import '../../data/models/user_response_model.dart';
import '../../data/models/verify_otp_response_model.dart';
import '../dio_service/error/exception.dart';

abstract class AuthAbstraction{
  Future<Result<LoginResponseModel, String>> loginApiCall({Map<String, dynamic>? dataBody});
  Future<Result<ForgotResponseModel, String>> forgotEmailCheckerApiCall({Map<String, dynamic>? dataBody});
  Future<Result<OtpResponseModel, String>> getOtpforResetPasswordApiCall({Map<String, dynamic>? dataBody});
  Future<Result<VerifyOtpResponseModel, String>> verifyOtpForResetPasswordApiCall({Map<String, dynamic>? dataBody});
  Future<Result<PasswordSetupResponseModel, String>> resetPasswordApiCall({Map<String, dynamic>? dataBody});
  Future<Result<RegistrationResponseModel, String>> registerApiCall({Map<String, dynamic>? dataBody});
  Future<Result<UserResponseModel, String>> userProfileApiCall({Map<String, dynamic>? dataBody, required String id});
  Future<Result<ChangePasswordResponseModel, String>> changePasswordApiCall({Map<String, dynamic>? dataBody});
  Future<Result<UserResponseModel, String>> userUpdateProfileApiCall({Map<String, dynamic>? dataBody, required String id});
}