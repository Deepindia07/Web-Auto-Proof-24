import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'client_details_screen_event.dart';
part 'client_details_screen_state.dart';

class ClientDetailsScreenBloc extends Bloc<ClientDetailsScreenEvent, ClientDetailsScreenState> {
  ClientDetailsScreenBloc() : super(ClientDetailsScreenInitial()) {
    on<ClientDetailsScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
