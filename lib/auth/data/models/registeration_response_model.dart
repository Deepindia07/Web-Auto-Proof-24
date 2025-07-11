class RegistrationResponseModel {
  RegistrationResponseModel({
    required this.message,
    required this.user,
  });

  final String? message;
  final User? user;

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json){
    return RegistrationResponseModel(
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

}

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? role;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      role: json["role"],
    );
  }

}
