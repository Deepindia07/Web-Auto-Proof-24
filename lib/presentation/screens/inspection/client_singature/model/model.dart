class ClientSignatureModel {
  final String? signatureData; // Base64 encoded signature image
  final DateTime signatureDate;
  final String clientName;
  final String reportId;
  final bool isValidated;
  final String? signaturePath;

  const ClientSignatureModel({
    this.signatureData,
    required this.signatureDate,
    required this.clientName,
    required this.reportId,
    this.isValidated = false,
    this.signaturePath,
  });

  ClientSignatureModel copyWith({
    String? signatureData,
    DateTime? signatureDate,
    String? clientName,
    String? reportId,
    bool? isValidated,
    String? signaturePath,
  }) {
    return ClientSignatureModel(
      signatureData: signatureData ?? this.signatureData,
      signatureDate: signatureDate ?? this.signatureDate,
      clientName: clientName ?? this.clientName,
      reportId: reportId ?? this.reportId,
      isValidated: isValidated ?? this.isValidated,
      signaturePath: signaturePath ?? this.signaturePath,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'signatureData': signatureData,
      'signatureDate': signatureDate.toIso8601String(),
      'clientName': clientName,
      'reportId': reportId,
      'isValidated': isValidated,
      'signaturePath': signaturePath,
    };
  }

  factory ClientSignatureModel.fromJson(Map<String, dynamic> json) {
    return ClientSignatureModel(
      signatureData: json['signatureData'],
      signatureDate: DateTime.parse(json['signatureDate']),
      clientName: json['clientName'],
      reportId: json['reportId'],
      isValidated: json['isValidated'] ?? false,
      signaturePath: json['signaturePath'],
    );
  }

  @override
  String toString() {
    return 'ClientSignatureModel(signatureData: ${signatureData != null ? 'Present' : 'null'}, signatureDate: $signatureDate, clientName: $clientName, reportId: $reportId, isValidated: $isValidated, signaturePath: $signaturePath)';
  }
}
