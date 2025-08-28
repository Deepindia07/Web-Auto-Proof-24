part of 'owner_details_screen_bloc.dart';

@immutable
abstract class OwnerDetailsScreenEvent {}

class UpdateOwnerDetailsEvent extends OwnerDetailsScreenEvent {
  final OwnerDetails carDetailsModel;

  UpdateOwnerDetailsEvent({required this.carDetailsModel});
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

class OnSubmittingAgentDataEvent extends OwnerDetailsScreenEvent{
  final CarDetails? carDetails;
  final OwnerDetails? ownerDetails;
  final String? inspectorId;
  // ClientDetails? clientDetails;
  // Map<String, Map<String, String>>? carImages; // from car image step
  // Map<String, String>? clientSignature;
  // Map<String, String>? ownerSignature;

  OnSubmittingAgentDataEvent( {
    this.carDetails,
    this.ownerDetails,this.inspectorId,
    // this.clientDetails,
    // this.carImages,
    // this.clientSignature,
    // this.ownerSignature,
  });
}