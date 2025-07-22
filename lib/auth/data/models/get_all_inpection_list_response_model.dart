class GetAllInspectionListResponseModel {
  GetAllInspectionListResponseModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.pageSize,
    required this.data,
  });

  final int? currentPage;
  final int? totalPages;
  final int? totalRecords;
  final int? pageSize;
  final List<Datum> data;

  factory GetAllInspectionListResponseModel.fromJson(Map<String, dynamic> json){
    return GetAllInspectionListResponseModel(
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      totalRecords: json["totalRecords"],
      pageSize: json["pageSize"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

}

class Datum {
  Datum({
    required this.inspectorId,
    required this.adminId,
    required this.companyId,
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

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      inspectorId: json["inspectorId"],
      adminId: json["adminId"],
      companyId: json["companyId"],
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
