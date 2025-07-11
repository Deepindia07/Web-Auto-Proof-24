import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_screen_event.dart';
part 'forgot_screen_state.dart';

class ForgotScreenBloc extends Bloc<ForgotScreenEvent, ForgotScreenState> {
  ForgotScreenBloc() : super(ForgotScreenInitial()) {
    on<ForgotScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
