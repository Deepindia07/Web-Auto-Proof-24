class PostInspectorRoleResponseModel {
  PostInspectorRoleResponseModel({
    required this.message,
    required this.inspector,
  });

  final String? message;
  final Inspector? inspector;

  factory PostInspectorRoleResponseModel.fromJson(Map<String, dynamic> json){
    return PostInspectorRoleResponseModel(
      message: json["message"],
      inspector: json["inspector"] == null ? null : Inspector.fromJson(json["inspector"]),
    );
  }

}

class Inspector {
  Inspector({
    required this.inspectorId,
    required this.firstName,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  final String? inspectorId;
  final String? firstName;
  final String? email;
  final String? phoneNumber;
  final String? role;

  factory Inspector.fromJson(Map<String, dynamic> json){
    return Inspector(
      inspectorId: json["inspectorId"],
      firstName: json["firstName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      role: json["role"],
    );
  }

}
