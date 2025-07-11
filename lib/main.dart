import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/presentation/splash/bloc/splash_screen_bloc.dart';
import 'package:auto_proof/route/app_route_imple.dart';
import 'package:auto_proof/utilities/di/di_injection_route_imple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth/server/observer/app_bloc_observer.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final blocObserver = AppServiceBlocObserver();
  Bloc.observer = blocObserver;
  await init();
 await SharedPrefsHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SplashScreenBloc>(create: (context)=> SplashScreenBloc())
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          routerConfig: AppRouter.router,
          // home: OnboardScreen(),
        ),
      ),
    );
  }
}


