class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
    required this.message,
    required this.success,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  final String? message;
  final bool? success;
  final bool? isEmailVerified;
  final bool? isPhoneVerified;

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json){
    return VerifyOtpResponseModel(
      message: json["message"],
      success: json["success"],
      isEmailVerified: json["isEmailVerified"],
      isPhoneVerified: json["isPhoneVerified"],
    );
  }

}
