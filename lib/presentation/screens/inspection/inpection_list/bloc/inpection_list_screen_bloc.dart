import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'inpection_list_screen_event.dart';
part 'inpection_list_screen_state.dart';

class InspectionListScreenBloc extends Bloc<InpectionListScreenEvent, InpectionListScreenState> {
  InspectionListScreenBloc() : super(InpectionListScreenInitial()) {
    on<InpectionListScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
