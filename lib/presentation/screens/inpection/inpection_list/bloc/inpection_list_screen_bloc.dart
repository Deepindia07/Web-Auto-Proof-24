import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'inpection_list_screen_event.dart';
part 'inpection_list_screen_state.dart';

class InpectionListScreenBloc extends Bloc<InpectionListScreenEvent, InpectionListScreenState> {
  InpectionListScreenBloc() : super(InpectionListScreenInitial()) {
    on<InpectionListScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
