class SignatureClientModels {
  final String? signatureImagePath;
  final String? signatureBase64;

  const SignatureClientModels({
    this.signatureImagePath,
    this.signatureBase64,
  });

  SignatureClientModels copyWith({
    String? signatureImagePath,
    String? signatureBase64,
  }) {
    return SignatureClientModels(
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

  factory SignatureClientModels.fromJson(Map<String, dynamic> json) {
    return SignatureClientModels(
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

  @override
  String toString() {
    return 'SignatureClientModels(signatureImagePath: $signatureImagePath, signatureBase64: ${signatureBase64?.substring(0, 50)}...)';
  }
}

/// Send signature image data for API submission
Future<Map<String, dynamic>> fetchClientSignatureDataFromAnySource({
  SignatureClientModels? clientSignature,
}) async {
  final baseData = {
    "checkIn": clientSignature?.signatureBase64,
    "checkOut": null // Will be filled during checkout
  };

  return baseData;
}