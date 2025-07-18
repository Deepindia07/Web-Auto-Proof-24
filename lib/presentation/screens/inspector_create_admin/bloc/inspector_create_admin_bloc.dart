import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'inspector_create_admin_event.dart';
part 'inspector_create_admin_state.dart';

class InspectorCreateAdminBloc extends Bloc<InspectorCreateAdminEvent, InspectorCreateAdminState> {
  InspectorCreateAdminBloc() : super(InspectorCreateAdminInitial()) {
    on<InspectorCreateAdminEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
