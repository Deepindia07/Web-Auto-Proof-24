import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_view_event.dart';
part 'otp_view_state.dart';

class OtpViewBloc extends Bloc<OtpViewEvent, OtpViewState> {
  OtpViewBloc() : super(OtpViewInitial()) {
    on<OtpViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
