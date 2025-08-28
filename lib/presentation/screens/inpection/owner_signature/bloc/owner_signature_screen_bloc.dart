import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'owner_signature_screen_event.dart';
part 'owner_signature_screen_state.dart';

class OwnerSignatureScreenBloc extends Bloc<OwnerSignatureScreenEvent, OwnerSignatureScreenState> {
  OwnerSignatureScreenBloc() : super(OwnerSignatureScreenInitial()) {
    on<OwnerSignatureScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
