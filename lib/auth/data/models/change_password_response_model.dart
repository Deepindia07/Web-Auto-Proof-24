class ChangePasswordResponseModels {
  ChangePasswordResponseModels({
    required this.message,
    required this.user,
  });

  final String? message;
  final User? user;

  factory ChangePasswordResponseModels.fromJson(Map<String, dynamic> json){
    return ChangePasswordResponseModels(
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

}

class User {
  User({
    required this.userId,
    required this.firstName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.isEmailVerified,
  });

  final String? userId;
  final String? firstName;
  final String? email;
  final String? phoneNumber;
  final String? role;
  final bool? isEmailVerified;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userId: json["userId"],
      firstName: json["firstName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      role: json["role"],
      isEmailVerified: json["isEmailVerified"],
    );
  }

}
