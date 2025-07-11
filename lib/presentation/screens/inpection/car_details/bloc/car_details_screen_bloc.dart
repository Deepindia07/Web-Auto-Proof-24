import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'car_details_screen_event.dart';
part 'car_details_screen_state.dart';

class CarDetailsScreenBloc extends Bloc<CarDetailsScreenEvent, CarDetailsScreenState> {
  CarDetailsScreenBloc() : super(CarDetailsScreenInitial()) {
    on<CarDetailsScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
