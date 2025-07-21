part of 'home_screen_bloc.dart';

@immutable
sealed class HomeScreenEvent {}

class GetProfileEvent extends HomeScreenEvent {
  final String? userId;
  final Map<String, dynamic>? dataBody;

  GetProfileEvent({
    required this.userId,
    this.dataBody,
  });
}

class UpdateProfileImageEvent extends HomeScreenEvent {
  final FormData multipartBody;
  final String userId;
  final Map<String, dynamic> profileDataBody;

  UpdateProfileImageEvent({
    required this.multipartBody,
    required this.userId,
    required this.profileDataBody,
  });
}
