class ApiEndPoints {
  static const String baseUrl = "https://d73e8040debc.ngrok-free.app/";
  static const String login = "api/auth/login";
  static const String register = "api/auth/signUp";
  static const String verifyOtpEmail = "api/auth/verifyOtpForEmail";
  static const String sendOtpEmail = "api/auth/sendOtpOnEmail";
  static const String forgetPassword = "api/auth/forget-password";
  static const String resetPassword = "api/auth/reset-password";
  static const String changePassword = "api/auth/change-password";
  static const String createNewPassword = "api/admin/create-new-password/";
  static const String profileApiEnd = "/api/profile/user-profile";
  static const String profilePictureUpdate = "api/profile/update-profile-image";
  static const String teamApiEnd = "api/admin/team/";
  // static const String vehicleListEnd = "api/admin/vehicle";
  static const String updateInspectorDetailsEnd = "api/inspector/update-inspector-details";
  static const String GetinspectionApiEnd = "api/admin/team/getAllInspectorMembersList/";
  static const String updateProfileApiEnd = "api/admin/profile/update-profile/";
  static const String inspectionLoginEnd = "/api/inspector/login";
  static const String checkOutEnd = "api/inspector/inspection/check-in/";
  static const String checkInEnd = "api/inspector/inspection/check-in/";
  static const String contactUsEnd = "api/contact-us/";
  static const String vehicleListEnd = 'api/admin/vehicle/get-all-vehicle-detailList';
}
