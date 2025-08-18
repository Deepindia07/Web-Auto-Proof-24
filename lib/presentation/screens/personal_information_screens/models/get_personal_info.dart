

class GetPersonalInfoModel {
  String? message;
  User? user;

  GetPersonalInfoModel({
    this.message,
    this.user,
  });

  factory GetPersonalInfoModel.fromJson(Map<String, dynamic> json) => GetPersonalInfoModel(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
  };
}

class User {
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  bool? isEmailVerified;
  dynamic profileImage;
  String? countryCode;
  String? phoneNumber;
  bool? isPhoneNumberVerified;
  String? address;
  String? gender;
  String? role;
  String? userType;
  bool? isActive;
  bool? termsAndConditions;
  dynamic companyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic company;
  List<Inspector>? inspectors;

  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.isEmailVerified,
    this.profileImage,
    this.countryCode,
    this.phoneNumber,
    this.isPhoneNumberVerified,
    this.address,
    this.gender,
    this.role,
    this.userType,
    this.isActive,
    this.termsAndConditions,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.inspectors,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    isEmailVerified: json["isEmailVerified"],
    profileImage: json["profileImage"],
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
    isPhoneNumberVerified: json["isPhoneNumberVerified"],
    address: json["address"],
    gender: json["gender"],
    role: json["role"],
    userType: json["userType"],
    isActive: json["isActive"],
    termsAndConditions: json["termsAndConditions"],
    companyId: json["companyId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    company: json["company"],
    inspectors: json["inspectors"] == null ? [] : List<Inspector>.from(json["inspectors"]!.map((x) => Inspector.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "isEmailVerified": isEmailVerified,
    "profileImage": profileImage,
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
    "isPhoneNumberVerified": isPhoneNumberVerified,
    "address": address,
    "gender": gender,
    "role": role,
    "userType": userType,
    "isActive": isActive,
    "termsAndConditions": termsAndConditions,
    "companyId": companyId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "company": company,
    "inspectors": inspectors == null ? [] : List<dynamic>.from(inspectors!.map((x) => x.toJson())),
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
