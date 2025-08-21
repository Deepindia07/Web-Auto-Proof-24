part of 'owner_details_screen_bloc.dart';

@immutable
abstract class OwnerDetailsScreenEvent {}

class UpdateOwnerDetailsEvent extends OwnerDetailsScreenEvent {
  final OwnerDetailsModel ownerDetails;

  UpdateOwnerDetailsEvent({required this.ownerDetails});
}

class UpdateDriverLicenseEvent extends OwnerDetailsScreenEvent {
  final bool isDriverLicense;

  UpdateDriverLicenseEvent({required this.isDriverLicense});
}

class UpdateDriverIdEvent extends OwnerDetailsScreenEvent {
  final bool isDriverId;

  UpdateDriverIdEvent({required this.isDriverId});
}

class ResetOwnerDetailsEvent extends OwnerDetailsScreenEvent {}
