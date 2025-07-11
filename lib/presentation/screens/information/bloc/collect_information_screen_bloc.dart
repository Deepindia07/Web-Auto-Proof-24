import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'collect_information_screen_event.dart';
part 'collect_information_screen_state.dart';

class CollectInformationScreenBloc extends Bloc<CollectInformationScreenEvent, CollectInformationScreenState> {
  CollectInformationScreenBloc() : super(CollectInformationScreenInitial()) {
    on<CollectInformationScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
