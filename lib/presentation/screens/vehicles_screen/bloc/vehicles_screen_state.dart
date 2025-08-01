part of 'vehicles_screen_bloc.dart';

@immutable
abstract class VehiclesScreenState {}

class VehiclesScreenInitial extends VehiclesScreenState {}

class VehiclesScreenLoading extends VehiclesScreenState {}

class VehiclesScreenLoaded extends VehiclesScreenState {
  final List<Vehicle> vehicles;

  VehiclesScreenLoaded({required this.vehicles});
}

class VehiclesScreenError extends VehiclesScreenState {
  final String errorMessage;

  VehiclesScreenError({required this.errorMessage});
}