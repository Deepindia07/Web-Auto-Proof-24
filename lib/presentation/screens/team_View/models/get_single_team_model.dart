

class GetSingleTeamMemberModel {
  bool? success;
  String? message;
  Inspector? inspector;
  List<dynamic>? inspections;
  Pagination? pagination;

  GetSingleTeamMemberModel({
    this.success,
    this.message,
    this.inspector,
    this.inspections,
    this.pagination,
  });

  factory GetSingleTeamMemberModel.fromJson(Map<String, dynamic> json) => GetSingleTeamMemberModel(
    success: json["success"],
    message: json["message"],
    inspector: json["inspector"] == null ? null : Inspector.fromJson(json["inspector"]),
    inspections: json["inspections"] == null ? [] : List<dynamic>.from(json["inspections"]!.map((x) => x)),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "inspector": inspector?.toJson(),
    "inspections": inspections == null ? [] : List<dynamic>.from(inspections!.map((x) => x)),
    "pagination": pagination?.toJson(),
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
    "address": address,
    "profileImage": profileImage,
    "gender": gender,
    "isActive": isActive,
    "role": role,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Pagination({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}
