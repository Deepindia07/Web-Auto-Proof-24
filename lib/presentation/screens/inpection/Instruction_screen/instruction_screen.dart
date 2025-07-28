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
  final int totalSteps = 5;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    List<String> stepTitles = [
      l10n.instruction,
      l10n.carDetails,
      l10n.ownerDetails,
      l10n.clientDetails,
      l10n.clientDetails,
    ];

    String currentTitle =
    (currentStep < stepTitles.length) ? stepTitles[currentStep] : l10n.step;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: currentTitle,
              subTitle: "${AppLocalizations.of(context)!.step} ${currentStep+1} of $totalSteps"
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildProgressIndicator(),
                  const SizedBox(height: 20),
                  vGap(24),
                  Expanded(child: _buildStepContent(currentStep)),
                  _buildNavigationButtons(l10n),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Progress indicator
  Widget _buildProgressIndicator() {
    return Column(
      children: [
        _horizontalSelectiveButtonView(context),
        vGap(16),
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
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    height: 10,
                    width: progressWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor().darkYellowColor,
                    ),
                  ),
                  Positioned(
                    left: progressWidth - 16,
                    top: -12,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor().darkYellowColor,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${currentStep + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
            width: 65,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColor().darkCharcoalBlueColor
                  : AppColor().darkYellowColor,
              boxShadow: isActive
                  ? [
                BoxShadow(
                  color: AppColor().darkCharcoalBlueColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
                  : null,
            ),
            child: Center(
              child: Image.asset(
                icons[index],
                width: 32,
                height: 32,
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
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            redirectToWebPage("https://www.autoproof24.com/departure-guide/");
          },
          child: _buildGuideButton(l10n.departureGuide, arrowForwardRoundIcon),
        ),
        vGap(16),
        GestureDetector(
          onTap: () {
            redirectToWebPage("https://www.autoproof24.com/return-guide/");
          },
          child: _buildGuideButton(l10n.returnGuide, arrowForwardRoundIcon),
        ),
        vGap(32),
        CustomContainer(
          backgroundColor: AppColor().darkCharcoalBlueColor,
          borderRadius: BorderRadius.circular(12),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AP100001",
                style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkYellowColor,
                  size: 30,
                ),
              ),
              vGap(8),
              Text(
                l10n.inspectionNumber,
                style: TextStyle(
                  fontSize: 16,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor().darkYellowColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 18,
            ),
          ),
          Image.asset(
            icon,
            height: 35,
            width: 35,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: currentStep > 0 ? _previousStep : null,
            text: l10n.back,
            side: BorderSide.none,
          ),
        ),
        hGap(16),
        Expanded(
          child: CustomButton(
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
      case 4:
        return CarImInpectionScreen();
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
