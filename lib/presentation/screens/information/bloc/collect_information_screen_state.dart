part of 'collect_information_screen_bloc.dart';

@immutable
abstract class CollectInformationScreenState {}

class CollectInformationScreenInitial extends CollectInformationScreenState {}

class CollectInformationScreenLoading extends CollectInformationScreenState {}

class CollectInformationScreenPersonalSuccess extends CollectInformationScreenState {
  final UserResponseModel userResponse;
  final String message;

  CollectInformationScreenPersonalSuccess({
    required this.userResponse,
    required this.message,
  });
}

class CollectInformationScreenCompanySuccess extends CollectInformationScreenState {
  final UserResponseModel userResponse;
  final String message;

  CollectInformationScreenCompanySuccess({
    required this.userResponse,
    required this.message,
  });
}

class CollectInformationScreenError extends CollectInformationScreenState {
  final String error;

  CollectInformationScreenError({required this.error});
}
