class ProfileModel {
  final String userType;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String countryCode;
/*
  final Strng profileImage;
*/
  final String address;
  final bool rememberSettings;
  final String gender;

  ProfileModel( {
  required this.userType,
  required this.firstName,
  required this.gender,
  required this.lastName,
  required this.email,
  required this.phoneNumber,
  required this.countryCode,
  /*required this.profileImage,*/
    required this.address,
    required this.rememberSettings,
  });

  Map<String, dynamic> toJson() {
    return {
      "userType": userType,
      "personalInfo": {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
/*
        "profileImage": profileImage,
*/
        "address": address,
        "rememberSettings": rememberSettings,
        "gender": gender,
      }
    };
  }
}
