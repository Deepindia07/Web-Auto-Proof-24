import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'client_signature_screen_event.dart';
part 'client_signature_screen_state.dart';

class ClientSignatureScreenBloc extends Bloc<ClientSignatureScreenEvent, ClientSignatureScreenState> {
  ClientSignatureScreenBloc() : super(ClientSignatureScreenInitial()) {
    on<ClientSignatureScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
