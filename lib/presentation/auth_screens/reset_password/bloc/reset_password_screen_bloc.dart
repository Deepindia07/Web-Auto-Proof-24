import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reset_password_screen_event.dart';
part 'reset_password_screen_state.dart';

class ResetPasswordScreenBloc extends Bloc<ResetPasswordScreenEvent, ResetPasswordScreenState> {
  ResetPasswordScreenBloc() : super(ResetPasswordScreenInitial()) {
    on<ResetPasswordScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
