class PasswordSetupResponseModel {
  PasswordSetupResponseModel({
    required this.message,
  });

  final String? message;

  factory PasswordSetupResponseModel.fromJson(Map<String, dynamic> json){
    return PasswordSetupResponseModel(
      message: json["message"],
    );
  }
}
