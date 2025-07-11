import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notification_screen_event.dart';
part 'notification_screen_state.dart';

class NotificationScreenBloc extends Bloc<NotificationScreenEvent, NotificationScreenState> {
  NotificationScreenBloc() : super(NotificationScreenInitial()) {
    on<NotificationScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
