class CarDetailsModel {
  String? stage;
  String? checkType;
  CarDetails? carDetails;
  OwnerDetails? ownerDetails;
  ClientDetails? clientDetails;
  ProcessedPhotos? processedPhotos;
  String? comments;
  String? inspectorId;

  CarDetailsModel({
    this.stage,
    this.checkType,
    this.carDetails,
    this.ownerDetails,
    this.clientDetails,
    this.processedPhotos,
    this.comments,
    this.inspectorId,
  });

  CarDetailsModel.fromJson(Map<String, dynamic> json) {
    stage = json['stage'];
    checkType = json['checkType'];
    carDetails = json['carDetails'] != null ? CarDetails.fromJson(json['carDetails']) : null;
    ownerDetails = json['ownerDetails'] != null ? OwnerDetails.fromJson(json['ownerDetails']) : null;
    clientDetails = json['clientDetails'] != null ? ClientDetails.fromJson(json['clientDetails']) : null;
    processedPhotos = json['processedPhotos'] != null ? ProcessedPhotos.fromJson(json['processedPhotos']) : null;
    comments = json['comments'];
    inspectorId = json['inspectorId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['stage'] = stage;
    data['checkType'] = checkType;
    if (carDetails != null) data['carDetails'] = carDetails!.toJson();
    if (ownerDetails != null) data['ownerDetails'] = ownerDetails!.toJson();
    if (clientDetails != null) data['clientDetails'] = clientDetails!.toJson();
    if (processedPhotos != null) data['processedPhotos'] = processedPhotos!.toJson();
    data['comments'] = comments;
    data['inspectorId'] = inspectorId;
    return data;
  }
}

class CarDetails {
  String? numberPlate;
  String? brand;
  String? model;
  int? mileage;
  String? gasType;
  String? gasLevel;
  String? tyresCondition;
  int? kmPerDay;
  int? extraKm;
  double? priceTotal;
  String? insuranceCertificate;
  CarCheckList? checkList;
  String? comments;

  CarDetails({
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
  });

  CarDetails.fromJson(Map<String, dynamic> json) {
    numberPlate = json['numberPlate'];
    brand = json['brand'];
    model = json['model'];
    mileage = json['mileage'];
    gasType = json['gasType'];
    gasLevel = json['gasLevel'];
    tyresCondition = json['tyresCondition'];
    kmPerDay = json['kmPerDay'];
    extraKm = json['extraKm'];
    priceTotal = (json['priceTotal'] as num?)?.toDouble();
    insuranceCertificate = json['insuranceCertificate'];
    checkList = json['checkList'] != null ? CarCheckList.fromJson(json['checkList']) : null;
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['numberPlate'] = numberPlate;
    data['brand'] = brand;
    data['model'] = model;
    data['mileage'] = mileage;
    data['gasType'] = gasType;
    data['gasLevel'] = gasLevel;
    data['tyresCondition'] = tyresCondition;
    data['kmPerDay'] = kmPerDay;
    data['extraKm'] = extraKm;
    data['priceTotal'] = priceTotal;
    data['insuranceCertificate'] = insuranceCertificate;
    if (checkList != null) data['checkList'] = checkList!.toJson();
    data['comments'] = comments;
    return data;
  }
}

class CarCheckList {
  bool? softyPack;
  bool? spareWheels;
  bool? gps;
  bool? chargingPort;
  bool? carPapers;

  CarCheckList({
    this.softyPack,
    this.spareWheels,
    this.gps,
    this.chargingPort,
    this.carPapers,
  });

  CarCheckList.fromJson(Map<String, dynamic> json) {
    softyPack = json['softyPack'];
    spareWheels = json['spareWheels'];
    gps = json['GPS'];
    chargingPort = json['chargingPort'];
    carPapers = json['CarPapers'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['softyPack'] = softyPack;
    data['spareWheels'] = spareWheels;
    data['GPS'] = gps;
    data['chargingPort'] = chargingPort;
    data['CarPapers'] = carPapers;
    return data;
  }
}
class OwnerDetails {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final String? countryCode;
  final String? inspectId;
  final String? gender;
  final OwnerCheckList? checkList;

  OwnerDetails({
     this.firstName,
     this.lastName,
     this.phoneNumber,
     this.email,
     this.address,
     this.countryCode,
     this.inspectId,
     this.gender,
     this.checkList,
  });

  // ✅ copyWith (already explained earlier)
  OwnerDetails copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? address,
    String? countryCode,
    String? inspectId,
    String? gender,
    OwnerCheckList? checkList,
  }) {
    return OwnerDetails(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      countryCode: countryCode ?? this.countryCode,
      inspectId: inspectId ?? this.inspectId,
      gender: gender ?? this.gender,
      checkList: checkList ?? this.checkList,
    );
  }

  // ✅ fromJson
  factory OwnerDetails.fromJson(Map<String, dynamic> json) {
    return OwnerDetails(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      countryCode: json['countryCode'] ?? '+91',
      inspectId: json['inspectorId'] ?? '',
      gender: json['gender'] ?? 'MALE',
      checkList: OwnerCheckList.fromJson(json['checkList'] ?? {}),
    );
  }

  // ✅ toJson
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'countryCode': countryCode,
      'inspectId': inspectId,
      'gender': gender,
      'checkList': checkList?.toJson(),
    };
  }
}


/*class OwnerDetails {
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? address;
  String? gender;
  String? inspectId;
  OwnerCheckList? checkList;

  OwnerDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.countryCode,
    this.phoneNumber,
    this.address,
    this.gender,
    this.inspectId,
    this.checkList,
  });

  OwnerDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    gender = json['gender'];
    checkList = json['checkList'] != null ? OwnerCheckList.fromJson(json['checkList']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['gender'] = gender;
    if (checkList != null) data['checkList'] = checkList!.toJson();
    return data;
  }
}*/

class OwnerCheckList {
  bool? driverLicensePhoto;
  bool? driverIdPhoto;

  OwnerCheckList({
    this.driverLicensePhoto,
    this.driverIdPhoto,
  });

  OwnerCheckList.fromJson(Map<String, dynamic> json) {
    driverLicensePhoto = json['driverLicensePhoto'];
    driverIdPhoto = json['driverIdPhoto'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['driverLicensePhoto'] = driverLicensePhoto;
    data['driverIdPhoto'] = driverIdPhoto;
    return data;
  }
}

class ClientDetails {
  String? firstName;
  String? lastName;
  String? birthdate;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? address;
  String? gender;
  String? drivingLicenseNumber;
  String? dateOfIssue;
  int? rentalDuration;
  String? leaseStartDate;
  String? leaseEndDate;
  String? comments;

  ClientDetails({
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
    this.comments,
  });

  ClientDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthdate = json['birthdate'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    address = json['address'];
    gender = json['gender'];
    drivingLicenseNumber = json['drivingLicenseNumber'];
    dateOfIssue = json['dateOfIssue'];
    rentalDuration = json['rentalDuration'];
    leaseStartDate = json['leaseStartDate'];
    leaseEndDate = json['leaseEndDate'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['birthdate'] = birthdate;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['address'] = address;
    data['gender'] = gender;
    data['drivingLicenseNumber'] = drivingLicenseNumber;
    data['dateOfIssue'] = dateOfIssue;
    data['rentalDuration'] = rentalDuration;
    data['leaseStartDate'] = leaseStartDate;
    data['leaseEndDate'] = leaseEndDate;
    data['comments'] = comments;
    return data;
  }
}

class ProcessedPhotos {
  Photos? photos;
  Signatures? signatures;

  ProcessedPhotos({this.photos, this.signatures});

  ProcessedPhotos.fromJson(Map<String, dynamic> json) {
    photos = json['photos'] != null ? Photos.fromJson(json['photos']) : null;
    signatures = json['signatures'] != null ? Signatures.fromJson(json['signatures']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (photos != null) data['photos'] = photos!.toJson();
    if (signatures != null) data['signatures'] = signatures!.toJson();
    return data;
  }
}

class Photos {
  FrontSide? frontSide;
  FrontSide? rearSide;

  Photos({this.frontSide, this.rearSide});

  Photos.fromJson(Map<String, dynamic> json) {
    frontSide = json['front_side'] != null ? FrontSide.fromJson(json['front_side']) : null;
    rearSide = json['rear_side'] != null ? FrontSide.fromJson(json['rear_side']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (frontSide != null) data['front_side'] = frontSide!.toJson();
    if (rearSide != null) data['rear_side'] = rearSide!.toJson();
    return data;
  }
}

class FrontSide {
  String? before;

  FrontSide({this.before});

  FrontSide.fromJson(Map<String, dynamic> json) {
    before = json['before'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['before'] = before;
    return data;
  }
}

class Signatures {
  InspectorSignature? inspectorSignature;
  InspectorSignature? clientSignature;

  Signatures({this.inspectorSignature, this.clientSignature});

  Signatures.fromJson(Map<String, dynamic> json) {
    inspectorSignature = json['inspectorSignature'] != null ? InspectorSignature.fromJson(json['inspectorSignature']) : null;
    clientSignature = json['clientSignature'] != null ? InspectorSignature.fromJson(json['clientSignature']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (inspectorSignature != null) data['inspectorSignature'] = inspectorSignature!.toJson();
    if (clientSignature != null) data['clientSignature'] = clientSignature!.toJson();
    return data;
  }
}

class InspectorSignature {
  String? duringCheckInTime;

  InspectorSignature({this.duringCheckInTime});

  InspectorSignature.fromJson(Map<String, dynamic> json) {
    duringCheckInTime = json['during_check_in_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['during_check_in_time'] = duringCheckInTime;
    return data;
  }
}