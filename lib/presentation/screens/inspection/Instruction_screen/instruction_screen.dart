part of 'instruction_screen_route_imple.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InstructionScreenBloc>(
      create: (context) => InstructionScreenBloc(),
      child: const InstructionScreenView(),
    );
  }
}

class InstructionScreenView extends StatefulWidget {
  const InstructionScreenView({super.key});

  @override
  State<InstructionScreenView> createState() => _InstructionScreenViewState();
}

class _InstructionScreenViewState extends State<InstructionScreenView> {
  int currentStep = 0;
  final int totalSteps = 4;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    List<String> stepTitles = [
      l10n.instruction,
      l10n.carDetails,
      l10n.ownerDetails,
      l10n.clientDetails,
      /* l10n.clientDetails,*/
    ];

    String currentTitle =
    (currentStep < stepTitles.length) ? stepTitles[currentStep] : l10n.step;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
         /* CustomAppBar(
              backgroundColor: AppColor().backgroundColor,
              title: currentTitle,
              subTitle: "${AppLocalizations.of(context)!.step} ${currentStep+1} of $totalSteps"
          ),*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _buildProgressIndicator(),
                  vGap(16),
                  Expanded(child: _buildStepContent(currentStep)),
                  _buildNavigationButtons(l10n),
                  vGap(10)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Progress indicator - Reduced sizes
  Widget _buildProgressIndicator() {
    return Column(
      children: [
        _horizontalSelectiveButtonView(context),
        vGap(12), // Reduced from 16
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fullWidth = constraints.maxWidth;
              double progressPercent = (currentStep + 1) / totalSteps;
              double progressWidth = fullWidth * progressPercent;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 8, // Reduced from 10
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), // Reduced from 8
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    height: 8, // Reduced from 10
                    width: progressWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6), // Reduced from 8
                      color: AppColor().darkYellowColor,
                    ),
                  ),
                  Positioned(
                    left: progressWidth - 12, // Reduced from 16
                    top: -10, // Reduced from -12
                    child: Container(
                      width: 24, // Reduced from 28
                      height: 24, // Reduced from 28
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor().darkYellowColor,
                        border: Border.all(color: Colors.white, width: 2), // Reduced from 3
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 3, // Reduced from 4
                            offset: const Offset(0, 1), // Reduced from Offset(0, 2)
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${currentStep + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12, // Added explicit smaller font size
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _horizontalSelectiveButtonView(BuildContext context) {
    final icons = [alertIcon, carFrontIcon, passIcon, personDarkIcon, cameraIcon];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;

        return GestureDetector(
          onTap: () => _goToStep(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 55, // Reduced from 65
            height: 50, // Reduced from 60
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColor().darkCharcoalBlueColor
                  : AppColor().darkYellowColor,
              boxShadow: isActive
                  ? [
                BoxShadow(
                  color: AppColor().darkCharcoalBlueColor.withOpacity(0.3),
                  blurRadius: 6, // Reduced from 8
                  offset: const Offset(0, 1), // Reduced from Offset(0, 2)
                ),
              ]
                  : null,
            ),
            child: Center(
              child: Image.asset(
                icons[index],
                width: 25, // Reduced from 32
                height: 25, // Reduced from 32
                color: isActive
                    ? AppColor().darkYellowColor
                    : AppColor().darkCharcoalBlueColor,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContentArea() {
    final l10n = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    // Define breakpoints
    final bool isDesktop = screenWidth >= 1024;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;

    // Dynamic values
    final double fontSize = isDesktop
        ? 28
        : isTablet
        ? 24
        : 20;
    final double subTextSize = isDesktop
        ? 16
        : isTablet
        ? 14
        : 12;
    final double cardPadding = isDesktop ? 24 : 16;
    final double spacingSmall = isDesktop ? 12 : 8;
    final double spacingLarge = isDesktop ? 32 : 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            redirectToWebPage("https://www.autoproof24.com/departure-guide/");
          },
          child: _buildGuideButton(l10n.departureGuide, arrowForwardRoundIcon),
        ),
        SizedBox(height: spacingSmall),
        GestureDetector(
          onTap: () {
            redirectToWebPage("https://www.autoproof24.com/return-guide/");
          },
          child: _buildGuideButton(l10n.returnGuide, arrowForwardRoundIcon),
        ),
        SizedBox(height: spacingLarge),

        // Responsive card container
        CustomContainer(
          backgroundColor: AppColor().darkCharcoalBlueColor,
          borderRadius: BorderRadius.circular(isDesktop ? 12 : 10),
          width: double.infinity,
          padding: EdgeInsets.all(cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AP100001",
                style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkYellowColor,
                  size: fontSize,
                ),
              ),
              SizedBox(height: spacingSmall),
              Text(
                l10n.inspectionNumber,
                style: TextStyle(
                  fontSize: subTextSize,
                  color: AppColor().darkYellowColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildGuideButton(String title, String icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Reduced padding
      decoration: BoxDecoration(
        color: AppColor().darkYellowColor,
        borderRadius: BorderRadius.circular(10), // Reduced from 12
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 16, // Reduced from 18
            ),
          ),
          Image.asset(
            icon,
            height: 30, // Reduced from 35
            width: 30, // Reduced from 35
            color: AppColor().darkCharcoalBlueColor,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(AppLocalizations l10n) {
    return Row(
      children: [
        if(currentStep != 0)
        Expanded(
          child: CustomButton(
            textColor: AppColor().darkYellowColor,
            onPressed: currentStep > 0 ? _previousStep : null,
            text: l10n.back,
            side: BorderSide.none,
          ),
        ),
        hGap(12), // Reduced from 16
        Expanded(
          child: CustomButton(
            textColor: AppColor().darkYellowColor,
            onPressed: currentStep < totalSteps - 1
                ? _nextStep
                : () {
              context.push(AppRoute.ownerSignatureViewScreen);
            },
            text: l10n.next,
            side: BorderSide.none,
          ),
        )
      ],
    );
  }

  void _nextStep() {
    if (currentStep < totalSteps - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  void _goToStep(int step) {
    setState(() {
      currentStep = step;
    });
  }

  Widget _buildStepContent(int currentStep) {
    switch (currentStep) {
      case 0:
        return _buildStep0();
      case 1:
        return CarDetailsScreen();
      case 2:
        return OwnerDetailsScreen();
   case 3:
        return ClientDetailsScreen();
    /*       case 4:
        return CarImInpectionScreen();*/
      default:
        return _buildStep0();
    }
  }

  Widget _buildStep0() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContentArea(),
        ],
      ),
    );
  }
}