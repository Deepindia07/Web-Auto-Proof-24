part of 'app_route_imple.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoute.splashScreen,
    routes: [
      GoRoute(
        path: AppRoute.splashScreen,
        name: 'splash',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const SplashScreen(),
          animation: AppAnimations.fadeIn,
          duration: const Duration(milliseconds: 800),
        ),
      ),
      GoRoute(
        path: AppRoute.onBoardScreenRoute,
        name: 'onboard',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const OnboardScreen(),
          animation: AppAnimations.slideFromRight,
          duration: const Duration(milliseconds: 600),
        ),
      ),
      GoRoute(
        path: AppRoute.loginScreen,
        name: 'login',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const LoginScreen(),
          animation: AppAnimations.slideFromBottom,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.signUpScreen,
        name: 'signUp',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const RegistrationScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.forgotScreen,
        name: 'forgot',
        pageBuilder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>?;
          final email = extraData?['email'] ?? '';
          return _buildPageWithAnimation(
            state: state,
            child: ForgotScreen(emailOrPhone: email,),
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),
      GoRoute(
        path: AppRoute.otpScreen,
        name: 'otp',
        pageBuilder: (context, state) {
          final email = state.extra.toString();
          return _buildPageWithAnimation(
            state: state,
            child: OtpScreen(email: email,),
            animation: AppAnimations.slideFromBottom,
            duration: const Duration(milliseconds: 500),
          );
        }
      ),
      GoRoute(
        path: AppRoute.resetPasswordScreen,
        name: 'resetpassword',
        pageBuilder: (context, state){
          final email = state.extra.toString();
          return _buildPageWithAnimation(
            state: state,
            child: ResetPasswordScreen(email: email,),
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),

      GoRoute(
        path: AppRoute.homeScreen,
        name: 'home',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const HomeScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),

      GoRoute(
        path: AppRoute.reportsScreen,
        name: 'reports',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: ReportsScreen(isBacked: false,onBack: (){},),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.paymentScreen,
        name: 'payments',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const PaymentScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.cardDetailsScreen,
        name: 'cardDetails',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const CardDetailsScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.collectInformationScreen,
        name: 'collectInformationScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: CollectInformationScreen(isBacked: false,onBack: (){}, userId: SharedPrefsHelper.instance.getString(userId)!,),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
          path: AppRoute.notificationScreen,
          name: 'notification',
          pageBuilder: (context, state) => _buildPageWithAnimation(
            state: state,
            child:  NotificationScreen(isBacked: false,onBack: (){},),
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          ),
        ),
      GoRoute(
        path: AppRoute.instructionScreen,
        name: 'instructionScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const InstructionScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.carInstructionDetailsScreen,
        name: 'carInstructionDetailsScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const CardDetailsScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.ownerDetailsScreen,
        name: 'ownerDetailsScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const OwnerDetailsScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.clientDetailsScreen,
        name: 'clientDetailsScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const ClientDetailsScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.carImageInpectionScreen,
        name: 'carImageInpectionScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const CarImInpectionScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.ownerSignatureViewScreen,
        name: 'ownerSignatureViewScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const OwnerSignatureScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.clientSignatureViewScreen,
        name: 'clientSignatureViewScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const ClientSignatureScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.inpectionScreenViewScreen,
        name: 'inpectionScreenViewScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const InspectionListScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.changeScreen,
        name: 'changeScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: ChangePasswordScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.teamSreenView,
        name: 'teamScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: TeamScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.vehiclesScreenView,
        name: 'vehiclesScreenView',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: VehiclesScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.historyScreenView,
        name: 'historyScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: HistoryScreenView(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.createInspectorView,
        name: 'createInspectorView',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: InspectionCreateAdminScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.aboutAppView,
        name: 'aboutAppView',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: AboutAppScreen(),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    ],
    errorBuilder: (context, state) => _buildErrorPage(context, state),
  );

  static GoRouter get router => _router;

  static CustomTransitionPage _buildPageWithAnimation({
    required GoRouterState state,
    required Widget child,
    required RouteTransitionsBuilder animation,
    required Duration duration,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: animation,
    );
  }

  static Widget _buildErrorPage(BuildContext context, GoRouterState state) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.car_crash_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Route Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.go(AppRoute.splashScreen),
              icon: const Icon(Icons.home),
              label: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}

