part of 'vehicles_screen_bloc.dart';

abstract class VehiclesScreenEvent extends Equatable{}

class LoadVehiclesEvent extends VehiclesScreenEvent {
  @override

  List<Object?> get props => [];
}

class RefreshVehiclesEvent extends VehiclesScreenEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class SingleVehiclesEvent extends VehiclesScreenEvent {
  final String vehicleId;

  SingleVehiclesEvent({required this.vehicleId});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}