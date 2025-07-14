import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'team_screen_event.dart';
part 'team_screen_state.dart';

class TeamScreenBloc extends Bloc<TeamScreenEvent, TeamScreenState> {
  TeamScreenBloc() : super(TeamScreenInitial()) {
    on<TeamScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
