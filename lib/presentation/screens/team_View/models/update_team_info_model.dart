class UpdateTeamInfoModel {
  String? message;
  Inspector? inspector;

  UpdateTeamInfoModel({this.message, this.inspector});

  factory UpdateTeamInfoModel.fromJson(Map<String, dynamic> json) =>
      UpdateTeamInfoModel(
        message: json["message"],
        inspector: json["inspector"] == null
            ? null
            : Inspector.fromJson(json["inspector"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "inspector": inspector?.toJson(),
  };
}

class Inspector {
  String? inspectorId;
  String? adminId;
  String? companyId;
  String? refCode;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? password;
  String? address;
  dynamic profileImage;
  String? gender;
  bool? isActive;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  Inspector({
    this.inspectorId,
    this.adminId,
    this.companyId,
    this.refCode,
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.phoneNumber,
    this.password,
    this.address,
    this.profileImage,
    this.gender,
    this.isActive,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory Inspector.fromJson(Map<String, dynamic> json) => Inspector(
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
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "inspectorId": inspectorId,
    "adminId": adminId,
    "companyId": companyId,
    "refCode": refCode,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
    "password": password,
    "address": address,
    "profileImage": profileImage,
    "gender": gender,
    "isActive": isActive,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
