class ApiEndPoints {
  static const String baseUrl = "http://192.168.1.12:3002/";
  static const String login = "api/auth/login";
  static const String register = "api/auth/signUp";
  static const String verifyOtpEmail = "api/auth/verifyOtpForEmail";
  static const String sendOtpEmail = "api/auth/sendOtpOnEmail";
  static const String forgetPassword = "api/auth/forget-password";
  static const String resetPassword = "api/auth/reset-password";
  static const String changePassword = "api/auth/change-password";
  static const String createNewPassword = "api/admin/create-new-password";
  static const String profileApiEnd = "api/profile/";
  static const String profilePictureUpdate = "api/profile/update-profile-image";
  static const String updateProfileApiEnd = "api/admin/profile/update-profile/";
}
