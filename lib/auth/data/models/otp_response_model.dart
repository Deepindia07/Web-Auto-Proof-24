class OtpResponseModel {
  OtpResponseModel({
    required this.message,
    required this.generatedOtp,
    required this.success,
  });

  final String? message;
  final int? generatedOtp;
  final bool? success;

  factory OtpResponseModel.fromJson(Map<String, dynamic> json){
    return OtpResponseModel(
      message: json["message"],
      generatedOtp: json["generatedOtp"],
      success: json["success"],
    );
  }
}



/// Send otp on email
///
class OtpForEmailResponseModel {
  OtpForEmailResponseModel({
    required this.message,
    required this.generatedOtp,
  });

  final String? message;
  final int? generatedOtp;

  factory OtpForEmailResponseModel.fromJson(Map<String, dynamic> json){
    return OtpForEmailResponseModel(
      message: json["message"],
      generatedOtp: json["generatedOtp"],
    );
  }

}
