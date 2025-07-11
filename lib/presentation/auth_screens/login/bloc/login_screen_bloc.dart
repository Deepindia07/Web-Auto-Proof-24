import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/login_response_model.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final AuthenticationApiCall authRepository;

  LoginScreenBloc({required this.authRepository}) : super(LoginScreenInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginReset>(_onLoginReset);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<LoginScreenState> emit,
      ) async {
    emit(LoginLoading());

    final dataBody = {
      'email': event.emailOrPhone,
      'password': event.password,
    };
    print("${dataBody}");
    final resultResponse = await authRepository.loginApiCall(dataBody: dataBody);
    if (resultResponse.isSuccess) {
      emit(LoginSuccess(loginResponse: resultResponse.data));
    } else {
      emit(LoginFailure(error: resultResponse.error));
      print("${resultResponse.error}");
    }
  }

  void _onLoginReset(LoginReset event, Emitter<LoginScreenState> emit,) {
    emit(LoginScreenInitial());
  }
}
