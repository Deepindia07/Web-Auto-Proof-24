part of 'app_route_imple.dart';

class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppRoute.loginScreen,
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
        path: AppRoute.contactUsScreen,
        name: 'contactUsScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: ContactUsScreen(),
          animation: AppAnimations.fadeIn,
          duration: const Duration(milliseconds: 800),
        ),
      ),
      GoRoute(
        path: AppRoute.companyInfoScreen,
        name: 'companyInfoScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const CompanyInfoScreen(),
          animation: AppAnimations.fadeIn,
          duration: const Duration(milliseconds: 800),
        ),
      ),

      GoRoute(
        path: AppRoute.personalInformationScreen,
        name: 'personalInformationScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const PersonalInformationScreen(),
          animation: AppAnimations.fadeIn,
          duration: const Duration(milliseconds: 800),
        ),
      ),
      GoRoute(
        path: AppRoute.contactSalesFromScreen,
        name: 'contactSalesFromScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: ContactSalesFromScreen(),
          animation: AppAnimations.fadeIn,
          duration: const Duration(milliseconds: 800),
        ),
      ),
      GoRoute(
        path: AppRoute.subscriptionScreen,
        name: 'subscriptionScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: SubscriptionScreen(),
          animation: AppAnimations.fadeIn,
          duration: const Duration(milliseconds: 800),
        ),
      ),
      GoRoute(
        path: AppRoute.myVehicleDetailsScreen,
        name: 'MyVehicleDetailsScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: MyVehicleDetailsScreen(
            onScreenChange: (screen, {vehicleId}) {
              // Handle navigation or state here
              debugPrint("Navigated to $screen with inspectorId: $vehicleId");
            }, vehicleId: '',
          ),
          animation: AppAnimations.fadeIn,
          duration: const Duration(milliseconds: 800),
        ),
      ),
      GoRoute(
        path: AppRoute.webProfileScreen,
        name: 'webProfileScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const MyProfileScreen(),
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
        path: AppRoute.roleBaseSelectionView,
        name: 'roleBaseSelectionView',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const RoleSelectionView(),
          animation: AppAnimations.slideFromRight,
          duration: const Duration(milliseconds: 600),
        ),
      ),
      GoRoute(
        path: AppRoute.loginScreen,
        name: 'login',
        pageBuilder: (context, state) {
          final role = SharedPrefsHelper.instance.getString(roleKey);
          print("user role: = $role");
          return _buildPageWithAnimation(
            state: state,
            child: LoginScreen(userRole: "owner"),
            animation: AppAnimations.slideFromBottom,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),
      GoRoute(
        path: AppRoute.signUpScreen,
        name: 'signUp',
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>? ?? {};
          final email = data['email'] ?? '';
          final phone = data['phone'] ?? '';
          final typeScreen = data['typeScreen'] ?? '';

          return _buildPageWithAnimation(
            state: state,
            child: SignUpScreen(
              email: email,
              phone: phone,
              typeScreen: typeScreen,
            ),
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),

      GoRoute(
        path: AppRoute.onDashboardScreen,
        name: 'dashboardScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const DashboardScreen(),
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
            child: ForgotScreen(emailOrPhone: email),
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),
      GoRoute(
        path: AppRoute.otpScreen,
        name: 'otp',
        pageBuilder: (context, state) {
          final extra = (state.extra as Map<String, dynamic>?) ?? {};

          return _buildPageWithAnimation(
            state: state,
            child: OtpScreen(
              email: extra['email'] as String? ?? "",
              phone: extra['phone'] as String? ?? "",
              isEmailFromSignUp: extra['isEmailFromSignUp'] as bool? ?? false,
              otpType: extra['otpType'] as String? ?? "unknown",
            ),
            animation: AppAnimations.slideFromBottom,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),

      GoRoute(
        path: AppRoute.resetPasswordScreen,
        name: 'resetpassword',
        pageBuilder: (context, state) {
          final email = state.extra.toString();
          return _buildPageWithAnimation(
            state: state,
            child: ResetPasswordScreen(email: email),
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),

      GoRoute(
        path: AppRoute.homeScreen,
        name: 'home',
        pageBuilder: (context, state) {
          final role = SharedPrefsHelper.instance.getString(roleKey);
          return _buildPageWithAnimation(
            state: state,
            child: HomeScreen(),
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),

      /*    GoRoute(
        path: AppRoute.reportsScreen,
        name: 'reports',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          */
      /*deep07developer1@gmail.com*/
      /*
          state: state,
          child: ReportsScreen(isBacked: false, onBack: () {}),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),*/
      GoRoute(
        path: AppRoute.paymentScreen,
        name: 'payments',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: PaymentHistoryScreen(),
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
      /*   GoRoute(
        path: AppRoute.collectInformationScreen,
        name: 'collectInformationScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: CollectInformationScreen(
            isBacked: false,
            onBack: () {},
            userId: SharedPrefsHelper.instance.getString(userId)!,
          ),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),*/
      GoRoute(
        path: AppRoute.notificationScreen,
        name: 'notification',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: NotificationScreen(isBacked: false, onBack: () {}),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.instructionScreen,
        name: 'instructionScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: InstructionScreen(),
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
          child: OwnerDetailsScreen(
            ownerDetailsScreenBloc: OwnerDetailsScreenBloc(),
            onScreenChange: (screen, {inspectorId}) {
              // Handle navigation or state here
              debugPrint("Navigated to $screen with inspectorId: $inspectorId");
            },
          ),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.clientDetailsScreen,
        name: 'clientDetailsScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: ClientDetailsScreen(bloc: ClientDetailsScreenBloc()),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.carImageInpectionScreen,
        name: 'carImageInpectionScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: CarImInpectionScreen(carDetailsModel: CarDetailsModel()),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.myTeamDetailsScreen,
        name: 'myTeamDetailsScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: MyTeamDetailsScreen(
            inspectorId: '',
            onScreenChange: (screen, {inspectorId}) {
              // Handle navigation or state here
              debugPrint("Navigated to $screen with inspectorId: $inspectorId");
            },
          ),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),
      GoRoute(
        path: AppRoute.ownerSignatureViewScreen,
        name: 'ownerSignatureViewScreen',
        pageBuilder: (context, state) {
          final carDetailsModel = state.extra as CarDetailsModel;
          return _buildPageWithAnimation(
            state: state,
            child: OwnerSignatureScreen(carDetailsModel: carDetailsModel),
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),
      /*   GoRoute(
        path: AppRoute.clientSignatureViewScreen,
        name: 'clientSignatureViewScreen',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: const ClientSignatureScreenView(carDetailsModel: null,),
          animation: AppAnimations.slideFromRightWithScale,
          duration: const Duration(milliseconds: 500),
        ),
      ),*/
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
        pageBuilder: (context, state) {
          final screenType = state.extra as String? ?? "";
          return _buildPageWithAnimation(
            state: state,
            child: MyTeamScreen(
              onScreenChange: (screen, {inspectorId}) {
                // Handle navigation or state here
                debugPrint(
                  "Navigated to $screen with inspectorId: $inspectorId",
                );
              },
              screenType: screenType,
            ), // ✅ works now
            animation: AppAnimations.slideFromRightWithScale,
            duration: const Duration(milliseconds: 500),
          );
        },
      ),

      GoRoute(
        path: AppRoute.vehiclesScreenView,
        name: 'vehiclesScreenView',
        pageBuilder: (context, state) => _buildPageWithAnimation(
          state: state,
          child: VehiclesScreen(  onScreenChange: (type, {vehicleId}) {
          /*  setState(() {
              currentScreen = type;
              selectedInspectorId = vehicleId;
            });*/
          }, screenType: '',),
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
            Icon(Icons.car_crash_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Route Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
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

//class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6FAFE),
//       body: Responsive(
//         mobile: _buildMobileLayout(),
//         mobileLarge: _buildMobileLayout(),
//         tab: _buildTabletLayout(),
//         desktop: _buildDesktopLayout(),
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: const [
//           LoginForm(),
//           SizedBox(height: 30),
//           SideImage(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTabletLayout() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
//       child: Column(
//         children: const [
//           LoginForm(isWide: true),
//           SizedBox(height: 40),
//           SideImage(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDesktopLayout() {
//     return  Row(
//       children: [
//         Expanded(
//           flex: 5,
//           child: Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(maxWidth: 400),
//               child: LoginForm(),
//             ),
//           ),
//         ),
//         Expanded(flex: 5, child: SideImage()),
//       ],
//     );
//   }
// }
//
// class LoginForm extends StatelessWidget {
//   final bool isWide;
//   const LoginForm({super.key, this.isWide = false});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center( // ✅ Vertical center
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset("assets/logo.png", height: 60),
//           const SizedBox(height: 12),
//           const Text(
//             "Auto Proof 24",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const Text(
//             "VEHICLE INSPECTION APPLICATION",
//             style: TextStyle(fontSize: 12, letterSpacing: 1.2),
//           ),
//           const SizedBox(height: 30),
//
//           // Email Field
//           TextField(
//             decoration: _inputDecoration("Email or Phone"),
//           ),
//           const SizedBox(height: 15),
//
//           // Password Field
//           TextField(
//             obscureText: true,
//             decoration: _inputDecoration("Password").copyWith(
//               suffix: InkWell(
//                 onTap: () {},
//                 child: const Padding(
//                   padding: EdgeInsets.only(right: 8.0),
//                   child: Text(
//                     "Forgot Password?",
//                     style: TextStyle(color: Colors.blue, fontSize: 12),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 25),
//
//           // Login Button
//           SizedBox(
//             width: double.infinity,
//             height: 45,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF1F2D4A),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {},
//               child: const Text("Login", style: TextStyle(color: Colors.white)),
//             ),
//           ),
//           const SizedBox(height: 10),
//           const Text("or"),
//           const SizedBox(height: 10),
//
//           // Create Account Button
//           SizedBox(
//             width: double.infinity,
//             height: 45,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(color: Color(0xFF1F2D4A)),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {},
//               child: const Text(
//                 "Create an Account",
//                 style: TextStyle(color: Color(0xFF1F2D4A)),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   InputDecoration _inputDecoration(String hint) {
//     return InputDecoration(
//       hintText: hint,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
//     );
//   }
// }
//
//
//
// class SideImage extends StatelessWidget {
//   const SideImage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.transparent,
//       child: Center(
//         child: Image.asset(
//           "assets/login_image.png",
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }
