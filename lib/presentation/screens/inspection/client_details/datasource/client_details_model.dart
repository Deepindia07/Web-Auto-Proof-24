class ClientDetailsModel{
  final String firstName;
  final String lastName;
  final String dob;
  final String mobileNo;
  final String email;
  final String drivingLicense;
  final String dateOfIssues;
  final String rentalDuration;
  final String leaseEndDateTime;

  ClientDetailsModel({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.mobileNo,
    required this.email,
    required this.drivingLicense,
    required this.dateOfIssues,
    required this.rentalDuration,
    required this.leaseEndDateTime
});

  ClientDetailsModel copyWith({
    final String? firstName,
    final String? lastName,
    final String? dob,
    final String? mobileNo,
    final String? email,
    final String? drivingLicense,
    final String? dateOfIssues,
    final String? rentalDuration,
    final String? leaseEndDateTime
}){
    return ClientDetailsModel(
        firstName: firstName??this.firstName,
        lastName: lastName??this.lastName,
        dob: dob??this.dob,
        mobileNo: mobileNo??this.mobileNo,
        email: email??this.email,
        drivingLicense: drivingLicense??this.drivingLicense,
        dateOfIssues: dateOfIssues??this.dateOfIssues,
        rentalDuration: rentalDuration??this.rentalDuration,
        leaseEndDateTime: leaseEndDateTime??this.leaseEndDateTime
    );
  }
}