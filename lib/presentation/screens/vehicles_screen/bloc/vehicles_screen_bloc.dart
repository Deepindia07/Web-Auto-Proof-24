import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/vehicle_list_response_model.dart';

part 'vehicles_screen_event.dart';
part 'vehicles_screen_state.dart';

class VehiclesScreenBloc extends Bloc<VehiclesScreenEvent, VehiclesScreenState> {
  final AuthenticationApiCall vehicleRepository;

  VehiclesScreenBloc({required this.vehicleRepository}) : super(VehiclesScreenInitial()) {
    on<LoadVehiclesEvent>(_onLoadVehicles);
    on<RefreshVehiclesEvent>(_onRefreshVehicles);
  }

  Future<void> _onLoadVehicles(
      LoadVehiclesEvent event,
      Emitter<VehiclesScreenState> emit,
      ) async {
    emit(VehiclesScreenLoading());

    try {
      final result = await vehicleRepository.vehicleListApiCall();

      if(result.isSuccess){
        final vehicles = result.data.vehicles ?? [];
        emit(VehiclesScreenLoaded(vehicles: vehicles));
      }else{
        emit(VehiclesScreenError(errorMessage: result.error));
      }
    } catch (error) {
      emit(VehiclesScreenError(errorMessage: 'Failed to load vehicles: $error'));
    }
  }

  Future<void> _onRefreshVehicles(
      RefreshVehiclesEvent event,
      Emitter<VehiclesScreenState> emit,
      ) async {
    try {
      final result = await vehicleRepository.vehicleListApiCall();

      if(result.isSuccess){
        final vehicles = result.data.vehicles ?? [];
        emit(VehiclesScreenLoaded(vehicles: vehicles));
      }else{
        emit(VehiclesScreenError(errorMessage: result.error));
      }
    } catch (error) {
      emit(VehiclesScreenError(errorMessage: 'Failed to refresh vehicles: $error'));
    }
  }
}
