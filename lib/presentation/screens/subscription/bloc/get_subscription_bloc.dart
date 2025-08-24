import 'dart:async';
import 'dart:developer';
import 'package:auto_proof/presentation/screens/subscription/models/get_subscription_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../auth/server/network/auth_network_imple_service.dart';
part 'get_subscription_event.dart';
part 'get_subscription_state.dart';

class GetSubscriptionBloc
    extends Bloc<GetSubscriptionEvent, GetSubscriptionState> {
  final AuthenticationApiCall authenticationApiCall;
  GetSubscriptionBloc(this.authenticationApiCall,  )
    : super(GetSubscriptionInitial()) {
    on<GetSubscriptionApiEvent>(_onGetSubscriptionApiEvent);
  }

  Future<void> _onGetSubscriptionApiEvent(
    GetSubscriptionApiEvent event,
    Emitter<GetSubscriptionState> emit,
  ) async {
    emit(GetSubscriptionLoading());

    try {
      final result = await authenticationApiCall.getSubscriptionApiCall();
      if (result.isSuccess) {
        final getSubscriptionPlanModel = result.data;
        emit(
          GetSubscriptionSuccess(
            getSubscriptionPlanModel: getSubscriptionPlanModel,
          ),
        );
      } else {
        emit(GetSubscriptionError(error: result.error));
      }
    } catch (e, s) {
      log("Personal update error :$e");
      emit(GetSubscriptionError(error: "Failed to update personal information: $e"));
    }
  }
}

//       if (result.isSuccess) {
//         emit(PersonalInformationSuccess());
//       } else {
//         emit(PersonalInformationError(error: result.error));
//       }
//     } catch (e) {
//       log("Personal update error: $e");
//       emit(
//         PersonalInformationError(
//           error: "Failed to update personal information: $e",
//         ),
//       );
//     }
//   }
