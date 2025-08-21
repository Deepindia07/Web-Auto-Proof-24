

class UpdateAccountModel {
  Data? data;
  String? message;
  bool? success;

  UpdateAccountModel({
    this.data,
    this.message,
    this.success,
  });

  factory UpdateAccountModel.fromJson(Map<String, dynamic> json) => UpdateAccountModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "success": success,
  };
}

class Data {
  String? companyId;
  String? adminId;
  String? companyName;
  String? website;
  String? vatNumber;
  String? companyRegistrationNumber;
  String? shareCapital;
  String? termAndConditions;
  dynamic privacyPolicy;
  String? companyLogo;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.companyId,
    this.adminId,
    this.companyName,
    this.website,
    this.vatNumber,
    this.companyRegistrationNumber,
    this.shareCapital,
    this.termAndConditions,
    this.privacyPolicy,
    this.companyLogo,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    companyId: json["companyId"],
    adminId: json["adminId"],
    companyName: json["companyName"],
    website: json["website"],
    vatNumber: json["VatNumber"],
    companyRegistrationNumber: json["companyRegistrationNumber"],
    shareCapital: json["shareCapital"],
    termAndConditions: json["termAndConditions"],
    privacyPolicy: json["privacyPolicy"],
    companyLogo: json["companyLogo"],
    isActive: json["isActive"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "companyId": companyId,
    "adminId": adminId,
    "companyName": companyName,
    "website": website,
    "VatNumber": vatNumber,
    "companyRegistrationNumber": companyRegistrationNumber,
    "shareCapital": shareCapital,
    "termAndConditions": termAndConditions,
    "privacyPolicy": privacyPolicy,
    "companyLogo": companyLogo,
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
