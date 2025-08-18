import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'instruction_screen_event.dart';
part 'instruction_screen_state.dart';

class InstructionScreenBloc extends Bloc<InstructionScreenEvent, InstructionScreenState> {
  InstructionScreenBloc() : super(InstructionScreenInitial()) {
    on<InstructionScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
