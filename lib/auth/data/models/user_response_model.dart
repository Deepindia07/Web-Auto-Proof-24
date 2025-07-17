class UserResponseModel {
  UserResponseModel({
    required this.message,
    required this.user,
  });

  final String? message;
  final User? user;

  factory UserResponseModel.fromJson(Map<String, dynamic> json){
    return UserResponseModel(
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

}

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isEmailVerified,
    required this.countryCode,
    required this.profileImage,
    required this.phoneNumber,
    required this.isPhoneNumberVerified,
    required this.address,
    required this.gender,
    required this.role,
    required this.userType,
    required this.isActive,
    required this.termsAndConditions,
    required this.companyId,
    required this.createdAt,
    required this.updatedAt,
    required this.company,
    required this.inspectors,
  });

  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isEmailVerified;
  final String? countryCode;
  final dynamic profileImage;
  final String? phoneNumber;
  final bool? isPhoneNumberVerified;
  final String? address;
  final dynamic gender;
  final String? role;
  final String? userType;
  final bool? isActive;
  final bool? termsAndConditions;
  final String? companyId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Company? company;
  final List<Inspector> inspectors;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userId: json["userId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      isEmailVerified: json["isEmailVerified"],
      countryCode: json["countryCode"],
      profileImage: json["profileImage"],
      phoneNumber: json["phoneNumber"],
      isPhoneNumberVerified: json["isPhoneNumberVerified"],
      address: json["address"],
      gender: json["gender"],
      role: json["role"],
      userType: json["userType"],
      isActive: json["isActive"],
      termsAndConditions: json["termsAndConditions"],
      companyId: json["companyId"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
      inspectors: json["inspectors"] == null ? [] : List<Inspector>.from(json["inspectors"]!.map((x) => Inspector.fromJson(x))),
    );
  }

}

class Company {
  Company({
    required this.companyId,
    required this.userId,
    required this.companyName,
    required this.website,
    required this.vatNumber,
    required this.companyRegistrationNumber,
    required this.shareCapital,
    required this.termAndConditions,
    required this.companyPolicy,
    required this.companyLogo,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? companyId;
  final String? userId;
  final String? companyName;
  final String? website;
  final String? vatNumber;
  final String? companyRegistrationNumber;
  final String? shareCapital;
  final String? termAndConditions;
  final String? companyPolicy;
  final dynamic companyLogo;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      companyId: json["companyId"],
      userId: json["userId"],
      companyName: json["companyName"],
      website: json["website"],
      vatNumber: json["VatNumber"],
      companyRegistrationNumber: json["companyRegistrationNumber"],
      shareCapital: json["shareCapital"],
      termAndConditions: json["termAndConditions"],
      companyPolicy: json["companyPolicy"],
      companyLogo: json["companyLogo"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}

class Inspector {
  Inspector({
    required this.inspectorId,
    required this.adminId,
    required this.companyId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryCode,
    required this.phoneNumber,
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
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? countryCode;
  final String? phoneNumber;
  final String? address;
  final dynamic profileImage;
  final dynamic gender;
  final bool? isActive;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Inspector.fromJson(Map<String, dynamic> json){
    return Inspector(
      inspectorId: json["inspectorId"],
      adminId: json["adminId"],
      companyId: json["companyId"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      countryCode: json["countryCode"],
      phoneNumber: json["phoneNumber"],
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
