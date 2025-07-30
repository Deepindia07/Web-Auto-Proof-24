class EmployeeLoginResponseModel {
  EmployeeLoginResponseModel({
    required this.message,
    required this.inspector,
    required this.token,
  });

  final String? message;
  final Inspector? inspector;
  final String? token;

  factory EmployeeLoginResponseModel.fromJson(Map<String, dynamic> json){
    return EmployeeLoginResponseModel(
      message: json["message"],
      inspector: json["inspector"] == null ? null : Inspector.fromJson(json["inspector"]),
      token: json["token"],
    );
  }

}

class Inspector {
  Inspector({
    required this.inspectorId,
    required this.adminId,
    required this.companyId,
    required this.refCode,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryCode,
    required this.phoneNumber,
    required this.password,
    required this.address,
    required this.profileImage,
    required this.gender,
    required this.isActive,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? inspectorId;
  final String? adminId;
  final String? companyId;
  final String? refCode;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? phoneNumber;
  final String? password;
  final String? address;
  final dynamic profileImage;
  final String? gender;
  final bool? isActive;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Inspector.fromJson(Map<String, dynamic> json){
    return Inspector(
      inspectorId: json["inspectorId"],
      adminId: json["adminId"],
      companyId: json["companyId"],
      refCode: json["refCode"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      countryCode: json["countryCode"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
      address: json["address"],
      profileImage: json["profileImage"],
      gender: json["gender"],
      isActive: json["isActive"],
      role: json["role"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
