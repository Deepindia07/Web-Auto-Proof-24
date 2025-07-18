import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'share_app_event.dart';
part 'share_app_state.dart';

class ShareAppBloc extends Bloc<ShareAppEvent, ShareAppState> {
  ShareAppBloc() : super(ShareAppInitial()) {
    on<ShareAppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
