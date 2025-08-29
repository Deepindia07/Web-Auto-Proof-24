part of 'vehicles_screen_bloc.dart';

@immutable
abstract class VehiclesScreenState {}

class VehiclesScreenInitial extends VehiclesScreenState {}

class VehiclesScreenLoading extends VehiclesScreenState {}

class VehiclesScreenLoaded extends VehiclesScreenState {
  final GetVehicleModel getVehicleModel;

  VehiclesScreenLoaded({required this.getVehicleModel});
}

class VehiclesScreenError extends VehiclesScreenState {
  final String errorMessage;

  VehiclesScreenError({required this.errorMessage});
}

///-------
class SingleVehiclesScreenLoading extends VehiclesScreenState {}

class SingleVehiclesScreenLoaded extends VehiclesScreenState {
  final GetSingleVehicleModel getSingleVehicleModel;

  SingleVehiclesScreenLoaded({required this.getSingleVehicleModel});
}

class SingleVehiclesScreenError extends VehiclesScreenState {
  final String errorMessage;

  SingleVehiclesScreenError({required this.errorMessage});
}