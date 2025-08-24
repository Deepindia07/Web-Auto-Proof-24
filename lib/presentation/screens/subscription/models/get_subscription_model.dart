class GetSubscriptionPlanModel {
  String? message;
  List<GetSubscriptionPlanData>? data;

  GetSubscriptionPlanModel({this.message, this.data});

  factory GetSubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      GetSubscriptionPlanModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<GetSubscriptionPlanData>.from(
                json["data"]!.map((x) => GetSubscriptionPlanData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class GetSubscriptionPlanData {
  String? planId;
  String? planTitle;
  String? planDescription;
  int? planDuration;
  int? planUnits;
  String? planPrice;
  Features? features;
  bool? isActive;

  GetSubscriptionPlanData({
    this.planId,
    this.planTitle,
    this.planDescription,
    this.planDuration,
    this.planUnits,
    this.planPrice,
    this.features,
    this.isActive,
  });

  factory GetSubscriptionPlanData.fromJson(Map<String, dynamic> json) =>
      GetSubscriptionPlanData(
        planId: json["planId"],
        planTitle: json["planTitle"],
        planDescription: json["planDescription"],
        planDuration: json["planDuration"],
        planUnits: json["planUnits"],
        planPrice: json["planPrice"],
        features: json["features"] == null
            ? null
            : Features.fromJson(json["features"]),
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
    "planId": planId,
    "planTitle": planTitle,
    "planDescription": planDescription,
    "planDuration": planDuration,
    "planUnits": planUnits,
    "planPrice": planPrice,
    "features": features?.toJson(),
    "isActive": isActive,
  };
}

class Features {
  bool? freeAccount;
  bool? payAsYouUse;
  String? historySaving;
  bool? scalableOnDemand;
  int? prepaidUnits;
  String? targetAudience;
  bool? bestPricePerUnit;
  bool? apiFirst;
  String? validity;
  bool? customPricing;
  bool? unlimitedScaling;
  bool? realTimeAllocation;

  Features({
    this.freeAccount,
    this.payAsYouUse,
    this.historySaving,
    this.scalableOnDemand,
    this.prepaidUnits,
    this.targetAudience,
    this.bestPricePerUnit,
    this.apiFirst,
    this.validity,
    this.customPricing,
    this.unlimitedScaling,
    this.realTimeAllocation,
  });

  factory Features.fromJson(Map<String, dynamic> json) => Features(
    freeAccount: json["freeAccount"],
    payAsYouUse: json["payAsYouUse"],
    historySaving: json["historySaving"],
    scalableOnDemand: json["scalableOnDemand"],
    prepaidUnits: json["prepaidUnits"],
    targetAudience: json["targetAudience"],
    bestPricePerUnit: json["bestPricePerUnit"],
    apiFirst: json["apiFirst"],
    validity: json["validity"],
    customPricing: json["customPricing"],
    unlimitedScaling: json["unlimitedScaling"],
    realTimeAllocation: json["realTimeAllocation"],
  );

  Map<String, dynamic> toJson() => {
    "freeAccount": freeAccount,
    "payAsYouUse": payAsYouUse,
    "historySaving": historySaving,
    "scalableOnDemand": scalableOnDemand,
    "prepaidUnits": prepaidUnits,
    "targetAudience": targetAudience,
    "bestPricePerUnit": bestPricePerUnit,
    "apiFirst": apiFirst,
    "validity": validity,
    "customPricing": customPricing,
    "unlimitedScaling": unlimitedScaling,
    "realTimeAllocation": realTimeAllocation,
  };
}
