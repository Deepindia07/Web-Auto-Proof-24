import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'reports_screen_event.dart';
part 'reports_screen_state.dart';

class ReportsScreenBloc extends Bloc<ReportsScreenEvent, ReportsScreenState> {
  ReportsScreenBloc() : super(ReportsScreenInitial()) {
    on<ReportsScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
