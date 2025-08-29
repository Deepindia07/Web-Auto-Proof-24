import 'dart:async';

import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../models/get_single_vehicle_model.dart';
import '../models/get_vehicle_model.dart';

part 'vehicles_screen_event.dart';
part 'vehicles_screen_state.dart';

class VehiclesScreenBloc
    extends Bloc<VehiclesScreenEvent, VehiclesScreenState> {
  final AuthenticationApiCall vehicleRepository;

  VehiclesScreenBloc({required this.vehicleRepository})
    : super(VehiclesScreenInitial()) {
    on<LoadVehiclesEvent>(_onLoadVehicles);
    on<RefreshVehiclesEvent>(_onRefreshVehicles);
    on<SingleVehiclesEvent>(_onSingleVehiclesEvent);
  }

  Future<void> _onLoadVehicles(
    LoadVehiclesEvent event,
    Emitter<VehiclesScreenState> emit,
  ) async {
    emit(VehiclesScreenLoading());

    try {
      final result = await vehicleRepository.vehicleListApiCall();

      if (result.isSuccess) {
        final vehicles = result.data;
        emit(VehiclesScreenLoaded(getVehicleModel: vehicles));
      } else {
        emit(VehiclesScreenError(errorMessage: result.error));
      }
    } catch (error) {
      emit(
        VehiclesScreenError(errorMessage: 'Failed to load vehicles: $error'),
      );
    }
  }

  Future<void> _onRefreshVehicles(
    RefreshVehiclesEvent event,
    Emitter<VehiclesScreenState> emit,
  ) async {
    try {
      final result = await vehicleRepository.vehicleListApiCall();

      if (result.isSuccess) {
        final vehicles = result.data;
        emit(VehiclesScreenLoaded(getVehicleModel: vehicles));
      } else {
        emit(VehiclesScreenError(errorMessage: result.error));
      }
    } catch (error) {
      emit(
        VehiclesScreenError(errorMessage: 'Failed to refresh vehicles: $error'),
      );
    }
  }

  Future<void> _onSingleVehiclesEvent(
    SingleVehiclesEvent event,
    Emitter<VehiclesScreenState> emit,
  ) async {
    emit(SingleVehiclesScreenLoading());
    final result = await vehicleRepository.getDetailsVehicleListApiCall(id:event.vehicleId);

    try {
      if (result.isSuccess) {
        final getSingleVehicleModel = result.data;
        emit(
          SingleVehiclesScreenLoaded(
            getSingleVehicleModel: getSingleVehicleModel,
          ),
        );
      } else {
        emit(SingleVehiclesScreenError(errorMessage: result.error));
      }
    } catch (e, s) {
      emit(VehiclesScreenError(errorMessage: 'Failed to refresh vehicles: $e'));
    }
  }
}
