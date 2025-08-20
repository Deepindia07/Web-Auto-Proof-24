

class CreateCompanyModel {
  String? companyId;
  bool? isActive;
  String? companyName;
  String? website;
  String? vatNumber;
  String? companyLogo;
  String? companyRegistrationNumber;
  String? shareCapital;
  String? termAndConditions;
  String? companyPolicy;
  String? adminId;
  DateTime? updatedAt;
  DateTime? createdAt;

  CreateCompanyModel({
    this.companyId,
    this.isActive,
    this.companyName,
    this.website,
    this.vatNumber,
    this.companyLogo,
    this.companyRegistrationNumber,
    this.shareCapital,
    this.termAndConditions,
    this.companyPolicy,
    this.adminId,
    this.updatedAt,
    this.createdAt,
  });

  factory CreateCompanyModel.fromJson(Map<String, dynamic> json) => CreateCompanyModel(
    companyId: json["companyId"],
    isActive: json["isActive"],
    companyName: json["companyName"],
    website: json["website"],
    vatNumber: json["VatNumber"],
    companyLogo: json["companyLogo"],
    companyRegistrationNumber: json["companyRegistrationNumber"],
    shareCapital: json["shareCapital"],
    termAndConditions: json["termAndConditions"],
    companyPolicy: json["companyPolicy"],
    adminId: json["adminId"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "companyId": companyId,
    "isActive": isActive,
    "companyName": companyName,
    "website": website,
    "VatNumber": vatNumber,
    "companyLogo": companyLogo,
    "companyRegistrationNumber": companyRegistrationNumber,
    "shareCapital": shareCapital,
    "termAndConditions": termAndConditions,
    "companyPolicy": companyPolicy,
    "adminId": adminId,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}
