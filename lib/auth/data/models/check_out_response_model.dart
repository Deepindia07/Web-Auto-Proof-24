class CheckOutResponseModel {
  CheckOutResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final Data? data;

  factory CheckOutResponseModel.fromJson(Map<String, dynamic> json){
    return CheckOutResponseModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.inspection,
    required this.inspectionPhotos,
  });

  final Inspection? inspection;
  final InspectionPhotos? inspectionPhotos;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      inspection: json["inspection"] == null ? null : Inspection.fromJson(json["inspection"]),
      inspectionPhotos: json["inspectionPhotos"] == null ? null : InspectionPhotos.fromJson(json["inspectionPhotos"]),
    );
  }

}

class Inspection {
  Inspection({
    required this.inspectionId,
    required this.inspectorId,
    required this.clientId,
    required this.companyId,
    required this.vehicleId,
    required this.carOwnerId,
    required this.checkType,
    required this.checkInDate,
    required this.comments,
    required this.updatedAt,
    required this.createdAt,
    required this.checkOutDate,
    required this.ownerId,
  });

  final String? inspectionId;
  final String? inspectorId;
  final String? clientId;
  final String? companyId;
  final String? vehicleId;
  final String? carOwnerId;
  final String? checkType;
  final DateTime? checkInDate;
  final String? comments;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final dynamic checkOutDate;
  final dynamic ownerId;

  factory Inspection.fromJson(Map<String, dynamic> json){
    return Inspection(
      inspectionId: json["inspectionId"],
      inspectorId: json["inspectorId"],
      clientId: json["clientId"],
      companyId: json["companyId"],
      vehicleId: json["vehicleId"],
      carOwnerId: json["carOwnerId"],
      checkType: json["checkType"],
      checkInDate: DateTime.tryParse(json["checkInDate"] ?? ""),
      comments: json["comments"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      checkOutDate: json["checkOutDate"],
      ownerId: json["ownerId"],
    );
  }

}

class InspectionPhotos {
  InspectionPhotos({
    required this.inspectionPhotoId,
    required this.inspectionId,
    required this.photos,
    required this.optionalPhotos,
    required this.signatures,
    required this.stage,
    required this.checkInUploadedBy,
    required this.checkInDate,
    required this.updatedAt,
    required this.createdAt,
    required this.checkOutUploadedBy,
    required this.checkOutDate,
  });

  final String? inspectionPhotoId;
  final String? inspectionId;
  final Photos? photos;
  final OptionalPhotos? optionalPhotos;
  final Signatures? signatures;
  final String? stage;
  final String? checkInUploadedBy;
  final DateTime? checkInDate;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final dynamic checkOutUploadedBy;
  final dynamic checkOutDate;

  factory InspectionPhotos.fromJson(Map<String, dynamic> json){
    return InspectionPhotos(
      inspectionPhotoId: json["inspectionPhotoId"],
      inspectionId: json["inspectionId"],
      photos: json["photos"] == null ? null : Photos.fromJson(json["photos"]),
      optionalPhotos: json["optionalPhotos"] == null ? null : OptionalPhotos.fromJson(json["optionalPhotos"]),
      signatures: json["signatures"] == null ? null : Signatures.fromJson(json["signatures"]),
      stage: json["stage"],
      checkInUploadedBy: json["checkInUploadedBy"],
      checkInDate: DateTime.tryParse(json["checkInDate"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      checkOutUploadedBy: json["checkOutUploadedBy"],
      checkOutDate: json["checkOutDate"],
    );
  }

}

class OptionalPhotos {
  OptionalPhotos({
    required this.damage1,
  });

  final Damage1? damage1;

  factory OptionalPhotos.fromJson(Map<String, dynamic> json){
    return OptionalPhotos(
      damage1: json["damage_1"] == null ? null : Damage1.fromJson(json["damage_1"]),
    );
  }

}

class Damage1 {
  Damage1({
    required this.name,
    required this.after,
    required this.before,
  });

  final String? name;
  final dynamic after;
  final String? before;

  factory Damage1.fromJson(Map<String, dynamic> json){
    return Damage1(
      name: json["name"],
      after: json["after"],
      before: json["before"],
    );
  }

}

class Photos {
  Photos({
    required this.odometer,
    required this.frontSide,
    required this.frontLeftWheel,
  });

  final FrontLeftWheel? odometer;
  final FrontLeftWheel? frontSide;
  final FrontLeftWheel? frontLeftWheel;

  factory Photos.fromJson(Map<String, dynamic> json){
    return Photos(
      odometer: json["odometer"] == null ? null : FrontLeftWheel.fromJson(json["odometer"]),
      frontSide: json["front_side"] == null ? null : FrontLeftWheel.fromJson(json["front_side"]),
      frontLeftWheel: json["front_left_wheel"] == null ? null : FrontLeftWheel.fromJson(json["front_left_wheel"]),
    );
  }

}

class FrontLeftWheel {
  FrontLeftWheel({
    required this.after,
    required this.before,
  });

  final dynamic after;
  final String? before;

  factory FrontLeftWheel.fromJson(Map<String, dynamic> json){
    return FrontLeftWheel(
      after: json["after"],
      before: json["before"],
    );
  }

}

class Signatures {
  Signatures({
    required this.client,
    required this.inspector,
  });

  final Client? client;
  final Client? inspector;

  factory Signatures.fromJson(Map<String, dynamic> json){
    return Signatures(
      client: json["client"] == null ? null : Client.fromJson(json["client"]),
      inspector: json["inspector"] == null ? null : Client.fromJson(json["inspector"]),
    );
  }

}

class Client {
  Client({
    required this.checkIn,
    required this.checkOut,
  });

  final String? checkIn;
  final dynamic checkOut;

  factory Client.fromJson(Map<String, dynamic> json){
    return Client(
      checkIn: json["checkIn"],
      checkOut: json["checkOut"],
    );
  }

}
