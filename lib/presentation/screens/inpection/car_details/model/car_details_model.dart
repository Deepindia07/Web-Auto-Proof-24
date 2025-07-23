class CarDetailsModel {
  final String numberPlate;
  final String brand;
  final String model;
  final String mileage;
  final String gasType;
  final String gasLevel;
  final String tyreCondition;
  final String kmDay;
  final String extraKm;
  final String priceTotal;
  final String comment;
  final bool softPack;
  final bool spareWheel;
  final bool phoneOlder;
  final bool gps;
  final bool chargingPort;
  final bool carPapers;

  CarDetailsModel({
    required this.numberPlate,
    required this.brand,
    required this.model,
    required this.mileage,
    required this.gasType,
    required this.gasLevel,
    required this.tyreCondition,
    required this.kmDay,
    required this.extraKm,
    required this.priceTotal,
    required this.comment,
    required this.softPack,
    required this.spareWheel,
    required this.phoneOlder,
    required this.gps,
    required this.chargingPort,
    required this.carPapers,
  });

  CarDetailsModel copyWith({
    String? numberPlate,
    String? brand,
    String? model,
    String? mileage,
    String? gasType,
    String? gasLevel,
    String? tyreCondition,
    String? kmDay,
    String? extraKm,
    String? priceTotal,
    String? comment,
    bool? softPack,
    bool? spareWheel,
    bool? phoneOlder,
    bool? gps,
    bool? chargingPort,
    bool? carPapers,
  }) {
    return CarDetailsModel(
      numberPlate: numberPlate ?? this.numberPlate,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      mileage: mileage ?? this.mileage,
      gasType: gasType ?? this.gasType,
      gasLevel: gasLevel ?? this.gasLevel,
      tyreCondition: tyreCondition ?? this.tyreCondition,
      kmDay: kmDay ?? this.kmDay,
      extraKm: extraKm ?? this.extraKm,
      priceTotal: priceTotal ?? this.priceTotal,
      comment: comment ?? this.comment,
      softPack: softPack ?? this.softPack,
      spareWheel: spareWheel ?? this.spareWheel,
      phoneOlder: phoneOlder ?? this.phoneOlder,
      gps: gps ?? this.gps,
      chargingPort: chargingPort ?? this.chargingPort,
      carPapers: carPapers ?? this.carPapers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numberPlate': numberPlate,
      'brand': brand,
      'model': model,
      'mileage': mileage,
      'gasType': gasType,
      'gasLevel': gasLevel,
      'tyreCondition': tyreCondition,
      'kmDay': kmDay,
      'extraKm': extraKm,
      'priceTotal': priceTotal,
      'comment': comment,
      'softPack': softPack,
      'spareWheel': spareWheel,
      'phoneOlder': phoneOlder,
      'gps': gps,
      'chargingPort': chargingPort,
      'carPapers': carPapers,
    };
  }

  factory CarDetailsModel.fromJson(Map<String, dynamic> json) {
    return CarDetailsModel(
      numberPlate: json['numberPlate'] ?? '',
      brand: json['brand'] ?? '',
      model: json['model'] ?? '',
      mileage: json['mileage'] ?? '',
      gasType: json['gasType'] ?? 'Diesel',
      gasLevel: json['gasLevel'] ?? '1/8',
      tyreCondition: json['tyreCondition'] ?? '',
      kmDay: json['kmDay'] ?? '',
      extraKm: json['extraKm'] ?? '',
      priceTotal: json['priceTotal'] ?? '',
      comment: json['comment'] ?? '',
      softPack: json['softPack'] ?? true,
      spareWheel: json['spareWheel'] ?? true,
      phoneOlder: json['phoneOlder'] ?? true,
      gps: json['gps'] ?? true,
      chargingPort: json['chargingPort'] ?? true,
      carPapers: json['carPapers'] ?? true,
    );
  }

  static CarDetailsModel empty() {
    return CarDetailsModel(
      numberPlate: '',
      brand: '',
      model: '',
      mileage: '',
      gasType: 'Diesel',
      gasLevel: '1/8',
      tyreCondition: '',
      kmDay: '',
      extraKm: '',
      priceTotal: '',
      comment: '',
      softPack: true,
      spareWheel: true,
      phoneOlder: true,
      gps: true,
      chargingPort: true,
      carPapers: true,
    );
  }
}
