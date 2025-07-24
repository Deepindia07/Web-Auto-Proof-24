part of 'onboard_screen_route_imple.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardViewScreen();
  }
}

class OnboardViewScreen extends StatefulWidget {
  const OnboardViewScreen({super.key});

  @override
  State<OnboardViewScreen> createState() => _OnboardViewScreenState();
}

class _OnboardViewScreenState extends State<OnboardViewScreen> {
  int currentPage = 0;
  PageController pageController = PageController();

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      title: "WELCOME !",
      subtitle: "Smart Check-out.",
      description: "Secure Check-In.",
      imagePath: carIcon,
      showGetStarted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return BlocProvider<OnboardScreenBloc>(
      create: (context) => OnboardScreenBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor().backgroundColor,
        ),
        backgroundColor: AppColor().backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.24,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      appLogo,
                      height: screenHeight * 0.16,
                      width: screenHeight * 0.16,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      "Auto Proof 24",
                      style: MontserratStyles.montserratBoldTextStyle(
                        color: AppColor().darkCharcoalBlueColor,
                        size: screenWidth * 0.10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) {
                    final page = onboardingPages[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01,
                              ),
                              child: Center(
                                child: Image.asset(
                                  page.imagePath,
                                  width: screenWidth * 0.85,
                                  height: screenHeight * 0.28,
                                  fit: BoxFit.contain,
                                  color: AppColor().darkCharcoalBlueColor,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                vGap(screenHeight * 0.01),
                                Text(
                                  "${AppLocalizations.of(context)!.welcome}!",
                                  style: MontserratStyles.montserratBoldTextStyle(
                                    color: AppColor().darkCharcoalBlueColor,
                                    size: screenWidth * 0.08,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                vGap(screenHeight * 0.015),
                                Text(
                                  AppLocalizations.of(context)!.secureCheckIn,
                                  style: MontserratStyles.montserratMediumTextStyle(
                                    color: AppColor().darkCharcoalBlueColor,
                                    size: screenWidth * 0.045,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (page.description.isNotEmpty) ...[
                                  vGap(screenHeight * 0.003),
                                  Text(
                                    AppLocalizations.of(context)!.smartCheckOut,
                                    style: MontserratStyles.montserratMediumTextStyle(
                                      color: AppColor().darkCharcoalBlueColor,
                                      size: screenWidth * 0.045,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                const Spacer(),
                              ],
                            ),
                          ),
                          if (page.showGetStarted)
                            Container(
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.5,
                              margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                              child: CustomButton(
                                onPressed: () {
                                  _navigateToNextScreen();
                                },
                                side: BorderSide.none,
                                text: AppLocalizations.of(context)!.getStarted,
                                textStyle: MontserratStyles.montserratMediumTextStyle(
                                  color: AppColor().darkCharcoalBlueColor,
                                  size: 18,
                                ),
                                borderRadius: 30,
                                backgroundColor: AppColor().darkYellowColor,
                                elevation: 0,
                              ),
                            )
                          else
                            vGap(screenHeight * 0.02),
                        ],
                      ),
                    );
                  },
                ),
              ),
              vGap(screenHeight * 0.08),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() async {
    try {
      final isFirstTimeUser = SharedPrefsHelper.instance.getString(isFirstTime);

      if (isFirstTimeUser != null && isFirstTimeUser.isEmpty) {
        await SharedPrefsHelper.instance.setString(isFirstTime, "false");
        if (mounted) {
          context.push(AppRoute.loginScreen);
        }
      } else {
        if (mounted) {
          context.push(AppRoute.roleBaseSelectionView);
        }
      }
    } catch (e) {
      print("Error checking first time user: $e");
      if (mounted) {
        context.push(AppRoute.roleBaseSelectionView);
      }
    }
  }
}

/// Role base Access View
class RoleSelectionView extends StatefulWidget {
  const RoleSelectionView({super.key});

  @override
  State<RoleSelectionView> createState() => _RoleSelectionViewState();
}

class _RoleSelectionViewState extends State<RoleSelectionView> {
  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top * 4;
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          vGap(statusBarHeight + 10),
          SizedBox(
            height: screenHeight * 0.24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  appLogo,
                  height: screenHeight * 0.16,
                  width: screenHeight * 0.16,
                  fit: BoxFit.contain,
                ),
                vGap(screenHeight * 0.015),
                Text(
                  "Auto Proof 24",
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: screenWidth * 0.10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Role selection title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Text(
              "Select Your Role",
              style: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: screenWidth * 0.06,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          vGap(screenHeight * 0.03),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  // Owner Button
                  CustomRoleSelectionButton(
                    title: 'Are you Owner',
                    isSelected: selectedRole == 'owner',
                    onTap: () {
                      setState(() {
                        selectedRole = 'owner';
                      });
                      _navigateScreenState("owner");
                    },
                  ),

                  vGap(screenHeight * 0.02),

                  // Inspector Button
                  CustomRoleSelectionButton(
                    title: 'Are you Inspector',
                    isSelected: selectedRole == 'instructor',
                    onTap: () {
                      setState(() {
                        selectedRole = 'instructor';
                      });
                      _navigateScreenState("instructor");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateScreenState(String role) {
    if (role == "instructor") {
      SharedPrefsHelper.instance.setString(roleKey,role);
      print("role: $role");
      context.push(AppRoute.loginScreen);
    } else if (role == "owner") {
      SharedPrefsHelper.instance.setString(roleKey,role);
      context.push(AppRoute.loginScreen, extra: role);
    }
  }
}