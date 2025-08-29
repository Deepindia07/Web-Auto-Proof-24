part of 'owner_details_screen_bloc.dart';

@immutable
abstract class OwnerDetailsScreenState {}

class OwnerDetailsScreenInitial extends OwnerDetailsScreenState {}

class OwnerDetailsScreenLoaded extends OwnerDetailsScreenState {
  final OwnerDetails carOwnerDetails;

  OwnerDetailsScreenLoaded({required this.carOwnerDetails});

  OwnerDetailsScreenLoaded copyWith({OwnerDetails? ownerDetails}) {
    return OwnerDetailsScreenLoaded(
      carOwnerDetails: ownerDetails ?? this.carOwnerDetails,
    );
  }
}
class OnSubmittingAgentLoading extends OwnerDetailsScreenState {}
class OnSubmittingAgentLoaded extends OwnerDetailsScreenState {
  final dynamic response;

  OnSubmittingAgentLoaded({required this.response});
}

class OnSubmittingAgentLoadedError extends OwnerDetailsScreenState {
  final String message;

  OnSubmittingAgentLoadedError({required this.message});
}

class OnSubmittingAgentLoadedSuccess extends OwnerDetailsScreenState {
  final String message;
  OnSubmittingAgentLoadedSuccess({required this.message});
}