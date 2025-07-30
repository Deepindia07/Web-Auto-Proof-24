part of 'di_injection_route_imple.dart';

final sl = GetIt.instance;
final userRole = SharedPrefsHelper.instance.getString(roleKey);

Future<void> init ()async {
  sl.registerLazySingleton<AuthenticationApiCall>(()=>AuthenticationApiCall());
  sl.registerLazySingleton<SplashScreenBloc>(()=> SplashScreenBloc());
  sl.registerLazySingleton<LoginScreenBloc>(()=> LoginScreenBloc(authRepository: AuthenticationApiCall(), userRole: roleKey));
  sl.registerLazySingleton<ForgotScreenBloc>(()=> ForgotScreenBloc(apiRepository: AuthenticationApiCall()));
  sl.registerLazySingleton<ResetPasswordScreenBloc>(()=> ResetPasswordScreenBloc(repository: AuthenticationApiCall()));
  sl.registerLazySingleton<OtpViewBloc>(()=> OtpViewBloc(apiService: AuthenticationApiCall()));
  sl.registerLazySingleton<HomeScreenBloc>(()=> HomeScreenBloc(authenticationApiCall: AuthenticationApiCall()));
  sl.registerLazySingleton<CollectInformationScreenBloc>(()=> CollectInformationScreenBloc(authenticationApiCall: AuthenticationApiCall()));
  sl.registerLazySingleton<ShareBloc>(()=> ShareBloc(/*authenticationApiCall: AuthenticationApiCall()*/));
  sl.registerLazySingleton<TeamScreenBloc>(()=> TeamScreenBloc(apiRepository: AuthenticationApiCall(),));
  sl.registerLazySingleton<InspectorCreateAdminBloc>(()=> InspectorCreateAdminBloc(apiRepository: AuthenticationApiCall(),));
}
