part of 'instruction_screen_route_imple.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InstructionScreenBloc>(
      create: (context) => InstructionScreenBloc(),
      child: InstructionScreenView(),
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

  List<String> stepTitles = [
    "Instruction",
    "Car Details",
    "Owner Details",
    "Client Details",
    "Client Details"
  ];

  @override
  Widget build(BuildContext context) {
    String currentTitle = (currentStep < stepTitles.length)
        ? stepTitles[currentStep]
        : "Step";
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "$currentTitle",
            subTitle: "Step ${currentStep + 1} of $totalSteps",
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Progress indicator
                  _buildProgressIndicator(),
                  const SizedBox(height: 20),
                  vGap(24),
                  Expanded(
                    child: _buildStepContent(currentStep),
                  ),
                  _buildNavigationButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// progress indicator
  Widget _buildProgressIndicator() {
    return Column(
      children: [
        _horizontalSelectiveButtonView(context),
        vGap(16),
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
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
                  // Progress yellow fill
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
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${currentStep + 1}',
                        style: TextStyle(
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
    final icons = [
      alertIcon,
      carFrontIcon,
      passIcon,
      personDarkIcon,
      cameraIcon
    ];

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
                  ?  AppColor().darkCharcoalBlueColor
                  : (isCompleted
                  ?  AppColor().darkYellowColor
                  : AppColor().darkYellowColor),
              boxShadow: isActive ? [
                BoxShadow(
                  color:  AppColor().darkCharcoalBlueColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Center(
              child: Image.asset(
                icons[index],
                width: 32, // Was 12
                height: 32, // Was 12
                color: isActive ? AppColor().darkYellowColor : AppColor().darkCharcoalBlueColor,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContentArea() {
    return Column(
      children: [
        // Guide buttons
        GestureDetector(
          onTap: (){
            redirectToWebPage("https://www.autoproof24.com/departure-guide/");
          },
          child: _buildGuideButton("Departure Guide", arrowForwardRoundIcon),
        ),
        vGap(16),
        GestureDetector(
          onTap: () {
            redirectToWebPage("https://www.autoproof24.com/return-guide/");
          },
          child: _buildGuideButton("Return Guide", arrowForwardRoundIcon),
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
                  style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkYellowColor,size: 30)
              ),
              vGap(8),
              Text(
                "Inspection Number",
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
            style: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().darkCharcoalBlueColor,size: 18)
          ),
          Image.asset(icon, height: 35,width: 35,color: AppColor().darkCharcoalBlueColor,),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(child: CustomButton(
          onPressed: currentStep > 0 ? _previousStep : null,
          text: "Back",
          side: BorderSide.none,
        )),

         hGap(16),
        Expanded(
          child: CustomButton(
              onPressed: currentStep < totalSteps - 1 ? _nextStep : (){
                context.push(AppRoute.ownerSignatureViewScreen);
              },
              text: "Next",
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

  // void _handleGuideButtonTap(String guideType) {
  //
  //
  // }

  Widget _buildStepContent(int currentStep) {
    switch (currentStep) {
      case 0:
        return _buildStep0();
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      case 4:
        return _buildStep4();
      default:
        return _buildStep0();
    }
  }

  Widget _buildStep0() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Welcome to Vehicle Inspection",
          //   style: MontserratStyles.montserratBoldTextStyle(
          //     color: AppColor().darkCharcoalBlueColor,
          //     size: 24,
          //   ),
          // ),
          // vGap(16),
          // Text(
          //   "Please follow the instructions carefully to complete your vehicle inspection process.",
          //   style: MontserratStyles.montserratRegularTextStyle(
          //     color: AppColor().darkCharcoalBlueColor,
          //     size: 16,
          //   ),
          // ),
          // vGap(24),
          _buildContentArea(),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return CarDetailsScreen();
  }

  Widget _buildStep2() {
    return OwnerDetailsScreen();
  }

  Widget _buildStep3() {
    return ClientDetailsScreen();
  }

  Widget _buildStep4() {
    return CarImInpectionScreen();
  }
}