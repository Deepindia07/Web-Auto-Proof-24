part of 'vehicles_screen_bloc.dart';

@immutable
abstract class VehiclesScreenEvent {}

class LoadVehiclesEvent extends VehiclesScreenEvent {}

class RefreshVehiclesEvent extends VehiclesScreenEvent {}