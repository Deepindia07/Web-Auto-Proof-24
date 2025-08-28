// class ClientDetailsModel {
//   String? dob;
//   String? drivingLicense;
//   String? dateOfIssues;
//   String? rentalDuration;
//   String? leaseStartDate;
//   String? leaseEndDateTime;
//
//   ClientDetailsModel({
//
//     this.dob,
//     this.drivingLicense,
//     this.dateOfIssues,
//     this.rentalDuration,
//     this.leaseStartDate,
//     this.leaseEndDateTime,
//   });
//
//   ClientDetailsModel copyWith({
//     String? firstName, // Removed 'final' keyword
//     String? lastName,
//     String? dob,
//     String? mobileNo,
//     String? email,
//     String? address,
//     String? drivingLicense,
//     String? dateOfIssues,
//     String? rentalDuration,
//     String? leaseStartDate,
//     String? leaseEndDateTime,
//     String? comment,
//   }) {
//     return ClientDetailsModel(
//       firstName: firstName ?? this.firstName,
//       lastName: lastName ?? this.lastName,
//       dob: dob ?? this.dob,
//       mobileNo: mobileNo ?? this.mobileNo,
//       email: email ?? this.email,
//       address: address ?? this.address,
//       drivingLicense: drivingLicense ?? this.drivingLicense,
//       dateOfIssues: dateOfIssues ?? this.dateOfIssues,
//       rentalDuration: rentalDuration ?? this.rentalDuration,
//       leaseStartDate: leaseStartDate ?? this.leaseStartDate,
//       leaseEndDateTime: leaseEndDateTime ?? this.leaseEndDateTime,
//       comment: comment ?? this.comment,
//     );
//   }
//
//   // Convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'firstName': firstName,
//       'lastName': lastName,
//         'dob': dob,
//       'mobileNo': mobileNo,
//       'email': email,
//       'address': address,
//       'drivingLicense': drivingLicense,
//       'dateOfIssues': dateOfIssues,
//       'rentalDuration': rentalDuration,
//       'leaseStartDate': leaseStartDate,
//       'leaseEndDateTime': leaseEndDateTime,
//       'comment': comment,
//     };
//   }
//
//   // Create from JSON
//   factory ClientDetailsModel.fromJson(Map<String, dynamic> json) {
//     return ClientDetailsModel(
//       firstName: json['firstName'] ?? '',
//       lastName: json['lastName'] ?? '',
//       dob: json['dob'] ?? '',
//       mobileNo: json['mobileNo'] ?? '',
//       email: json['email'] ?? '',
//       address: json['address'] ?? '',
//       drivingLicense: json['drivingLicense'] ?? '',
//       dateOfIssues: json['dateOfIssues'] ?? '',
//       rentalDuration: json['rentalDuration'] ?? '',
//       leaseStartDate: json['leaseStartDate'] ?? '',
//       leaseEndDateTime: json['leaseEndDateTime'] ?? '',
//       comment: json['comment'] ?? '',
//     );
//   }
//
//   // Create empty instance with default values
//   static ClientDetailsModel empty() {
//     return ClientDetailsModel(
//       firstName: '',
//       lastName: '',
//       dob: '',
//       mobileNo: '',
//       email: '',
//       address: '',
//       drivingLicense: '',
//       dateOfIssues: '',
//       rentalDuration: '',
//       leaseStartDate: '',
//       leaseEndDateTime: '',
//       comment: '',
//     );
//   }
// }
//
// /// Option 1: Sending client data from empty instance (default/empty values)
// Future<Map<String, dynamic>> fetchClientDataFromAnySource() async {
//   final clientData = ClientDetailsModel.empty();
//   return {
//     "firstName": clientData.firstName,
//     "lastName": clientData.lastName,
//     "birthdate": clientData.dob,
//     "countryCode": "+33",
//     "phoneNumber": clientData.mobileNo,
//     "email": clientData.email,
//     "address": clientData.address,
//     "gender": "MALE",
//     "drivingLicenseNumber": clientData.drivingLicense,
//     "dateOfIssue": clientData.dateOfIssues,
//     "rentalDuration": clientData.rentalDuration,
//     "leaseStartDate": clientData.leaseStartDate,
//     "leaseEndDate": clientData.leaseEndDateTime,
//     "comments": clientData.comment
//   };
// }
