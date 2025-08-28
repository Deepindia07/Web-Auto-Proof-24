part of 'instruction_screen_route_imple.dart';

/*class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InstructionScreenBloc>(
      create: (context) =>
          InstructionScreenBloc(repository: AuthenticationApiCall()),
      child: const InstructionScreenView(),
    );
  }
}*/
class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Create bloc instances here
    final carDetailsBloc = CarDetailsScreenBloc();
    final ownerDetailsBloc = OwnerDetailsScreenBloc(
      authenticationApiCall: AuthenticationApiCall(),
    );
    final clientDetailsBloc = ClientDetailsScreenBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CarDetailsScreenBloc>.value(value: carDetailsBloc),
        BlocProvider<OwnerDetailsScreenBloc>.value(value: ownerDetailsBloc),
        BlocProvider<ClientDetailsScreenBloc>.value(value: clientDetailsBloc),
      ],
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
  final int totalSteps = 3;

  late final CarDetailsScreenBloc _carDetailsScreenBloc;
  late final OwnerDetailsScreenBloc _ownerDetailsScreenBloc;
  late final ClientDetailsScreenBloc _clientDetailsScreenBloc;
  CarDetailsModel? carDetailsModel;

  @override
  void initState() {
    super.initState();
    _carDetailsScreenBloc = CarDetailsScreenBloc();
    _ownerDetailsScreenBloc = OwnerDetailsScreenBloc(
      authenticationApiCall: AuthenticationApiCall(),
    );
    _clientDetailsScreenBloc = ClientDetailsScreenBloc();

    carDetailsModel = CarDetailsModel();
  }

  @override
  void dispose() {
    _carDetailsScreenBloc.close();
    _ownerDetailsScreenBloc.close();
    _clientDetailsScreenBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    List<String> stepTitles = [
      l10n.instruction,
      l10n.carDetails,
      l10n.agentDetails,
      l10n.clientDetails,
      /*  l10n.clientDetails,*/
    ];

    String currentTitle = (currentStep < stepTitles.length)
        ? stepTitles[currentStep]
        : l10n.step;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _buildProgressIndicator(),
                  vGap(16),
                  Expanded(child: _buildStepContent(currentStep)),
                  _buildNavigationButtons(l10n),
                  vGap(10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    const double circleSize = 24; // step circle size
    return Column(
      children: [
        _horizontalSelectiveButtonView(context), // icons above
        vGap(12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double fullWidth = constraints.maxWidth;
              double progressPercent = (currentStep + 1) / totalSteps;

              // ✅ Exact circle center
              double progressCenter =
                  (fullWidth - circleSize) * progressPercent;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Grey background line
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey[300],
                    ),
                  ),

                  // ✅ Yellow progress bar up to circle center
                  Container(
                    height: 8,
                    width: progressCenter + (circleSize / 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColor().darkYellowColor,
                    ),
                  ),

                  // ✅ Circle (aligned to icon above)
                  Positioned(
                    left: progressCenter,
                    top: -(circleSize / 2), // puts circle under icon
                    child: Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor().darkYellowColor,
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${currentStep + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
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
      cameraIcon,
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
                        color: AppColor().darkCharcoalBlueColor.withOpacity(
                          0.3,
                        ),
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
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            redirectToWebPage("https://www.autoproof24.com/departure-guide/");
          },
          child: _buildGuideButton(l10n.departureGuide, arrowForwardRoundIcon),
        ),
        vGap(12), // Reduced from 16
        GestureDetector(
          onTap: () {
            redirectToWebPage("https://www.autoproof24.com/return-guide/");
          },
          child: _buildGuideButton(l10n.returnGuide, arrowForwardRoundIcon),
        ),
      ],
    );
  }

  Widget _buildGuideButton(String title, String icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ), // Reduced padding
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
      ),
    );
  }

  Widget _buildNavigationButtons(AppLocalizations l10n) {
    return Row(
      children: [
        if (currentStep != 0)
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
          child: BlocConsumer<OwnerDetailsScreenBloc, OwnerDetailsScreenState>(
            listener: (context, state) {
              if (state is OnSubmittingAgentLoading) {}

              if (state is OnSubmittingAgentLoaded) {
                print("Owner details submitted successfully.");
                if (Navigator.canPop(context)) Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => const AlertDialog(
                    title: Text("✅ Success"),
                    content: Text("Owner details submitted successfully."),
                  ),
                  useRootNavigator: true,
                );
              }

              if (state is OnSubmittingAgentLoadedError) {
                if (Navigator.canPop(context)) Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("❌ Error"),
                    content: Text(state.message),
                  ),
                  useRootNavigator: true,
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                textColor: AppColor().darkYellowColor,
                onPressed: _nextStep,
                text: currentStep < totalSteps - 1 ? l10n.next : "Submit",
                side: BorderSide.none,
              );
            },
          ),
        ),
      ],
    );
  }

  void _nextStep() {
    String? validationError;

    if (currentStep == 1) {
      final carDetails = _carDetailsScreenBloc.getCurrentCarDetails();
      carDetailsModel ??= CarDetailsModel();

      if (carDetails.numberPlate?.isEmpty ?? true) {
        validationError = "Number Plate is required";
      } else if (!RegExp(
        r'^[A-Z]{2}-\d{3}-\d{2}$',
      ).hasMatch(carDetails.numberPlate!)) {
        validationError = "Enter valid number plate (e.g. AB-123-45)";
      } else if (carDetails.brand?.isEmpty ?? true) {
        validationError = "Brand is required";
      } else if (carDetails.model?.isEmpty ?? true) {
        validationError = "Model is required";
      } else if (carDetails.mileage == null) {
        validationError = "Mileage is required";
      } else if (carDetails.gasType == "Select") {
        validationError = "Select Gas type";
      } else if (carDetails.gasLevel == "Select") {
        validationError = "Select Gas Level";
      } else if (carDetails.tyresCondition == "Select") {
        validationError = "Tyres condition is required";
      } else if (carDetails.kmPerDay == null) {
        validationError = "Per day km is required";
      } else if (carDetails.extraKm == null) {
        validationError = "Extra km is required";
      } else if (carDetails.priceTotal == null) {
        validationError = "Price is required";
      }

      if (validationError != null) {
        _showValidationErrors(validationError);
        return;
      }

      carDetailsModel!.carDetails = CarDetails(
        numberPlate: carDetails.numberPlate,
        brand: carDetails.brand,
        model: carDetails.model,
        mileage: carDetails.mileage,
        gasType: carDetails.gasType,
        gasLevel: carDetails.gasLevel,
        tyresCondition: carDetails.tyresCondition,
        kmPerDay: carDetails.kmPerDay,
        extraKm: carDetails.extraKm,
        priceTotal: carDetails.priceTotal,
        comments: carDetails.comments,
        checkList: CarCheckList(
          softyPack: carDetails.checkList?.softyPack ?? false,
          spareWheels: carDetails.checkList?.spareWheels ?? false,
          gps: carDetails.checkList?.gps ?? false,
          chargingPort: carDetails.checkList?.chargingPort ?? false,
          carPapers: carDetails.checkList?.carPapers ?? false,
        ),
      );

      debugPrint("After step 1 ====> ${carDetailsModel!.toJson()}");
    }

    if (currentStep == 2) {
      final ownerDetails = _ownerDetailsScreenBloc.getCurrentCarDetails();
      carDetailsModel ??= CarDetailsModel();

      if (ownerDetails.firstName?.isEmpty ?? true) {
        validationError = "Please enter first name";
      } else if (ownerDetails.lastName?.isEmpty ?? true) {
        validationError = "Please enter last name";
      } else if (ownerDetails.phoneNumber?.isEmpty ?? true) {
        validationError = "Please enter Phone Number";
      } else if (ownerDetails.phoneNumber!.length < 10) {
        validationError = "Please enter valid phone number";
      } else if (ownerDetails.email?.isEmpty ?? true) {
        validationError = "Please enter registered email";
      } else if (ownerDetails.address?.isEmpty ?? true) {
        validationError = "Please enter address";
      }

      if (validationError != null) {
        _showValidationErrors(validationError);
        return;
      }

      carDetailsModel!.ownerDetails = OwnerDetails(
        firstName: ownerDetails.firstName,
        lastName: ownerDetails.lastName,
        phoneNumber: ownerDetails.phoneNumber,
        email: ownerDetails.email,
        address: ownerDetails.address,
        countryCode: ownerDetails.countryCode,
        gender: ownerDetails.gender,
        inspectId: ownerDetails.inspectId,
        checkList: OwnerCheckList(
          driverIdPhoto: true,
          driverLicensePhoto: true,
        ),
      );

      carDetailsModel?.inspectorId = carDetailsModel?.ownerDetails?.inspectId;

      debugPrint("After step 2 ====> ${carDetailsModel!.toJson()}");

      // ✅ Submit API on last step
      _ownerDetailsScreenBloc.add(
        OnSubmittingAgentDataEvent(
          carDetails: carDetailsModel!.carDetails,
          ownerDetails: carDetailsModel!.ownerDetails,
          inspectorId: carDetailsModel?.ownerDetails?.inspectId,
        ),
      );
    }

    // ✅ Only go to next step if not last
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
        return CarDetailsScreen(carDetailsScreenBloc: _carDetailsScreenBloc);
      case 2:
        return OwnerDetailsScreen(
          ownerDetailsScreenBloc: _ownerDetailsScreenBloc,
          onScreenChange: (screen, {inspectorId}) {
            // Handle navigation or state here
            debugPrint("Navigated to $screen with inspectorId: $inspectorId");
          },
        );
      /*  case 3:
        return ClientDetailsScreen(bloc: _clientDetailsScreenBloc);*/
      default:
        return _buildStep0();
    }
  }

  Widget _buildStep0() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildContentArea()],
      ),
    );
  }

  void _showValidationErrors(String errors) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      content: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 10 * (1 - value)), // slide up
              child: child,
            ),
          );
        },
        child: Text(
          errors,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}









/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import your blocs & models
// import 'car_details_screen_bloc.dart';
// import 'owner_details_screen_bloc.dart';
// import 'client_details_screen_bloc.dart';
// import 'models.dart';
// import 'api/authentication_api_call.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Create bloc instances here
    final carDetailsBloc = CarDetailsScreenBloc();
    final ownerDetailsBloc = OwnerDetailsScreenBloc(
      authenticationApiCall: AuthenticationApiCall(),
    );
    final clientDetailsBloc = ClientDetailsScreenBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider<CarDetailsScreenBloc>.value(value: carDetailsBloc),
        BlocProvider<OwnerDetailsScreenBloc>.value(value: ownerDetailsBloc),
        BlocProvider<ClientDetailsScreenBloc>.value(value: clientDetailsBloc),
      ],
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
  late CarDetailsScreenBloc _carDetailsScreenBloc;
  late OwnerDetailsScreenBloc _ownerDetailsScreenBloc;
  late ClientDetailsScreenBloc _clientDetailsScreenBloc;

  int currentStep = 0;
  final int totalSteps = 3;
  CarDetailsModel? carDetailsModel;

  @override
  void initState() {
    super.initState();
    _carDetailsScreenBloc = context.read<CarDetailsScreenBloc>();
    _ownerDetailsScreenBloc = context.read<OwnerDetailsScreenBloc>();
    _clientDetailsScreenBloc = context.read<ClientDetailsScreenBloc>();
    carDetailsModel = CarDetailsModel();
  }

  void _showValidationErrors(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _nextStep() {
    String? validationError;

    if (currentStep == 0) {
      final carDetails = _carDetailsScreenBloc.getCurrentCarDetails();
      carDetailsModel ??= CarDetailsModel();

      if (carDetails.numberPlate?.isEmpty ?? true) {
        validationError = "Number Plate is required";
      } else if (!RegExp(r'^[A-Z]{2}-\d{3}-\d{2}$')
          .hasMatch(carDetails.numberPlate!)) {
        validationError = "Enter valid number plate (e.g. AB-123-45)";
      } else if (carDetails.brand?.isEmpty ?? true) {
        validationError = "Brand is required";
      } else if (carDetails.model?.isEmpty ?? true) {
        validationError = "Model is required";
      } else if (carDetails.mileage == null) {
        validationError = "Mileage is required";
      } else if (carDetails.gasType == "Select") {
        validationError = "Select Gas type";
      } else if (carDetails.gasLevel == "Select") {
        validationError = "Select Gas Level";
      } else if (carDetails.tyresCondition == "Select") {
        validationError = "Tyres condition is required";
      } else if (carDetails.kmPerDay == null) {
        validationError = "Per day km is required";
      } else if (carDetails.extraKm == null) {
        validationError = "Extra km is required";
      } else if (carDetails.priceTotal == null) {
        validationError = "Price is required";
      }

      if (validationError != null) {
        _showValidationErrors(validationError);
        return;
      }

      carDetailsModel!.carDetails = carDetails;
      debugPrint("After step 1 ====> ${carDetailsModel!.toJson()}");
    }

    if (currentStep == 1) {
      final ownerDetails = _ownerDetailsScreenBloc.getCurrentCarDetails();
      carDetailsModel ??= CarDetailsModel();

      if (ownerDetails.firstName?.isEmpty ?? true) {
        validationError = "Please enter first name";
      } else if (ownerDetails.lastName?.isEmpty ?? true) {
        validationError = "Please enter last name";
      } else if (ownerDetails.phoneNumber?.isEmpty ?? true) {
        validationError = "Please enter Phone Number";
      } else if (ownerDetails.phoneNumber!.length < 10) {
        validationError = "Please enter valid phone number";
      } else if (ownerDetails.email?.isEmpty ?? true) {
        validationError = "Please enter registered email";
      } else if (ownerDetails.address?.isEmpty ?? true) {
        validationError = "Please enter address";
      }

      if (validationError != null) {
        _showValidationErrors(validationError);
        return;
      }

      carDetailsModel!.ownerDetails = ownerDetails;
      carDetailsModel?.inspectorId = ownerDetails.inspectId;

      debugPrint("After step 2 ====> ${carDetailsModel!.toJson()}");

      // ✅ Trigger API call
      _ownerDetailsScreenBloc.add(
        OnSubmittingAgentDataEvent(
          carDetails: carDetailsModel!.carDetails,
          ownerDetails: carDetailsModel!.ownerDetails,
          inspectorId: carDetailsModel?.inspectorId,
        ),
      );
    }

    if (currentStep < totalSteps - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void _submitFinalStep() {
    // ✅ Final submit action (step 3)
    debugPrint("Submitting Final Data ====> ${carDetailsModel!.toJson()}");

    _clientDetailsScreenBloc.add(
      OnFinalSubmitEvent(carDetailsModel: carDetailsModel!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Instruction Steps")),
      body: BlocConsumer<OwnerDetailsScreenBloc, OwnerDetailsScreenState>(
        listener: (context, state) {
          if (state is OnSubmittingAgentLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
              useRootNavigator: true,
            );
          } else if (state is OnSubmittingAgentSuccess) {
            Navigator.of(context, rootNavigator: true).pop(); // close loader
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Inspector ID successfully created")),
            );
          } else if (state is OnSubmittingAgentFailure) {
            Navigator.of(context, rootNavigator: true).pop(); // close loader
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.error}")),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Text("Step $currentStep of $totalSteps"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    if (currentStep > 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentStep--;
                            });
                          },
                          child: const Text("Back"),
                        ),
                      ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: currentStep < totalSteps - 1
                            ? _nextStep
                            : _submitFinalStep,
                        child: Text(
                          currentStep < totalSteps - 1 ? "Next" : "Submit",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}*/
