part of 'client_details_screen_bloc.dart';

@immutable
sealed class ClientDetailsScreenState {}

final class ClientDetailsScreenInitial extends ClientDetailsScreenState {}

class ClientDetailsScreenLoaded extends ClientDetailsScreenState {
  final ClientDetails carOwnerDetails;

    ClientDetailsScreenLoaded({required this.carOwnerDetails});

  ClientDetailsScreenLoaded copyWith({ClientDetails? ownerDetails}) {
    return ClientDetailsScreenLoaded(
      carOwnerDetails: ownerDetails ?? carOwnerDetails,
    );
  }
}