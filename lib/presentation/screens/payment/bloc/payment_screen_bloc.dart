import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_screen_event.dart';
part 'payment_screen_state.dart';

class PaymentScreenBloc extends Bloc<PaymentScreenEvent, PaymentScreenState> {
  PaymentScreenBloc() : super(PaymentScreenInitial()) {
    on<PaymentScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
