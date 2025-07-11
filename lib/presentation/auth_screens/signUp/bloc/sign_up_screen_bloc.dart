import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/registeration_response_model.dart';

part 'sign_up_screen_event.dart';
part 'sign_up_screen_state.dart';

class SignUpScreenBloc extends Bloc<SignUpScreenEvent, SignUpScreenState> {
  final AuthenticationApiCall apiRepository;

  SignUpScreenBloc({required this.apiRepository}) : super(SignUpScreenInitial()) {
    on<RegisterUser>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
      RegisterUser event,
      Emitter<SignUpScreenState> emit,
      ) async {
    emit(SignUpScreenLoading());

    try {
      final Map<String, dynamic> dataBody = {
        "firstName": event.firstName,
        "lastName": event.lastName,
        "email": event.email,
        "countryCode": event.countryCode,
        "phoneNumber": event.phoneNumber,
        "password": event.password,
        "isEmailVerified": event.isEmailVerified,
        "termsAndConditions": event.termsAndConditions,
      };

      final result = await apiRepository.registerApiCall(dataBody: dataBody);

      if(result.isSuccess){
        emit(SignUpScreenSuccess(result.data));
      }else{
        emit(SignUpScreenError(result.error));
      }
    } catch (error) {
      emit(SignUpScreenError('An unexpected error occurred: $error'));
    }
  }
}
