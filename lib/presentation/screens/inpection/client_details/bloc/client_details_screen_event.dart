part of 'client_details_screen_bloc.dart';

@immutable
sealed class ClientDetailsScreenEvent {}
class UpdateClientDetailsScreenEvent extends ClientDetailsScreenEvent {
  final ClientDetails carDetailsModel;

  UpdateClientDetailsScreenEvent({required this.carDetailsModel});
}

class UpdateClientLicenseEvent extends ClientDetailsScreenEvent {
  final bool isDriverLicense;

  UpdateClientLicenseEvent({required this.isDriverLicense});
}

class UpdateClientIdEvent extends ClientDetailsScreenEvent {
  final bool isDriverId;

  UpdateClientIdEvent({required this.isDriverId});
}

class ResetClientDetailsEvent extends ClientDetailsScreenEvent {}