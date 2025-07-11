class LoginResponseModel {
  LoginResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  final String? message;
  final String? token;
  final User? user;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json){
    return LoginResponseModel(
      message: json["message"],
      token: json["token"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

}

class User {
  User({
    required this.userId,
    required this.role,
    required this.email,
  });

  final String? userId;
  final String? role;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      userId: json["userId"],
      role: json["role"],
      email: json["email"],
    );
  }

}
