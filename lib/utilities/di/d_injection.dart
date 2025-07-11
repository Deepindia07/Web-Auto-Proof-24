part of 'di_injection_route_imple.dart';

final sl = GetIt.instance;

Future<void> init ()async {
  sl.registerLazySingleton<AuthenticationApiCall>(()=>AuthenticationApiCall());
  sl.registerLazySingleton<SplashScreenBloc>(()=> SplashScreenBloc());
  sl.registerLazySingleton<LoginScreenBloc>(()=> LoginScreenBloc(authRepository: AuthenticationApiCall()));
}