part of 'owner_details_screen_bloc.dart';

@immutable
abstract class OwnerDetailsScreenState {}

class OwnerDetailsScreenInitial extends OwnerDetailsScreenState {}

class OwnerDetailsScreenLoaded extends OwnerDetailsScreenState {
  final OwnerDetailsModel ownerDetails;

  OwnerDetailsScreenLoaded({required this.ownerDetails});

  OwnerDetailsScreenLoaded copyWith({OwnerDetailsModel? ownerDetails}) {
    return OwnerDetailsScreenLoaded(
      ownerDetails: ownerDetails ?? this.ownerDetails,
    );
  }
}
