import '../enum/inspection_enum.dart';

class InspectionModel {
  final String id;
  final String plate;
  final String date;
  final String name;
  final InspectionStatus status;

  const InspectionModel({
    required this.id,
    required this.plate,
    required this.date,
    required this.name,
    required this.status,
  });
}