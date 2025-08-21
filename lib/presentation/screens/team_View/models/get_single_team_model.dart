

class GetSingleTeamMemberModel {
  bool? success;
  String? message;
  Inspector? inspector;
  List<Inspection>? inspections;
  Pagination? pagination;
  InspectionStats? inspectionStats;

  GetSingleTeamMemberModel({
    this.success,
    this.message,
    this.inspector,
    this.inspections,
    this.pagination,
    this.inspectionStats,
  });

  factory GetSingleTeamMemberModel.fromJson(Map<String, dynamic> json) => GetSingleTeamMemberModel(
    success: json["success"],
    message: json["message"],
    inspector: json["inspector"] == null ? null : Inspector.fromJson(json["inspector"]),
    inspections: json["inspections"] == null ? [] : List<Inspection>.from(json["inspections"]!.map((x) => Inspection.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    inspectionStats: json["inspectionStats"] == null ? null : InspectionStats.fromJson(json["inspectionStats"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "inspector": inspector?.toJson(),
    "inspections": inspections == null ? [] : List<dynamic>.from(inspections!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
    "inspectionStats": inspectionStats?.toJson(),
  };
}

class InspectionStats {
  int? totalCompleted;
  int? totalOngoing;
  int? totalInspections;

  InspectionStats({
    this.totalCompleted,
    this.totalOngoing,
    this.totalInspections,
  });

  factory InspectionStats.fromJson(Map<String, dynamic> json) => InspectionStats(
    totalCompleted: json["totalCompleted"],
    totalOngoing: json["totalOngoing"],
    totalInspections: json["totalInspections"],
  );

  Map<String, dynamic> toJson() => {
    "totalCompleted": totalCompleted,
    "totalOngoing": totalOngoing,
    "totalInspections": totalInspections,
  };
}

class Inspection {
  String? inspectionId;
  String? adminId;
  String? inspectorId;
  String? clientId;
  String? companyId;
  String? vehicleId;
  String? carOwnerId;
  String? checkType;
  DateTime? checkInDate;
  dynamic checkOutDate;
  Status? status;
  String? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  Vehicle? vehicle;
  Company? company;
  Client? client;

  Inspection({
    this.inspectionId,
    this.adminId,
    this.inspectorId,
    this.clientId,
    this.companyId,
    this.vehicleId,
    this.carOwnerId,
    this.checkType,
    this.checkInDate,
    this.checkOutDate,
    this.status,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.vehicle,
    this.company,
    this.client,
  });

  factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
    inspectionId: json["inspectionId"],
    adminId: json["adminId"],
    inspectorId: json["inspectorId"],
    clientId: json["clientId"],
    companyId: json["companyId"],
    vehicleId: json["vehicleId"],
    carOwnerId: json["carOwnerId"],
    checkType: json["checkType"]!,
    checkInDate: json["checkInDate"] == null ? null : DateTime.parse(json["checkInDate"]),
    checkOutDate: json["checkOutDate"],
    status: statusValues.map[json["status"]]!,
    comments: json["comments"]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "inspectionId": inspectionId,
    "adminId": adminId,
    "inspectorId": inspectorId,
    "clientId": clientId,
    "companyId": companyId,
    "vehicleId": vehicleId,
    "carOwnerId": carOwnerId,
    "checkType": checkType,
    "checkInDate": checkInDate?.toIso8601String(),
    "checkOutDate": checkOutDate,
    "status": statusValues.reverse[status],
    "comments": comments,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "vehicle": vehicle?.toJson(),
    "company": company?.toJson(),
    "client": client?.toJson(),
  };
}




class Client {
  String? clientId;
  String? adminId;
  String? firstName;
  String? lastName;
  DateTime? birthdate;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? address;
  String? gender;
  String? drivingLicenseNumber;
  DateTime? dateOfIssue;
  String? rentalDuration;
  DateTime? leaseStartDate;
  DateTime? leaseEndDate;
  dynamic geoLocation;
  String? comments;
  DateTime? createdAt;
  DateTime? updatedAt;

  Client({
    this.clientId,
    this.adminId,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.address,
    this.gender,
    this.drivingLicenseNumber,
    this.dateOfIssue,
    this.rentalDuration,
    this.leaseStartDate,
    this.leaseEndDate,
    this.geoLocation,
    this.comments,
    this.createdAt,
    this.updatedAt,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    clientId: json["clientId"],
    adminId: json["adminId"],
    firstName: json["firstName"]!,
    lastName: json["lastName"]!,
    birthdate: json["birthdate"] == null ? null : DateTime.parse(json["birthdate"]),
    countryCode: json["countryCode"],
    phoneNumber: json["phoneNumber"],
    email: json["email"]!,
    address: json["address"]!,
    gender: json["gender"]!,
    drivingLicenseNumber: json["drivingLicenseNumber"]!,
    dateOfIssue: json["dateOfIssue"] == null ? null : DateTime.parse(json["dateOfIssue"]),
    rentalDuration: json["rentalDuration"]!,
    leaseStartDate: json["leaseStartDate"] == null ? null : DateTime.parse(json["leaseStartDate"]),
    leaseEndDate: json["leaseEndDate"] == null ? null : DateTime.parse(json["leaseEndDate"]),
    geoLocation: json["geoLocation"],
    comments: json["comments"]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "clientId": clientId,
    "adminId": adminId,
    "firstName": firstName,
    "lastName": lastName,
    "birthdate": "${birthdate!.year.toString().padLeft(4, '0')}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}",
    "countryCode": countryCode,
    "phoneNumber": phoneNumber,
    "email": email,
    "address": address,
    "gender": gender,
    "drivingLicenseNumber": drivingLicenseNumber,
    "dateOfIssue": "${dateOfIssue!.year.toString().padLeft(4, '0')}-${dateOfIssue!.month.toString().padLeft(2, '0')}-${dateOfIssue!.day.toString().padLeft(2, '0')}",
    "rentalDuration": rentalDuration,
    "leaseStartDate": leaseStartDate?.toIso8601String(),
    "leaseEndDate": leaseEndDate?.toIso8601String(),
    "geoLocation": geoLocation,
    "comments": comments,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}





class Company {
  String? companyId;
  String? adminId;
  CompanyName? companyName;
  String? website;
  VatNumber? vatNumber;
  CompanyRegistrationNumber? companyRegistrationNumber;
  String? shareCapital;
  String? termAndConditions;
  String? companyPolicy;
  String? companyLogo;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  Company({
    this.companyId,
    this.adminId,
    this.companyName,
    this.website,
    this.vatNumber,
    this.companyRegistrationNumber,
    this.shareCapital,
    this.termAndConditions,
    this.companyPolicy,
    this.companyLogo,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    companyId: json["companyId"],
    adminId: json["adminId"],
    companyName: companyNameValues.map[json["companyName"]]!,
    website: json["website"],
    vatNumber: vatNumberValues.map[json["VatNumber"]]!,
    companyRegistrationNumber: companyRegistrationNumberValues.map[json["companyRegistrationNumber"]]!,
    shareCapital: json["shareCapital"],
    termAndConditions: json["termAndConditions"],
    companyPolicy: json["companyPolicy"],
    companyLogo: json["companyLogo"],
    isActive: json["isActive"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "companyId": companyId,
    "adminId": adminId,
    "companyName": companyNameValues.reverse[companyName],
    "website": website,
    "VatNumber": vatNumberValues.reverse[vatNumber],
    "companyRegistrationNumber": companyRegistrationNumberValues.reverse[companyRegistrationNumber],
    "shareCapital": shareCapital,
    "termAndConditions": termAndConditions,
    "companyPolicy": companyPolicy,
    "companyLogo": companyLogo,
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

enum CompanyName {
  TECH_CORP_LTD
}

final companyNameValues = EnumValues({
  "TechCorp Ltd.": CompanyName.TECH_CORP_LTD
});

enum CompanyRegistrationNumber {
  REG_982765
}

final companyRegistrationNumberValues = EnumValues({
  "REG-982765": CompanyRegistrationNumber.REG_982765
});

enum VatNumber {
  GB12356789
}

final vatNumberValues = EnumValues({
  "GB12356789": VatNumber.GB12356789
});

enum Status {
  PENDING
}

final statusValues = EnumValues({
  "pending": Status.PENDING
});

class Vehicle {
  String? vehicleId;
  String? adminId;
  dynamic carOwnerId;
  String? numberPlate;
  Brand? brand;
  Model? model;
  int? mileage;
  GasType? gasType;
  GasLevel? gasLevel;
  TyresCondition? tyresCondition;
  int? kmPerDay;
  int? extraKm;
  String? priceTotal;
  dynamic insuranceCertificate;
  CheckList? checkList;
  VehicleComments? comments;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vehicle({
    this.vehicleId,
    this.adminId,
    this.carOwnerId,
    this.numberPlate,
    this.brand,
    this.model,
    this.mileage,
    this.gasType,
    this.gasLevel,
    this.tyresCondition,
    this.kmPerDay,
    this.extraKm,
    this.priceTotal,
    this.insuranceCertificate,
    this.checkList,
    this.comments,
    this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    vehicleId: json["vehicleId"],
    adminId: json["adminId"],
    carOwnerId: json["carOwnerId"],
    numberPlate: json["numberPlate"],
    brand: brandValues.map[json["brand"]]!,
    model: modelValues.map[json["model"]]!,
    mileage: json["mileage"],
    gasType: gasTypeValues.map[json["gasType"]]!,
    gasLevel: gasLevelValues.map[json["gasLevel"]]!,
    tyresCondition: tyresConditionValues.map[json["tyresCondition"]]!,
    kmPerDay: json["kmPerDay"],
    extraKm: json["extraKm"],
    priceTotal: json["priceTotal"],
    insuranceCertificate: json["insuranceCertificate"],
    checkList: json["checkList"] == null ? null : CheckList.fromJson(json["checkList"]),
    comments: vehicleCommentsValues.map[json["comments"]]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "vehicleId": vehicleId,
    "adminId": adminId,
    "carOwnerId": carOwnerId,
    "numberPlate": numberPlate,
    "brand": brandValues.reverse[brand],
    "model": modelValues.reverse[model],
    "mileage": mileage,
    "gasType": gasTypeValues.reverse[gasType],
    "gasLevel": gasLevelValues.reverse[gasLevel],
    "tyresCondition": tyresConditionValues.reverse[tyresCondition],
    "kmPerDay": kmPerDay,
    "extraKm": extraKm,
    "priceTotal": priceTotal,
    "insuranceCertificate": insuranceCertificate,
    "checkList": checkList?.toJson(),
    "comments": vehicleCommentsValues.reverse[comments],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

enum Brand {
  LAMBORGINI
}

final brandValues = EnumValues({
  "Lamborgini": Brand.LAMBORGINI
});

class CheckList {
  bool? gps;
  bool? carPapers;
  bool? softyPack;
  bool? spareWheels;
  bool? chargingPort;

  CheckList({
    this.gps,
    this.carPapers,
    this.softyPack,
    this.spareWheels,
    this.chargingPort,
  });

  factory CheckList.fromJson(Map<String, dynamic> json) => CheckList(
    gps: json["GPS"],
    carPapers: json["CarPapers"],
    softyPack: json["softyPack"],
    spareWheels: json["spareWheels"],
    chargingPort: json["chargingPort"],
  );

  Map<String, dynamic> toJson() => {
    "GPS": gps,
    "CarPapers": carPapers,
    "softyPack": softyPack,
    "spareWheels": spareWheels,
    "chargingPort": chargingPort,
  };
}

enum VehicleComments {
  NO_NOTABLE_ISSUES
}

final vehicleCommentsValues = EnumValues({
  "No notable issues": VehicleComments.NO_NOTABLE_ISSUES
});

enum GasLevel {
  FULL
}

final gasLevelValues = EnumValues({
  "Full": GasLevel.FULL
});

enum GasType {
  PETROL
}

final gasTypeValues = EnumValues({
  "Petrol": GasType.PETROL
});

enum Model {
  CAR
}

final modelValues = EnumValues({
  "Car": Model.CAR
});

enum TyresCondition {
  GOOD
}

final tyresConditionValues = EnumValues({
  "Good": TyresCondition.GOOD
});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

/*
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
*/
