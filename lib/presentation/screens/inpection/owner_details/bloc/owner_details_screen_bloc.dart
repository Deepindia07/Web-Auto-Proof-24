import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'owner_details_screen_event.dart';
part 'owner_details_screen_state.dart';

class OwnerDetailsScreenBloc extends Bloc<OwnerDetailsScreenEvent, OwnerDetailsScreenState> {
  OwnerDetailsScreenBloc() : super(OwnerDetailsScreenInitial()) {
    on<OwnerDetailsScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
