import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/contact_us_response_model.dart';

part 'contact_us_screen_event.dart';
part 'contact_us_screen_state.dart';

class ContactUsScreenBloc extends Bloc<ContactUsScreenEvent, ContactUsScreenState> {
  final AuthenticationApiCall apiRepository;

  ContactUsScreenBloc({required this.apiRepository}) : super(ContactUsScreenInitial()) {
    on<SubmitContactUsEvent>(_onSubmitContactUs);
  }

  Future<void> _onSubmitContactUs(
      SubmitContactUsEvent event,
      Emitter<ContactUsScreenState> emit,
      ) async {
    emit(ContactUsScreenLoading());

    try {
      final Map<String, dynamic> dataBody = {
        "subject": event.subject,
        "message": event.message,
      };
      final result = await apiRepository.contactUsApiCall(dataBody: dataBody);

      // result.when(
      //   success: (response) {
      //     emit(ContactUsScreenSuccess(response: response));
      //   },
      //   failure: (error) {
      //     emit(ContactUsScreenError(errorMessage: error));
      //   },
      // );
    } catch (error) {
      emit(ContactUsScreenError(errorMessage: 'Unexpected error occurred: $error'));
    }
  }
}
