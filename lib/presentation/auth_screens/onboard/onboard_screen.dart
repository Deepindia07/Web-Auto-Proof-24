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
    final isLandscape = screenWidth > screenHeight;

    return BlocProvider<OnboardScreenBloc>(
      create: (context) => OnboardScreenBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor().backgroundColor,
        ),
        backgroundColor: AppColor().backgroundColor,
        body: SafeArea(
          child: isLandscape ? _buildLandscapeLayout(context) : _buildPortraitLayout(context),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Column(
      children: [
        // Header section with logo and title
        SizedBox(
          height: screenHeight * 0.216,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                appLogo,
                height: screenHeight * 0.126,
                width: screenHeight * 0.126,
                fit: BoxFit.contain,
              ),
              SizedBox(height: screenHeight * 0.0117),
              Text(
                "Auto Proof 24",
                style: MontserratStyles.montserratBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: screenWidth * 0.09,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // PageView content
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
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
                child: Column(
                  children: [
                    // Image section
                    Center(
                      child: Image.asset(
                        page.imagePath,
                        width: screenWidth * 0.675,
                        height: screenHeight * 0.252,
                        fit: BoxFit.contain,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                    // Text content
                    Text(
                      "${AppLocalizations.of(context)!.welcome}!",
                      style: MontserratStyles.montserratBoldTextStyle(
                        color: AppColor().darkCharcoalBlueColor,
                        size: screenWidth * 0.072,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    vGap(screenHeight * 0.0135),
                    Text(
                      AppLocalizations.of(context)!.secureCheckIn,
                      style: MontserratStyles.montserratMediumTextStyle(
                        color: AppColor().darkCharcoalBlueColor,
                        size: screenWidth * 0.036,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (page.description.isNotEmpty) ...[
                      vGap(screenHeight * 0.0135),
                      Text(
                        AppLocalizations.of(context)!.smartCheckOut,
                        style: MontserratStyles.montserratMediumTextStyle(
                          color: AppColor().darkCharcoalBlueColor,
                          size: screenWidth * 0.036,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    vGap(screenHeight * 0.027),
                    // Button section
                    if (page.showGetStarted)
                      Container(
                        height: screenHeight * 0.054,
                        width: screenWidth * 0.45,
                        child: CustomButton(
                          onPressed: () {
                            _navigateToNextScreen();
                          },
                          side: BorderSide.none,
                          text: AppLocalizations.of(context)!.getStarted,
                          textStyle: MontserratStyles.montserratMediumTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                            size: 16.2,
                          ),
                          borderRadius: 27,
                          backgroundColor: AppColor().darkYellowColor,
                          elevation: 0,
                        ),
                      )
                    else
                      vGap(screenHeight * 0.018),
                    // Flexible spacer
                    Expanded(child: Container()),
                  ],
                ),
              );
            },
          ),
        ),
        vGap(screenHeight * 0.045),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight),
        child: Row(
          children: [
            // Left side - Logo and title
            Container(
              width: screenWidth * 0.35,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenHeight * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    appLogo,
                    height: screenHeight * 0.25,
                    width: screenHeight * 0.25,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Auto Proof 24",
                    style: MontserratStyles.montserratBoldTextStyle(
                      color: AppColor().darkCharcoalBlueColor,
                      size: screenWidth * 0.035,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Right side - Content
            Expanded(
              child: Container(
                height: screenHeight,
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
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.05,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image section
                          Flexible(
                            flex: 3,
                            child: Center(
                              child: Image.asset(
                                page.imagePath,
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.4,
                                fit: BoxFit.contain,
                                color: AppColor().darkCharcoalBlueColor,
                              ),
                            ),
                          ),
                          // Text content section
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${AppLocalizations.of(context)!.welcome}!",
                                  style: MontserratStyles.montserratBoldTextStyle(
                                    color: AppColor().darkCharcoalBlueColor,
                                    size: screenWidth * 0.028,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: screenHeight * 0.015),
                                Text(
                                  AppLocalizations.of(context)!.secureCheckIn,
                                  style: MontserratStyles.montserratMediumTextStyle(
                                    color: AppColor().darkCharcoalBlueColor,
                                    size: screenWidth * 0.02,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (page.description.isNotEmpty) ...[
                                  SizedBox(height: screenHeight * 0.01),
                                  Text(
                                    AppLocalizations.of(context)!.smartCheckOut,
                                    style: MontserratStyles.montserratMediumTextStyle(
                                      color: AppColor().darkCharcoalBlueColor,
                                      size: screenWidth * 0.02,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          // Button section
                          if (page.showGetStarted)
                            Container(
                              height: screenHeight * 0.08,
                              width: screenWidth * 0.25,
                              child: CustomButton(
                                onPressed: () {
                                  _navigateToNextScreen();
                                },
                                side: BorderSide.none,
                                text: AppLocalizations.of(context)!.getStarted,
                                textStyle: MontserratStyles.montserratMediumTextStyle(
                                  color: AppColor().darkCharcoalBlueColor,
                                  size: 14,
                                ),
                                borderRadius: 25,
                                backgroundColor: AppColor().darkYellowColor,
                                elevation: 0,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
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
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isLandscape = screenWidth > screenHeight;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SafeArea(
        child: isLandscape ? _buildLandscapeRoleLayout(context) : _buildPortraitRoleLayout(context),
      ),
    );
  }

  Widget _buildPortraitRoleLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final statusBarHeight = MediaQuery.of(context).padding.top * 3.6;

    return Column(
      children: [
        vGap(statusBarHeight + 9),
        // Header section
        SizedBox(
          height: screenHeight * 0.216,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                appLogo,
                height: screenHeight * 0.126,
                width: screenHeight * 0.126,
                fit: BoxFit.contain,
              ),
              vGap(screenHeight * 0.0135),
              Text(
                "Auto Proof 24",
                style: MontserratStyles.montserratBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: screenWidth * 0.09,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        vGap(9),
        // Role selection title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
          child: Text(
            "Select Your Role",
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: screenWidth * 0.045,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        vGap(screenHeight * 0.027),
        // Role buttons
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.045),
            child: Column(
              children: [
                CustomRoleSelectionButton(
                  height: screenHeight * 0.0558,
                  title: 'Are you Owner',
                  isSelected: selectedRole == 'owner',
                  onTap: () {
                    setState(() {
                      selectedRole = 'owner';
                    });
                    _navigateScreenState("owner");
                  },
                ),
                vGap(screenHeight * 0.018),
                CustomRoleSelectionButton(
                  height: screenHeight * 0.0558,
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
    );
  }

  Widget _buildLandscapeRoleLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight),
        child: Row(
          children: [
            // Left side - Logo and title
            Container(
              width: screenWidth * 0.4,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
                vertical: screenHeight * 0.1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    appLogo,
                    height: screenHeight * 0.3,
                    width: screenHeight * 0.3,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Text(
                    "Auto Proof 24",
                    style: MontserratStyles.montserratBoldTextStyle(
                      color: AppColor().darkCharcoalBlueColor,
                      size: screenWidth * 0.035,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Right side - Role selection
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenHeight * 0.1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Select Your Role",
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        color: AppColor().darkCharcoalBlueColor,
                        size: screenWidth * 0.025,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    // Role buttons
                    CustomRoleSelectionButton(
                      height: screenHeight * 0.12,
                      title: 'Are you Owner',
                      isSelected: selectedRole == 'owner',
                      onTap: () {
                        setState(() {
                          selectedRole = 'owner';
                        });
                        _navigateScreenState("owner");
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    CustomRoleSelectionButton(
                      height: screenHeight * 0.12,
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
      ),
    );
  }

  void _navigateScreenState(String role) {
    if (role == "instructor") {
      SharedPrefsHelper.instance.setString(roleKey, role);
      print("role: $role");
      context.push(AppRoute.loginScreen);
    } else if (role == "owner") {
      SharedPrefsHelper.instance.setString(roleKey, role);
      context.push(AppRoute.loginScreen, extra: role);
    }
  }
}