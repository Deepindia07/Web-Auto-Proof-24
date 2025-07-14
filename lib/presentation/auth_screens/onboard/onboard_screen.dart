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
    // OnboardingData(
    //   title: "WELCOME !",
    //   subtitle: "Manage Your Fleet",
    //   description: "with Ease",
    //   imagePath: car1Icon,
    // ),
    // OnboardingData(
    //   title: "WELCOME !",
    //   subtitle: "Real-Time Car",
    //   description: "Availability",
    //   imagePath: car2Icon,
    // ),
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
                                  page.subtitle,
                                  style: MontserratStyles.montserratMediumTextStyle(
                                    color: AppColor().darkCharcoalBlueColor,
                                    size: screenWidth * 0.045,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                if (page.description.isNotEmpty) ...[
                                  vGap(screenHeight * 0.003),
                                  Text(
                                    page.description,
                                    style: MontserratStyles.montserratMediumTextStyle(
                                      color: AppColor().darkCharcoalBlueColor,
                                      size: screenWidth * 0.045,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                                Spacer(),
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
                                text: "Get Started",
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
              // Container(
              //   height: screenHeight * 0.12,
              //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: List.generate(
              //           onboardingPages.length,
              //               (index) => Container(
              //             margin: EdgeInsets.symmetric(horizontal: 4),
              //             width: 12,
              //             height: 12,
              //             decoration: BoxDecoration(
              //               shape: BoxShape.circle,
              //               color: currentPage == index
              //                   ? AppColor().darkCharcoalBlueColor
              //                   : Colors.grey.shade400,
              //             ),
              //           ),
              //         ),
              //       ),
              //
              //       vGap(screenHeight * 0.02),
              //
              //       TextButton(
              //         onPressed: () {
              //           if (currentPage < onboardingPages.length - 1) {
              //             pageController.animateToPage(
              //               onboardingPages.length - 1,
              //               duration: Duration(milliseconds: 300),
              //               curve: Curves.easeInOut,
              //             );
              //           } else {
              //           }
              //         },
              //         child: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Text(
              //               "Skip Now",
              //               style: MontserratStyles.montserratMediumTextStyle(
              //                 color: AppColor().darkCharcoalBlueColor,
              //                 size: screenWidth * 0.04,
              //               ),
              //             ),
              //             hGap(8),
              //             Image.asset(
              //               arrowForwardStyleIcon,
              //               height: screenHeight * 0.025,
              //               width: screenWidth * 0.05,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
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

  void _navigateToNextScreen(){
    context.push(AppRoute.loginScreen);
  }
}

