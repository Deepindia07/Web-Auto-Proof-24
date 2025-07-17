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