class ForgotResponseModel {
  ForgotResponseModel({
    required this.message,
    required this.success,
    required this.userId,
  });

  final String? message;
  final bool? success;
  final String? userId;

  factory ForgotResponseModel.fromJson(Map<String, dynamic> json){
    return ForgotResponseModel(
      message: json["message"],
      success: json["success"],
      userId: json["userId"],
    );
  }

}

class ChangePasswordResponseModel {
  ChangePasswordResponseModel({
    required this.message,
  });

  final String? message;

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json){
    return ChangePasswordResponseModel(
      message: json["message"],
    );
  }

}

