class ApiEndPoints {
  static const String baseUrl = "http://192.168.1.12:3002";
  static const String login = "/api/auth/login";
  static const String register = "/api/auth/signUp";
  static const String verifyOtpEmail = "/api/auth/verifyOtpForEmail";
  static const String sendOtpEmail = "/api/auth/sendOtpOnEmail";
  static const String forgetPassword = "/api/auth/forget-password";
  static const String resetPassword = "/api/auth/reset-password";
  static const String changePassword = "/api/auth/change-password";
  static const String createNewPassword = "/api/admin/create-new-password/";
  static const String profileApiEnd = "/api/profile/user-profile";
  static const String profilePictureUpdate =
      "/api/profile/update-profile-image";
  static const String teamApiEnd = "/api/admin/team/";
  static const String updateInspectorDetailsEnd =
      "/api/inspector/update-inspector-details";
  static const String getInspectionApiEnd =
      "/api/admin/team/getAllInspectorMembersList/";
  static const String updateProfileApiEnd = "/api/admin/profile/update-profile";
  static const String inspectionLoginEnd = "/api/inspector/login";
  static const String checkOutEnd = "/api/inspector/inspection/check-in/";
  static const String checkInEnd = "/api/inspector/inspection/check-in/";
  static const String contactUsEnd = "/api/contact-us/";
  static const String vehicleListEnd =
      '/api/admin/vehicle/get-all-vehicle-detailList';
  static const String sendOtpApi = '/api/auth/send-otp';
  static const String getTeamMember =
      '/api/admin/team/getInspectorMemberDetails/';
  static const String updateTeamMemberInfo =
      '/api/admin/update-inspector-details/';
  static const String createCompanyProfile =
      '/api/company-profile/create-company-profile';
  static const String getCompanyProfile =
      '/api/company-profile/get-company-profile';
  static const String deleteAccount = '/api/personal-profile/delete';
}
