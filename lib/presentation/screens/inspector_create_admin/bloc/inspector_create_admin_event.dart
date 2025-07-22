part of 'inspector_create_admin_bloc.dart';

@immutable
abstract class InspectorCreateAdminEvent {}

class CreateInspectorEvent extends InspectorCreateAdminEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String countryCode;
  final String gender;
  final String address;
  final String adminId;
  final String companyId;

  CreateInspectorEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.countryCode,
    required this.gender,
    required this.address,
    required this.adminId,
    required this.companyId
  });
}

class ResetInspectorCreateState extends InspectorCreateAdminEvent {}