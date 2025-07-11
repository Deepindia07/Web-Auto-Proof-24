import 'package:auto_proof/auth/server/logger/app_logger.dart';
import 'package:bloc/bloc.dart';

class AppServiceBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object?event){
    super.onEvent(bloc, event);
    appLogger.i('[EVENT] ${bloc.runtimeType} => $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition){
    super.onTransition(bloc, transition);
    appLogger.i('[TRANSITION] ${bloc.runtimeType} => $transition');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change){
    super.onChange(bloc, change);
    appLogger.i('[TRANSITION] ${bloc.runtimeType} => $change');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    appLogger.e('[ERROR] ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}