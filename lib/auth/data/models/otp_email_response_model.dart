class OtpForEmailVerificationResponseModel {
  OtpForEmailVerificationResponseModel({
    required this.message,
    required this.success,
    required this.isEmailVerified,
  });

  final String? message;
  final bool? success;
  final bool? isEmailVerified;

  factory OtpForEmailVerificationResponseModel.fromJson(Map<String, dynamic> json){
    return OtpForEmailVerificationResponseModel(
      message: json["message"],
      success: json["success"],
      isEmailVerified: json["isEmailVerified"],
    );
  }

}
