class OwnerDetailsModel {
  final String firstName;
  final String lastName;
  final String mobileNo;
  final String email;
  final String address;
  final bool isDriverLicense;
  final bool isDriverId;

  OwnerDetailsModel({
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.email,
    required this.address,
    required this.isDriverLicense,
    required this.isDriverId,
  });

  OwnerDetailsModel copyWith({
    String? firstName,
    String? lastName,
    String? mobileNo,
    String? email,
    String? address,
    bool? isDriverLicense,
    bool? isDriverId,
  }) {
    return OwnerDetailsModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      mobileNo: mobileNo ?? this.mobileNo,
      email: email ?? this.email,
      address: address ?? this.address,
      isDriverLicense: isDriverLicense ?? this.isDriverLicense,
      isDriverId: isDriverId ?? this.isDriverId,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'mobileNo': mobileNo,
      'email': email,
      'address': address,
      'isDriverLicense': isDriverLicense,
      'isDriverId': isDriverId,
    };
  }

  factory OwnerDetailsModel.fromJson(Map<String, dynamic> json) {
    return OwnerDetailsModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      isDriverLicense: json['isDriverLicense'] ?? false,
      isDriverId: json['isDriverId'] ?? false,
    );
  }

  static OwnerDetailsModel empty() {
    return OwnerDetailsModel(
      firstName: '',
      lastName: '',
      mobileNo: '',
      email: '',
      address: '',
      isDriverLicense: false,
      isDriverId: false,
    );
  }
}

/// Fetching owner details from any source
Future<Map<String, dynamic>> fetchOwnerDataFromAnySource() async {
  final ownerDetails = OwnerDetailsModel.empty();
  return {
    "firstName": ownerDetails.firstName,
    "lastName": ownerDetails.lastName,
    "email": ownerDetails.email,
    "countryCode": "+33",
    "phoneNumber": ownerDetails.mobileNo,
    "address": ownerDetails.address,
    "gender": "MALE",
    "checkList": [ownerDetails.isDriverLicense, ownerDetails.isDriverId]
  };
}