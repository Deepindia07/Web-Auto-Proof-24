

class GetVehicleModel {
  bool? success;
  String? message;
  List<Vehicle>? vehicles;
  int? total;
  int? currentPage;
  int? totalPages;

  GetVehicleModel({
    this.success,
    this.message,
    this.vehicles,
    this.total,
    this.currentPage,
    this.totalPages,
  });

  factory GetVehicleModel.fromJson(Map<String, dynamic> json) => GetVehicleModel(
    success: json["success"],
    message: json["message"],
    vehicles: json["vehicles"] == null ? [] : List<Vehicle>.from(json["vehicles"]!.map((x) => Vehicle.fromJson(x))),
    total: json["total"],
    currentPage: json["currentPage"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "vehicles": vehicles == null ? [] : List<dynamic>.from(vehicles!.map((x) => x.toJson())),
    "total": total,
    "currentPage": currentPage,
    "totalPages": totalPages,
  };
}

class Vehicle {
  String? vehicleId;
  String? adminId;
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
  dynamic checkList;
  Comments? comments;
  DateTime? createdAt;
  DateTime? updatedAt;

  Vehicle({
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

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    vehicleId: json["vehicleId"],
    adminId: json["adminId"],
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
    checkList: json["checkList"],
    comments: commentsValues.map[json["comments"]]!,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "vehicleId": vehicleId,
    "adminId": adminId,
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
    "checkList": checkList,
    "comments": commentsValues.reverse[comments],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

enum Brand {
  LAMBORGINI,
  MAHINDRA,
  TOYOTA
}

final brandValues = EnumValues({
  "Lamborgini": Brand.LAMBORGINI,
  "Mahindra": Brand.MAHINDRA,
  "Toyota": Brand.TOYOTA
});

class CheckListClass {
  bool? gps;
  bool? carPapers;
  bool? softyPack;
  bool? spareWheels;
  bool? chargingPort;

  CheckListClass({
    this.gps,
    this.carPapers,
    this.softyPack,
    this.spareWheels,
    this.chargingPort,
  });

  factory CheckListClass.fromJson(Map<String, dynamic> json) => CheckListClass(
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

enum Comments {
  NO_NOTABLE_ISSUES
}

final commentsValues = EnumValues({
  "No notable issues": Comments.NO_NOTABLE_ISSUES
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
  BENZ_X200,
  CAR,
  THAR_4_X4
}

final modelValues = EnumValues({
  "Benz X200": Model.BENZ_X200,
  "Car": Model.CAR,
  "Thar 4x4": Model.THAR_4_X4
});

enum TyresCondition {
  GOOD
}

final tyresConditionValues = EnumValues({
  "Good": TyresCondition.GOOD
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
