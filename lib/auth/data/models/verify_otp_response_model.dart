class VerifyOtpResponseModel {
  VerifyOtpResponseModel({
    required this.message,
    required this.success,
    required this.isEmailVerified,
  });

  final String? message;
  final bool? success;
  final bool? isEmailVerified;

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json){
    return VerifyOtpResponseModel(
      message: json["message"],
      success: json["success"],
      isEmailVerified: json["isEmailVerified"],
    );
  }

}
