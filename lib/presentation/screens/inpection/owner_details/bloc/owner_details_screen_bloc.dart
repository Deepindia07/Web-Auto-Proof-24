import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/owner_details_model.dart';

part 'owner_details_screen_event.dart';
part 'owner_details_screen_state.dart';

class OwnerDetailsScreenBloc extends Bloc<OwnerDetailsScreenEvent, OwnerDetailsScreenState> {
  OwnerDetailsScreenBloc() : super(OwnerDetailsScreenInitial()) {
    on<UpdateOwnerDetailsEvent>(_onUpdateOwnerDetails);
    on<UpdateDriverLicenseEvent>(_onUpdateDriverLicense);
    on<UpdateDriverIdEvent>(_onUpdateDriverId);
    on<ResetOwnerDetailsEvent>(_onResetOwnerDetails);
  }

  void _onUpdateOwnerDetails(UpdateOwnerDetailsEvent event, Emitter<OwnerDetailsScreenState> emit) {
    emit(OwnerDetailsScreenLoaded(ownerDetails: event.ownerDetails));
  }

  void _onUpdateDriverLicense(UpdateDriverLicenseEvent event, Emitter<OwnerDetailsScreenState> emit) {
    if (state is OwnerDetailsScreenLoaded) {
      final currentState = state as OwnerDetailsScreenLoaded;
      final updatedDetails = currentState.ownerDetails.copyWith(
        isDriverLicense: event.isDriverLicense,
      );
      emit(OwnerDetailsScreenLoaded(ownerDetails: updatedDetails));
    }
  }

  void _onUpdateDriverId(UpdateDriverIdEvent event, Emitter<OwnerDetailsScreenState> emit) {
    if (state is OwnerDetailsScreenLoaded) {
      final currentState = state as OwnerDetailsScreenLoaded;
      final updatedDetails = currentState.ownerDetails.copyWith(
        isDriverId: event.isDriverId,
      );
      emit(OwnerDetailsScreenLoaded(ownerDetails: updatedDetails));
    }
  }

  void _onResetOwnerDetails(ResetOwnerDetailsEvent event, Emitter<OwnerDetailsScreenState> emit) {
    emit(OwnerDetailsScreenInitial());
  }
}
