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