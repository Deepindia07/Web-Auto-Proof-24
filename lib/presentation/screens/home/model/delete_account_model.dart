
class DeleteAccountModel {
  String? message;
  Data? data;
  bool? success;

  DeleteAccountModel({
    this.message,
    this.data,
    this.success,
  });

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data?.toJson(),
    "success": success,
  };
}

class Data {
  bool? success;
  String? message;

  Data({
    this.success,
    this.message,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
