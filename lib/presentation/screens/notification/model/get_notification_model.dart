

class GetNotificationModel {
  String? message;
  List<GetNotificationDataModel>? data;
  Pagination? pagination;

  GetNotificationModel({
    this.message,
    this.data,
    this.pagination,
  });

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
    message: json["message"],
    data: json["data"] == null ? [] : List<GetNotificationDataModel>.from(json["data"]!.map((x) => GetNotificationDataModel.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class GetNotificationDataModel {
  String? notificationId;
  String? title;
  String? message;
  String? type;
  dynamic relatedEntityType;
  dynamic relatedEntityId;
  dynamic createdByAdminId;
  dynamic createdByInspectorId;
  bool? isDeleted;
  bool? isSent;
  DateTime? scheduledAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Recipient>? recipients;

  GetNotificationDataModel({
    this.notificationId,
    this.title,
    this.message,
    this.type,
    this.relatedEntityType,
    this.relatedEntityId,
    this.createdByAdminId,
    this.createdByInspectorId,
    this.isDeleted,
    this.isSent,
    this.scheduledAt,
    this.createdAt,
    this.updatedAt,
    this.recipients,
  });

  factory GetNotificationDataModel.fromJson(Map<String, dynamic> json) => GetNotificationDataModel(
    notificationId: json["notificationId"],
    title: json["title"],
    message: json["message"],
    type: json["type"],
    relatedEntityType: json["relatedEntityType"],
    relatedEntityId: json["relatedEntityId"],
    createdByAdminId: json["createdByAdminId"],
    createdByInspectorId: json["createdByInspectorId"],
    isDeleted: json["isDeleted"],
    isSent: json["isSent"],
    scheduledAt: json["scheduledAt"] == null ? null : DateTime.parse(json["scheduledAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    recipients: json["recipients"] == null ? [] : List<Recipient>.from(json["recipients"]!.map((x) => Recipient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "notificationId": notificationId,
    "title": title,
    "message": message,
    "type": type,
    "relatedEntityType": relatedEntityType,
    "relatedEntityId": relatedEntityId,
    "createdByAdminId": createdByAdminId,
    "createdByInspectorId": createdByInspectorId,
    "isDeleted": isDeleted,
    "isSent": isSent,
    "scheduledAt": scheduledAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "recipients": recipients == null ? [] : List<dynamic>.from(recipients!.map((x) => x.toJson())),
  };
}

class Recipient {
  String? recipientId;
  String? notificationId;
  String? userId;
  dynamic inspectorId;
  bool? isRead;
  dynamic readAt;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  RecipientUser? recipientUser;
  dynamic recipientInspector;

  Recipient({
    this.recipientId,
    this.notificationId,
    this.userId,
    this.inspectorId,
    this.isRead,
    this.readAt,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.recipientUser,
    this.recipientInspector,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
    recipientId: json["recipientId"],
    notificationId: json["notificationId"],
    userId: json["userId"],
    inspectorId: json["inspectorId"],
    isRead: json["isRead"],
    readAt: json["readAt"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    recipientUser: json["recipientUser"] == null ? null : RecipientUser.fromJson(json["recipientUser"]),
    recipientInspector: json["recipientInspector"],
  );

  Map<String, dynamic> toJson() => {
    "recipientId": recipientId,
    "notificationId": notificationId,
    "userId": userId,
    "inspectorId": inspectorId,
    "isRead": isRead,
    "readAt": readAt,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "recipientUser": recipientUser?.toJson(),
    "recipientInspector": recipientInspector,
  };
}

class RecipientUser {
  String? userId;
  FirstName? firstName;
  LastName? lastName;
  String? email;

  RecipientUser({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
  });

  factory RecipientUser.fromJson(Map<String, dynamic> json) => RecipientUser(
    userId: json["userId"],
    firstName: firstNameValues.map[json["firstName"]]!,
    lastName: lastNameValues.map[json["lastName"]]!,
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstNameValues.reverse[firstName],
    "lastName": lastNameValues.reverse[lastName],
    "email": email,
  };
}

enum FirstName {
  ADMIN,
  RAMAN,
  TESTER
}

final firstNameValues = EnumValues({
  "admin": FirstName.ADMIN,
  "raman": FirstName.RAMAN,
  "tester": FirstName.TESTER
});

enum LastName {
  BHAI,
  KUMAR_SINGH,
  TEST
}

final lastNameValues = EnumValues({
  " bhai": LastName.BHAI,
  "kumar Singh": LastName.KUMAR_SINGH,
  "test": LastName.TEST
});

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? totalPages;

  Pagination({
    this.page,
    this.limit,
    this.total,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPages: json["totalPages"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPages": totalPages,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
