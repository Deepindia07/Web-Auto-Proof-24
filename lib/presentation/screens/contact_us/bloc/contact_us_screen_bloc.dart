import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'contact_us_screen_event.dart';
part 'contact_us_screen_state.dart';

class ContactUsScreenBloc extends Bloc<ContactUsScreenEvent, ContactUsScreenState> {
  ContactUsScreenBloc() : super(ContactUsScreenInitial()) {
    on<ContactUsScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
