
class GetSingleVehicleModel {
  bool? success;
  String? message;
  SingleVehicleModel? vehicle;

  GetSingleVehicleModel({
    this.success,
    this.message,
    this.vehicle,
  });

  factory GetSingleVehicleModel.fromJson(Map<String, dynamic> json) => GetSingleVehicleModel(
    success: json["success"],
    message: json["message"],
    vehicle: json["vehicle"] == null ? null : SingleVehicleModel.fromJson(json["vehicle"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "vehicle": vehicle?.toJson(),
  };
}

class SingleVehicleModel {
  String? vehicleId;
  String? adminId;
  String? numberPlate;
  String? brand;
  String? model;
  int? mileage;
  String? gasType;
  String? gasLevel;
  String? tyresCondition;
  int? kmPerDay;
  int? extraKm;
  String? priceTotal;
  dynamic insuranceCertificate;
  List<String>? checkList;
  String? comments;
  DateTime? createdAt;
  DateTime? updatedAt;

  SingleVehicleModel({
    this.vehicleId,
    this.adminId,
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

  factory SingleVehicleModel.fromJson(Map<String, dynamic> json) => SingleVehicleModel(
    vehicleId: json["vehicleId"],
    adminId: json["adminId"],
    numberPlate: json["numberPlate"],
    brand: json["brand"],
    model: json["model"],
    mileage: json["mileage"],
    gasType: json["gasType"],
    gasLevel: json["gasLevel"],
    tyresCondition: json["tyresCondition"],
    kmPerDay: json["kmPerDay"],
    extraKm: json["extraKm"],
    priceTotal: json["priceTotal"],
    insuranceCertificate: json["insuranceCertificate"],
    checkList: json["checkList"] == null ? [] : List<String>.from(json["checkList"]!.map((x) => x)),
    comments: json["comments"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "vehicleId": vehicleId,
    "adminId": adminId,
    "numberPlate": numberPlate,
    "brand": brand,
    "model": model,
    "mileage": mileage,
    "gasType": gasType,
    "gasLevel": gasLevel,
    "tyresCondition": tyresCondition,
    "kmPerDay": kmPerDay,
    "extraKm": extraKm,
    "priceTotal": priceTotal,
    "insuranceCertificate": insuranceCertificate,
    "checkList": checkList == null ? [] : List<dynamic>.from(checkList!.map((x) => x)),
    "comments": comments,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
