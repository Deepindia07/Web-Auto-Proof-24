import 'dart:ui';

class CarAddingModel {
  final String image;
  final String title;
  final VoidCallback? onTap;

  const CarAddingModel({
    required this.title,
    required this.image,
    required this.onTap,
  });
}
