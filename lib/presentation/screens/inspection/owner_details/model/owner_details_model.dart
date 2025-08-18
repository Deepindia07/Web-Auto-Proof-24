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
    required this.isDriverId
});

  OwnerDetailsModel copyWith({
    final String? firstName,
    final String? lastName,
    final String? mobileNo,
    final String? email,
    final String? address,
    final bool? isDriverLicense,
    final bool? isDriverId
}){
    return OwnerDetailsModel(
        firstName: firstName??this.firstName,
        lastName: lastName??this.lastName,
        mobileNo: mobileNo??this.mobileNo,
        email: email??this.email,
        address: address??this.address,
        isDriverLicense: isDriverLicense??this.isDriverLicense,
        isDriverId: isDriverId??this.isDriverId
    );
}
}