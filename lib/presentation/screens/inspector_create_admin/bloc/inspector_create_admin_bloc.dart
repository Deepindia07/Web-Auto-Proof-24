import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../auth/data/models/post_inspector_role_response_model.dart';

part 'inspector_create_admin_event.dart';
part 'inspector_create_admin_state.dart';

class InspectorCreateAdminBloc
    extends Bloc<InspectorCreateAdminEvent, InspectorCreateAdminState> {
  final AuthenticationApiCall apiRepository;

  InspectorCreateAdminBloc({required this.apiRepository})
    : super(InspectorCreateAdminInitial()) {
    on<CreateInspectorEvent>(_onCreateInspector);
    on<ResetInspectorCreateState>(_onResetState);
  }

  Future<void> _onCreateInspector(
    CreateInspectorEvent event,
    Emitter<InspectorCreateAdminState> emit,
  ) async {
    emit(InspectorCreateAdminLoading());

    try {

      // Make the API call
      final result = await apiRepository.postInspectorRoleApiCall(
        dataBody: Map<String, dynamic>.from(event.body),

        adminId: event.adminID,
      );

      if (result.isSuccess) {
        emit(InspectorCreateAdminSuccess(response: result.data));
      } else {
        (error) {
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
