import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'onboard_screen_event.dart';
part 'onboard_screen_state.dart';

class OnboardScreenBloc extends Bloc<OnboardScreenEvent, OnboardScreenState> {
  OnboardScreenBloc() : super(OnboardScreenInitial()) {
    on<OnboardScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
