part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenState {}

class HomeScreenInitial extends HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenProfileLoaded extends HomeScreenState {
  final UserResponseModel userProfile;

  HomeScreenProfileLoaded({required this.userProfile});
}

class HomeScreenError extends HomeScreenState {
  final String message;

  HomeScreenError({required this.message});
}

class HomeScreenProfileImageUpdating extends HomeScreenState {}

class HomeScreenProfileImageUpdated extends HomeScreenState {
  final String message;
  final UserResponseModel userProfile;

  HomeScreenProfileImageUpdated({
    required this.message,
    required this.userProfile,
  });
}

class HomeScreenProfileImageUpdateError extends HomeScreenState {
  final String message;

  HomeScreenProfileImageUpdateError({required this.message});
}
