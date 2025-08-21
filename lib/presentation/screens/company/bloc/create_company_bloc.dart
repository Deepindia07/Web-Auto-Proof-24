import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../auth/server/network/auth_network_imple_service.dart';
import '../models/get_company_model.dart';
part 'create_company_event.dart';
part 'create_company_state.dart';

class CreateCompanyBloc extends Bloc<CreateCompanyEvent, CreateCompanyState> {
  final AuthenticationApiCall apiRepository;
  CreateCompanyBloc({required this.apiRepository})
    : super(CreateCompanyInitial()) {
    on<CreateCompanyApiEvent>(_onCreateCompanyApiEvent);
    on<GetCompanyApiEvent>(_onGetCompanyApiEvent);
    on<UpdateCompanyApiEvent>(_onUpdateCompanyApiEvent);
  }

  Future<void> _onCreateCompanyApiEvent(
    CreateCompanyApiEvent event,
    Emitter<CreateCompanyState> emit,
  ) async {
    emit(CreateCompanyLoading());
    try {
      final result = await apiRepository.createCompanyApiCall(
        dataBody: event.body,
      );
      if (result.isSuccess) {
        emit(CreateCompanySuccess());
      } else {
        emit(CreateCompanyError(error: result.error));
      }
    } catch (e) {
      emit(CreateCompanyError(error: e.toString()));
    }
  }

  Future<void> _onGetCompanyApiEvent(
    GetCompanyApiEvent event,
    Emitter<CreateCompanyState> emit,
  ) async {
    emit(GetCompanyLoading());
    try {
      final result = await apiRepository.getCompanyApiCall();

      if (result.isSuccess) {
        final getCompanyModel = result.data;
        emit(GetCompanySuccess(getCompanyModel: getCompanyModel));
      } else {
        emit(GetCompanyError(error: result.error));
      }
    } catch (e) {
      emit(GetCompanyError(error: e.toString()));
    }
  }

  Future<void> _onUpdateCompanyApiEvent(
    UpdateCompanyApiEvent event,
    Emitter<CreateCompanyState> emit,
  ) async {
    emit(UpdateCompanyLoading());
    try {
      final result = await apiRepository.updateCompanyApi();
      if (result.isSuccess) {
        final updateModel = result.data;
        print("updateModel----_$updateModel");
        emit(UpdateCompanySuccess());
      } else {
        emit(UpdateCompanyError(error: result.error));
      }
    } catch (e) {
      emit(UpdateCompanyError(error: e.toString()));
    }
  }
}
