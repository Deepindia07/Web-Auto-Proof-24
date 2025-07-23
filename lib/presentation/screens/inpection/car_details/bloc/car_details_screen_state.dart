part of 'car_details_screen_bloc.dart';

@immutable
abstract class CarDetailsScreenState {}

class CarDetailsScreenInitial extends CarDetailsScreenState {}

class CarDetailsScreenLoading extends CarDetailsScreenState {}

class CarDetailsScreenLoaded extends CarDetailsScreenState {
  final CarDetailsModel carDetails;

  CarDetailsScreenLoaded({required this.carDetails});
}

class CarDetailsScreenError extends CarDetailsScreenState {
  final String message;

  CarDetailsScreenError({required this.message});
}

class CarDetailsScreenValidationError extends CarDetailsScreenState {
  final List<String> errors;

  CarDetailsScreenValidationError({required this.errors});
}

class CarDetailsScreenSuccess extends CarDetailsScreenState {
  final CarDetailsModel carDetails;

  CarDetailsScreenSuccess({required this.carDetails});
}
