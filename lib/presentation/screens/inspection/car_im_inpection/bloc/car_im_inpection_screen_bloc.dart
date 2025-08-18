import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'car_im_inpection_screen_event.dart';
part 'car_im_inpection_screen_state.dart';

class CarImInpectionScreenBloc extends Bloc<CarImInpectionScreenEvent, CarImInpectionScreenState> {
  CarImInpectionScreenBloc() : super(CarImInpectionScreenInitial()) {
    on<CarImInpectionScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
