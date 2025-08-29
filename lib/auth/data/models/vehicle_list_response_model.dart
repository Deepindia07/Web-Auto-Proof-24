class VehicleListResponseModel {
  VehicleListResponseModel({
    required this.success,
    required this.message,
    required this.vehicles,
    required this.total,
    required this.currentPage,
    required this.totalPages,
  });

  final bool? success;
  final String? message;
  final List<Vehicle> vehicles;
  final int? total;
  final int? currentPage;
  final int? totalPages;

  factory VehicleListResponseModel.fromJson(Map<String, dynamic> json){
    return VehicleListResponseModel(
      success: json["success"],
      message: json["message"],
      vehicles: json["vehicles"] == null ? [] : List<Vehicle>.from(json["vehicles"]!.map((x) => Vehicle.fromJson(x))),
      total: json["total"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
    );
  }

}






class Vehicle {
  Vehicle({
    required this.vehicleId,
    required this.adminId,
    required this.carOwnerId,
    required this.numberPlate,
    required this.brand,
    required this.model,
    required this.mileage,
    required this.gasType,
    required this.gasLevel,
    required this.tyresCondition,
    required this.kmPerDay,
    required this.extraKm,
    required this.priceTotal,
    required this.insuranceCertificate,
    required this.checkList,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? vehicleId;
  final String? adminId;
  final dynamic carOwnerId;
  final String? numberPlate;
  final String? brand;
  final String? model;
  final int? mileage;
  final String? gasType;
  final String? gasLevel;
  final String? tyresCondition;
  final int? kmPerDay;
  final int? extraKm;
  final String? priceTotal;
  final dynamic insuranceCertificate;
  final List<String> checkList;
  final String? comments;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Vehicle.fromJson(Map<String, dynamic> json){
    return Vehicle(
      vehicleId: json["vehicleId"],
      adminId: json["adminId"],
      carOwnerId: json["carOwnerId"],
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
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

}
