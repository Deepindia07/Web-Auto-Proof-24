part of 'car_details_screen_bloc.dart';

@immutable
abstract class CarDetailsScreenEvent {}

class UpdateCarDetailsEvent extends CarDetailsScreenEvent {
  final CarDetailsModel carDetails;

  UpdateCarDetailsEvent({required this.carDetails});
}

class SaveCarDetailsEvent extends CarDetailsScreenEvent {
  final CarDetailsModel carDetails;

  SaveCarDetailsEvent({required this.carDetails});
}

class ValidateFormEvent extends CarDetailsScreenEvent {
  final CarDetailsModel carDetails;

  ValidateFormEvent({required this.carDetails});
}