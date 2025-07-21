class UserProfileImageUpdateResponseModel {
  UserProfileImageUpdateResponseModel({
    required this.message,
    required this.updatedInspector,
  });

  final String? message;
  final UpdatedInspector? updatedInspector;

  factory UserProfileImageUpdateResponseModel.fromJson(Map<String, dynamic> json){
    return UserProfileImageUpdateResponseModel(
      message: json["message"],
      updatedInspector: json["updatedInspector"] == null ? null : UpdatedInspector.fromJson(json["updatedInspector"]),
    );
  }

}

class UpdatedInspector {
  UpdatedInspector({
    required this.inspectorId,
    required this.profileImage,
  });

  final String? inspectorId;
  final String? profileImage;

  factory UpdatedInspector.fromJson(Map<String, dynamic> json){
    return UpdatedInspector(
      inspectorId: json["inspectorId"],
      profileImage: json["profileImage"],
    );
  }

}
