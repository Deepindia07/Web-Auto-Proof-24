import 'dart:ui';

import '../../owner_signature/datasource/model.dart';

class CarAddingModel {
  final String title;
  final String image;
  final String inspectionId;
  final VoidCallback onTap;

  CarAddingModel({
    required this.title,
    required this.image,
    required this.inspectionId,
    required this.onTap,
  });

  static CarAddingModel empty() {
    return CarAddingModel(
      title: '',
      image: '',
      inspectionId: '',
      onTap: () {},
    );
  }
}

/// Updated method to handle both loading and saving selected data
Future<Map<String, dynamic>> fetchCarImagesDataFromAnySource({
  Map<String, String?>? beforeImages,
  Map<String, String?>? afterImages,
}) async {
  if (beforeImages != null && afterImages != null) {
    print("Saving before images to storage... $beforeImages");
    print("Saving after images to storage... $afterImages");
  }
  final OwnderSignatureData = fetchOwnerSignatureDataFromAnySource();
  // final clientSignatureData = fet();
  return {
    "photos":{
      "front_side": {
      "before": beforeImages?["front_side"],
      "after": afterImages?["front_side"]
    },
      "front_left_wheel": {
        "before": beforeImages?["front_left_wheel"],
        "after": afterImages?["front_left_wheel"]
      },
      "front_left_side": {
        "before": beforeImages?["front_left_side"],
        "after": afterImages?["front_left_side"]
      },
      "rear_left_side": {
        "before": beforeImages?["rear_left_side"],
        "after": afterImages?["rear_left_side"]
      },
      "rear_left_wheel": {
        "before": beforeImages?["rear_left_wheel"],
        "after": afterImages?["rear_left_wheel"]
      },
      "rear_side": {
        "before": beforeImages?["rear_side"],
        "after": afterImages?["rear_side"]
      },
      "back_right_wheel": {
        "before": beforeImages?["back_right_wheel"],
        "after": afterImages?["back_right_wheel"]
      },
      "rear_right_side": {
        "before": beforeImages?["rear_right_side"],
        "after": afterImages?["rear_right_side"]
      },
      "front_right_side": {
        "before": beforeImages?["front_right_side"],
        "after": afterImages?["front_right_side"]
      },
      "front_right_wheel": {
        "before": beforeImages?["front_right_wheel"],
        "after": afterImages?["front_right_wheel"]
      },
      "front_seats": {
        "before": beforeImages?["front_seats"],
        "after": afterImages?["front_seats"]
      },
      "rear_seats": {
        "before": beforeImages?["rear_seats"],
        "after": afterImages?["rear_seats"]
      },
      "odometer": {
        "before": beforeImages?["odometer"],
        "after": afterImages?["odometer"]
      },
    },
    "optionalPhotos":{
      "optional_1": {
      "before": beforeImages?["optional_1"],
      "after": afterImages?["optional_1"]
    },
      "optional_2": {
        "before": beforeImages?["optional_2"],
        "after": afterImages?["optional_2"]
      },
      "optional_3": {
        "before": beforeImages?["optional_3"],
        "after": afterImages?["optional_3"]
      },
    },
    "signatures": {
      "inspector": {
        "checkIn": OwnderSignatureData,
        "checkOut": OwnderSignatureData
      },
      "client": {
        // "checkIn": clientSignature,
        // "checkOut": clientSignature
      }
    }
  };
}
