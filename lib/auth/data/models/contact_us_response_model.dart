class ContactUsResponseModel {
  ContactUsResponseModel({
    required this.message,
    required this.query,
  });

  final String? message;
  final Query? query;

  factory ContactUsResponseModel.fromJson(Map<String, dynamic> json){
    return ContactUsResponseModel(
      message: json["message"],
      query: json["query"] == null ? null : Query.fromJson(json["query"]),
    );
  }

}

class Query {
  Query({
    required this.complaintid,
    required this.subject,
    required this.updatedAt,
    required this.createdAt,
    required this.message,
    required this.senderId,
  });

  final String? complaintid;
  final String? subject;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final dynamic message;
  final dynamic senderId;

  factory Query.fromJson(Map<String, dynamic> json){
    return Query(
      complaintid: json["complaintid"],
      subject: json["subject"],
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      message: json["Message"],
      senderId: json["senderId"],
    );
  }

}
