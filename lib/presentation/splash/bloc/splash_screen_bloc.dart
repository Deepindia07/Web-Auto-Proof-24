import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<SplashScreenStarted>(_onSplashScreenStarted);
  }

  Future<void> _onSplashScreenStarted(
      SplashScreenStarted event,
      Emitter<SplashScreenState> emit,
      ) async {
    emit(SplashScreenLoading());
    await Future.delayed(const Duration(seconds: 3));

    emit(SplashScreenCompleted());
  }
}