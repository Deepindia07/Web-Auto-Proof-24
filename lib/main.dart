  import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
  import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
  import 'package:auto_proof/l10n/app_localizations.dart';
  import 'package:auto_proof/presentation/splash/bloc/splash_screen_bloc.dart';
  import 'package:auto_proof/route/app_route_imple.dart';
  import 'package:auto_proof/utilities/di/di_injection_route_imple.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_localizations/flutter_localizations.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:flutter_stripe/flutter_stripe.dart';
  import 'package:package_info_plus/package_info_plus.dart';

  import 'auth/server/observer/app_bloc_observer.dart';
  import 'l10n_controller/l10n_switcher_bloc.dart';


  void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    final blocObserver = AppServiceBlocObserver();
    Bloc.observer = blocObserver;
    await PackageInfo.fromPlatform();
    await init();
   await SharedPrefsHelper.init();
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return ScreenUtilInit(
          designSize: const Size(375, 812),
        // designSize: Size(
        //     MediaQuery
        //         .of(context)
        //         .size
        //         .width,
        //     MediaQuery
        //         .of(context)
        //         .size
        //         .height
        // ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SplashScreenBloc>(
                create: (context) => SplashScreenBloc()),
            BlocProvider<LocalizationsBlocController>(
                create: (context) => LocalizationsBlocController()),
          ],
          child: BlocBuilder<LocalizationsBlocController, LocalizationsState>(
            builder: (context, state) {
              return MaterialApp.router(
                locale: state.locale??Locale("fr"),
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale?.languageCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales.first;
                },
                supportedLocales: [
                  Locale("fr"),
                  Locale("en"),
                ],
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                ),
                routerConfig: AppRouter.router,
                // home: OnboardScreen(),
              );
            },
          ),
        ),
      );
    }
  }


