class SignatureModel {
  final String? signatureImagePath;
  final String? signatureBase64;

  const SignatureModel({
    this.signatureImagePath,
    this.signatureBase64,
  });

  SignatureModel copyWith({
    String? signatureImagePath,
    String? signatureBase64,
  }) {
    return SignatureModel(
      signatureImagePath: signatureImagePath ?? this.signatureImagePath,
      signatureBase64: signatureBase64 ?? this.signatureBase64,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'signatureImagePath': signatureImagePath,
      'signatureBase64': signatureBase64,
    };
  }

  factory SignatureModel.fromJson(Map<String, dynamic> json) {
    return SignatureModel(
      signatureImagePath: json['signatureImagePath'] as String?,
      signatureBase64: json['signatureBase64'] as String?,
    );
  }

  bool get isValid => signatureBase64 != null && signatureBase64!.isNotEmpty;

Map<String, dynamic> get formattedSignatureData => {
  'base64': signatureBase64,
  'imagePath': signatureImagePath,
  'timestamp': DateTime.now().toIso8601String(),
};
}

/// send signature image across anywhere
Future<Map<String, dynamic>> fetchOwnerSignatureDataFromAnySource({
  SignatureModel? inspectorSignature,
  // SignatureModel? clientSignature,
}) async {
  final baseData = {
    "inspector": {
      "checkIn": inspectorSignature,
      "checkOut": inspectorSignature
    },
    // "client": {
    //   "checkIn": clientSignature,
    //   "checkOut": clientSignature
    // }
  };

  // Add signatures if provided
  if (inspectorSignature?.isValid == true) {
    baseData["inspector"]!["signature"] = inspectorSignature!.formattedSignatureData as SignatureModel?;
  }

  // if (clientSignature?.isValid == true) {
  //   baseData["client"]!["signature"] = clientSignature!.formattedSignatureData as SignatureModel?;
  // }

  return baseData;
}
