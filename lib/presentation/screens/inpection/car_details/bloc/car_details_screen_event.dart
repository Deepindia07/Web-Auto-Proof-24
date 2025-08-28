part of 'car_details_screen_bloc.dart';

@immutable
abstract class CarDetailsScreenEvent {}

class UpdateCarDetailsEvent extends CarDetailsScreenEvent {
  final CarDetails carDetails;

  UpdateCarDetailsEvent({required this.carDetails});
}

class SaveCarDetailsEvent extends CarDetailsScreenEvent {
  final CarDetails carDetails;

  SaveCarDetailsEvent({required this.carDetails});
}

class ValidateFormEvent extends CarDetailsScreenEvent {
  final CarDetails carDetails;

  ValidateFormEvent({required this.carDetails});
}