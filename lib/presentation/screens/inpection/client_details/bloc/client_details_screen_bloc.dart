import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../car_details/model/car_details_model.dart';

part 'client_details_screen_event.dart';
part 'client_details_screen_state.dart';

class ClientDetailsScreenBloc extends Bloc<ClientDetailsScreenEvent, ClientDetailsScreenState> {
  late ClientDetails _currentCarDetails = ClientDetails();
  ClientDetailsScreenBloc() : super(ClientDetailsScreenInitial()) {
    on<UpdateClientDetailsScreenEvent>(_onUpdateClientDetails);
    on<ResetClientDetailsEvent>(_onResetClientDetails);
  }

  void _onUpdateClientDetails(UpdateClientDetailsScreenEvent event, Emitter<ClientDetailsScreenState> emit) {
    _currentCarDetails = event.carDetailsModel;
    emit(ClientDetailsScreenLoaded(carOwnerDetails: event.carDetailsModel));
  }
  ClientDetails getCurrentCarDetails() {
    return _currentCarDetails;
  }

  void _onResetClientDetails(ResetClientDetailsEvent event, Emitter<ClientDetailsScreenState> emit) {
    emit(ClientDetailsScreenInitial());
  }
}
