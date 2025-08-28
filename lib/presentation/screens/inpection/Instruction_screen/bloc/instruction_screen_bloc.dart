import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../auth/data/models/get_all_inpection_list_response_model.dart';

part 'instruction_screen_event.dart';
part 'instruction_screen_state.dart';

class InstructionScreenBloc extends Bloc<InstructionScreenEvent, InstructionScreenState> {
  final AuthenticationApiCall repository;

  InstructionScreenBloc({required this.repository}) : super(InstructionScreenInitial()) {
    on<FetchInspectionListEvent>(_onFetchInspectionList);
    on<SelectInspectionEvent>(_onSelectInspection);
  }

  Future<void> _onFetchInspectionList(
      FetchInspectionListEvent event,
      Emitter<InstructionScreenState> emit,
      ) async {
    emit(InstructionScreenLoading());
    try {
    /*  final result = await repository.getInspectionListApiCall();
      if(result.isSuccess){
        GetAllInspectionListResponseModel? getAllInspectionListResponseModel;

        if (getAllInspectionListResponseModel!.data.isNotEmpty == true){
          getAllInspectionListResponseModel.data;
        }
        emit(InstructionScreenLoaded(
          inspectionList: getAllInspectionListResponseModel,
        ));
      }else {
        emit(InstructionScreenError('Failed to fetch inspection list'));
      }*/
    }catch(e){
      emit(InstructionScreenError(e.toString()));
    }
  }

  void _onSelectInspection(
      SelectInspectionEvent event,
      Emitter<InstructionScreenState> emit,
      ) {
    final currentState = state;
    if (currentState is InstructionScreenLoaded) {
      emit(currentState.copyWith(selectedInspectionId: event.inspectionId));
    }
  }
}
