import 'dart:io';

import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/post_inspector_role_response_model.dart';

part 'inspector_create_admin_event.dart';
part 'inspector_create_admin_state.dart';


class InspectorCreateAdminBloc extends Bloc<InspectorCreateAdminEvent, InspectorCreateAdminState> {
  final AuthenticationApiCall apiRepository;

  InspectorCreateAdminBloc({required this.apiRepository}) : super(InspectorCreateAdminInitial()) {
    on<CreateInspectorEvent>(_onCreateInspector);
    on<ResetInspectorCreateState>(_onResetState);
  }

  Future<void> _onCreateInspector(
      CreateInspectorEvent event,
      Emitter<InspectorCreateAdminState> emit,
      ) async {
    emit(InspectorCreateAdminLoading());

    try {
      final dataBody = {
        'firstName': event.firstName,
        'lastName': event.lastName,
        'email': event.email,
        'phoneNumber': event.phoneNumber,
        'countryCode': event.countryCode,
        'gender': event.gender.toUpperCase(),
        'address': event.address,
        'companyId':event.companyId
      };
      print("databody inspector=> ${dataBody}");
      // Make the API call
      final result = await apiRepository.postInspectorRoleApiCall(
        dataBody: dataBody,
        adminId: event.adminId,
      );

      if(result.isSuccess){
        emit(InspectorCreateAdminSuccess(response: result.data));
      } else {
        (error){
        emit(InspectorCreateAdminError(error: error));
      };
      }
    } catch (e) {
      emit(InspectorCreateAdminError(error: 'Unexpected error: $e'));
    }
  }

  void _onResetState(
      ResetInspectorCreateState event,
      Emitter<InspectorCreateAdminState> emit,
      ) {
    emit(InspectorCreateAdminInitial());
  }
}
