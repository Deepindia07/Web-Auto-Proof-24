import 'package:auto_proof/presentation/screens/personal_information_screens/bloc/personal_information_bloc/personal_information_bloc.dart';
import 'package:auto_proof/presentation/screens/team_View/bloc/team_screen_bloc.dart';
import 'package:auto_proof/presentation/splash/bloc/splash_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/server/network/auth_network_imple_service.dart';
import 'l10n_controller/l10n_switcher_bloc.dart';
import 'presentation/screens/inspector_create_admin/bloc/inspector_create_admin_bloc.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonalInformationBloc>(
          create: (context) => PersonalInformationBloc(
            authenticationApiCall: AuthenticationApiCall(),
          ),
        ),

        BlocProvider<SplashScreenBloc>(create: (context) => SplashScreenBloc()),
        BlocProvider<InspectorCreateAdminBloc>(create: (context) => InspectorCreateAdminBloc(apiRepository: AuthenticationApiCall())),
        BlocProvider<TeamScreenBloc>(create: (context) => TeamScreenBloc(apiRepository: AuthenticationApiCall())),
        BlocProvider<LocalizationsBlocController>(
          create: (context) => LocalizationsBlocController(),
        ),
      ],
      child: child,
    );
  }
}
