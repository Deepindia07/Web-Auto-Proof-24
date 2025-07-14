import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vehicles_screen_event.dart';
part 'vehicles_screen_state.dart';

class VehiclesScreenBloc extends Bloc<VehiclesScreenEvent, VehiclesScreenState> {
  VehiclesScreenBloc() : super(VehiclesScreenInitial()) {
    on<VehiclesScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
