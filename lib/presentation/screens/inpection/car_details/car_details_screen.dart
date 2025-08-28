part of "car_detail_route_imple.dart";

class CarDetailsScreen extends StatelessWidget {
  CarDetailsScreen({super.key, required this.carDetailsScreenBloc});

  final CarDetailsScreenBloc carDetailsScreenBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: carDetailsScreenBloc,
      child: CarDetailsScreenView(),
    );
  }
}

class CarDetailsScreenView extends StatefulWidget {
  const CarDetailsScreenView({super.key});

  @override
  State<CarDetailsScreenView> createState() => _CarDetailsScreenViewState();
}

class _CarDetailsScreenViewState extends State<CarDetailsScreenView> {
  File? profileImagePath;
  final _formKey = GlobalKey<FormState>();
  var numberPlateController = TextEditingController();
  var tyreConditionsController = TextEditingController();
  var brandController = TextEditingController();
  var modelController = TextEditingController();
  var mileageController = TextEditingController();
  var kmDayController = TextEditingController(text: "200");
  var extraKmController = TextEditingController();
  var priceTotalController = TextEditingController();
  var commentController = TextEditingController();

  String selectedGasType = 'Diesel';
  String selectedGasLevel = '1/8';
  String selectedTyreCondition = 'Good';

  bool softPackYes = true;
  bool spareWheelYes = true;
  bool phoneOlderYes = true;
  bool gpsYes = true;
  bool chargingPortYes = true;
  bool carPapersYes = true;

  final gasTypeItems = const [
    'Diesel',
    'Petrol',
    "Hybrid",
    "LPG",
    "Electric",
    "Hydrogen",
    "Ethanol",
    "GNV",
    "Other",
  ];
  final gasLevelItems = const [
    '1/8',
    "2/8",
    "3/8",
    "Half",
    "5/8",
    "6/8",
    "7/8",
    "Full",
  ];
  final tyreConditionItems = const ['Good', "Bad", "New Tyres"];
  @override
  void initState() {
    super.initState();
    // Add listeners to text controllers
    addControllerListeners();
  }

  void addControllerListeners() {
    numberPlateController.addListener(updateCarDetails);
    brandController.addListener(updateCarDetails);
    modelController.addListener(updateCarDetails);
    mileageController.addListener(updateCarDetails);
    tyreConditionsController.addListener(updateCarDetails);
    kmDayController.addListener(updateCarDetails);
    extraKmController.addListener(updateCarDetails);
    priceTotalController.addListener(updateCarDetails);
    commentController.addListener(updateCarDetails);
  }

  CarDetails createCarDetailsModel() {
    return CarDetails(
      numberPlate: numberPlateController.text,
      brand: brandController.text,
      model: modelController.text,
      mileage: int.tryParse(mileageController.text),
      gasType: selectedGasType,
      gasLevel: selectedGasLevel,
      tyresCondition: selectedGasType,
      kmPerDay: int.tryParse(kmDayController.text),
      extraKm: int.tryParse(extraKmController.text),
      priceTotal: double.tryParse(priceTotalController.text),
      comments: commentController.text,
      checkList: CarCheckList(
        softyPack: softPackYes,
        spareWheels: spareWheelYes,
        gps: gpsYes,
        chargingPort: chargingPortYes,
        carPapers: carPapersYes,
      ),
    );
  }

  void updateCarDetails() {
    final carDetails = createCarDetailsModel();
    context.read<CarDetailsScreenBloc>().add(
      UpdateCarDetailsEvent(carDetails: carDetails),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("this is model data =====>${createCarDetailsModel().toJson()}");

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: BlocConsumer<CarDetailsScreenBloc, CarDetailsScreenState>(
        listener: (context, state) {
          if (state is CarDetailsScreenValidationError) {
            _showValidationErrors(state.errors);
          } else if (state is CarDetailsScreenSuccess) {
            // _navigateToNextScreen(state.carDetails);
          } else if (state is CarDetailsScreenError) {
            CherryToast.error(context, state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      AppLocalizations.of(context)!.carDetails,
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        size: 30,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  _buildInformationSection(),
                  SizedBox(height: 18), // Reduced from 24
                  _buildChecklistSection(),
                  SizedBox(height: 18), // Reduced from 24
                  _buildCommentSection(),
                  SizedBox(height: 18), // Reduced from 24
                  // _buildActionButtons(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.information,
                  style: MontserratStyles.montserratMediumTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: 16,
                  ),
                ),
                Text(' *', style: TextStyle(color: Colors.red)),
              ],
            ),

            CustomButton(
              width: 150,
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 40),
              side: BorderSide.none,
              onPressed: () {
                print("Button pressed");
                context.push(AppRoute.vehiclesScreenView);
                /*      Navigator.push(context, MaterialPageRoute(builder: (context) => VehiclesScreen()));*/
                setState(() {});
              },
              borderRadius: 10,
              text: AppLocalizations.of(context)!.addCar,
              textStyle: MontserratStyles.montserratMediumTextStyle(
                color: AppColor().darkYellowColor,
                size: 13,
              ),
            ),
          ],
        ),
        SizedBox(height: 20), // Reduced from 16
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                hintText: AppLocalizations.of(context)!.numberPlateHint,
                label: AppLocalizations.of(context)!.numberPlate,
                keyboardType: TextInputType.text,
                controller: numberPlateController,
                inputFormatters: [NumberPlateFormatter()],
                isRequired: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.brand,
                hintText: AppLocalizations.of(context)!.brandHint,
                keyboardType: TextInputType.text,
                controller: brandController,
                capitalText: TextCapitalization.words,
                isRequired: true,
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: "Car Name",
                keyboardType: TextInputType.text,
                hintText: "Car Name",
                controller: modelController,
                isRequired: true,
              ),
            ),  SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.model,
                keyboardType: TextInputType.text,
                hintText: AppLocalizations.of(context)!.modelHint,
                controller: modelController,
                isRequired: true,
              ),
            ),

          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [

            Expanded(
              flex: 1,
              child: _buildTextField(
                keyboardType: TextInputType.number,
                label: AppLocalizations.of(context)!.mileage,
                hintText: AppLocalizations.of(context)!.mileageHint,
                controller: mileageController,
                isRequired: true,
              ),
            ),  SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: CustomDropdownNew(
                isRequired: true,
                items: gasTypeItems,
                title: AppLocalizations.of(context)!.gasType,
                hint: AppLocalizations.of(context)!.selectGasType,
                value: selectedGasType,
                onChanged: (val) {
                  setState(() => selectedGasType = val!);
                },
              ),
            ),

          ],
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomDropdownNew(
                isRequired: true,
                items: gasLevelItems,
                title: AppLocalizations.of(context)!.gasLevel,
                hint: AppLocalizations.of(context)!.selectGasLevel,
                value: selectedGasLevel,
                onChanged: (val) {
                  setState(() => selectedGasLevel = val!);
                },
                textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              ),
            ),SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: CustomDropdownNew(
                isRequired: true,
                items: tyreConditionItems,
                title: AppLocalizations.of(context)!.tyreCondition,
                hint: 'Select ${AppLocalizations.of(context)!.tyreCondition}',
                value: selectedTyreCondition,
                onChanged: (val) {
                  setState(() => selectedTyreCondition = val!);
                },
                textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              ),
            ),

          ],
        ),

        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                keyboardType: TextInputType.number,
                label: AppLocalizations.of(context)!.kmDay,
                hintText: AppLocalizations.of(context)!.kmDay,
                controller: kmDayController,
                isRequired: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // only numbers
                  maxValueFormatter(200),
                ],
              ),
            ),SizedBox(width: 12), // Reduced from 8
            Expanded(
              flex: 1,
              child: _buildTextField(
                keyboardType: TextInputType.number,
                label: AppLocalizations.of(context)!.extraKm,
                controller: extraKmController,
                hintText: "0",
                isRequired: true,
              ),
            ),

          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [


            Expanded(
              flex: 1,
              child: _buildTextField(
                keyboardType: TextInputType.number,
                label: AppLocalizations.of(context)!.priceTotal,
                hintText: "0",
                controller: priceTotalController,
                isRequired: true,
              ),
            ),  SizedBox(width: 12), // Reduced from 8
            Expanded(
              child: CustomContainer(
                height: 90,
                backgroundColor: AppColor().backgroundColor,
                onTap: () {
                  _updateProfileImage(context);
                },
                borderRadius: BorderRadius.circular(10), // Reduced from 12
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 4,
                ), // Reduced padding
                border: Border.all(
                  color: AppColor().darkCharcoalBlueColor.withOpacity(0.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      uploadIcon,

                      height: 28, // Reduced from 32
                      width: 28, // Reduced from 32
                    ),
                    Text(
                      AppLocalizations.of(context)!.dropTheFile,
                      style: MontserratStyles.montserratMediumTextStyle(
                        size: 12,
                        color: AppColor().silverShadeGrayColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChecklistSection() {
    return Column(
      children: [
        Divider(color: AppColor().lightSilverGrayColor),
        SizedBox(height: 12),
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.checklist,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 16,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
            Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        SizedBox(height: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildSwitchField(
                    label: AppLocalizations.of(context)!.softyPack,
                    value: softPackYes,
                    onChanged: (value) => setState(() => softPackYes = value),
                    isRequired: true,
                  ),
                ),
                SizedBox(width: 6), // Reduced from 8
                Expanded(
                  flex: 1,
                  child: _buildSwitchField(
                    label: AppLocalizations.of(context)!.spareWheel,
                    value: spareWheelYes,
                    onChanged: (value) => setState(() => spareWheelYes = value),
                    isRequired: true,
                  ),
                ),
                SizedBox(width: 6), // Reduced from 8
                Expanded(
                  flex: 1,
                  child: _buildSwitchField(
                    label: AppLocalizations.of(context)!.phoneOlder,
                    value: phoneOlderYes,
                    onChanged: (value) => setState(() => phoneOlderYes = value),
                    isRequired: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16), // Reduced from 20
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildSwitchField(
                    label: AppLocalizations.of(context)!.gps,
                    value: gpsYes,
                    onChanged: (value) {
                      if (!value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                              AppLocalizations.of(context)!.gpsMandatory,
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else {
                        setState(() => gpsYes = value);
                      }
                    },
                    isRequired: true,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: _buildSwitchField(
                    label: AppLocalizations.of(context)!.chargingPort,
                    value: chargingPortYes,
                    onChanged: (value) =>
                        setState(() => chargingPortYes = value),
                    isRequired: true,
                  ),
                ),
                SizedBox(width: 6), // Reduced from 8
                Expanded(
                  flex: 1,
                  child: _buildSwitchField(
                    label: AppLocalizations.of(context)!.carPapers,
                    value: carPapersYes,
                    onChanged: (value) => setState(() => carPapersYes = value),
                    isRequired: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.comment,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 16,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12), // Reduced from 16
        CustomTextField(
          controller: commentController,
          maxLines: 3,
          fillColor: Colors.white,
          hintText: AppLocalizations.of(context)!.enterComments,
          hintStyle: MontserratStyles.montserratMediumTextStyle(
            size: 13,
            color: AppColor().silverShadeGrayColor,
          ), // Reduced from 14
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? hintText,
    String? errorText,
    TextCapitalization? capitalText,
    String? preText,
    int? maxLength,
    Widget? suffixText,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                label,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 15,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              ),
            ),
            if (isRequired) Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        const SizedBox(height: 6),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          prefixText: preText,
          suffixIcon: suffixText,
          maxLength: maxLength,
          textCapitalization: capitalText ?? TextCapitalization.none,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
            size: 13,
            color: AppColor().silverShadeGrayColor,
          ),
          fillColor: AppColor().backgroundColor,
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required String dropValue,
    required List<RadioDropdownOption> items,
    required ValueChanged<String?> onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              maxLines: 1, // ⬅️ force single line
              overflow: TextOverflow.ellipsis, // ⬅️ truncate if too long
              softWrap: false,
              style: TextStyle(
                fontSize: 13, // Reduced from 14
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            if (isRequired) Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        SizedBox(height: 6), // Reduced from 8
        RadioDropdownField(
          value: value,
          options: items,
          onChanged: onChanged, // Pass the callback directly
        ),
      ],
    );
  }

  Widget _buildSwitchField({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: MontserratStyles.montserratMediumTextStyle(
                size: 12,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
            if (isRequired) Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        SizedBox(height: 6), // Reduced from 8
        CustomRectangularSwitch(
          value: value,
          width: 70, // Reduced from 80
          height: 35, // Reduced from 40
          inactiveColor: Colors.red,
          activeColor: Colors.green,
          onChanged: (newValue) {
            onChanged(newValue);
            updateCarDetails(); // Trigger BLoC update
          },
        ),
      ],
    );
  }

  TextInputFormatter maxValueFormatter(int max) {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;

      final int? value = int.tryParse(newValue.text);
      if (value == null) return oldValue;

      if (value > max) {
        return oldValue; // block input > max
      }
      return newValue;
    });
  }

  Widget _buildImageUploadField({required String label}) {
    void _openFullScreenImage(BuildContext context) {
      if (profileImagePath == null) return;

      showDialog(
        context: context,
        barrierColor: Colors.black87,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(profileImagePath!, fit: BoxFit.contain),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return InkWell(
      onTap: () => _updateProfileImage(context),
      child: Container(
        height: 140,
        width: 240,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor().borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: profileImagePath != null
            ? Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      profileImagePath!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: GestureDetector(
                      onTap: () => _openFullScreenImage(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon/ic_upload.png",
                    height: 32,
                    width: 32,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Tap to Upload Insurance",
                    style: TextStyle(color: Color(0xFF979DA3), fontSize: 12),
                  ),
                ],
              ),
      ),
    );
  }

  void _showValidationErrors(List<String> errors) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.validationErrors),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: errors.map((error) => Text('• $error')).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.ok),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfileImage(BuildContext context) async {
    try {
      final selectedImage = await CustomImageSelector.show(
        context,
        title: AppLocalizations.of(context)!.updateProfilePicture,
        primaryColor: AppColor().darkYellowColor,
      );

      if (selectedImage != null) {
        // Show the selected image immediately for better UX
        setState(() {
          profileImagePath = File(selectedImage.path);
        });

        final userId = await _getCurrentUserId();
        final mimeType = lookupMimeType(selectedImage.path);
        final mimeParts = mimeType?.split('/');

        if (mimeParts != null && mimeParts.length == 2 && userId != null) {
          final formData = FormData.fromMap({
            "profileImage": await MultipartFile.fromFile(
              selectedImage.path,
              filename: selectedImage.path.split('/').last,
              // contentType: MediaType(mimeParts[0], mimeParts[1]),
            ),
          });

          // context.read<HomeScreenBloc>().add(
          //   UpdateProfileImageEvent(
          //     multipartBody: formData,
          //     userId: userId,
          //     profileDataBody: {},
          //   ),
          // );

          print("Image format: $mimeType");
        } else {
          // Reset to previous state if validation fails
          setState(() {
            profileImagePath = null;
          });
          CherryToast.error(
            context,
            AppLocalizations.of(context)!.invalidImageFormat,
          );
        }
      }
    } catch (e) {
      // Reset to previous state on error
      setState(() {
        profileImagePath = null;
      });
      CherryToast.error(
        context,
        AppLocalizations.of(context)!.errorSelectingImage(e.toString()),
      );
    }
  }

  Future<String?> _getCurrentUserId() async {
    final userid = SharedPrefsHelper.instance.getString(userId);
    return userid;
  }
}

class NumberPlateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.toUpperCase().replaceAll(
      RegExp(r'[^A-Z0-9]'),
      '',
    );
    StringBuffer buffer = StringBuffer();

    int index = 0;

    // First 2 letters (W W)
    if (digits.length > index) {
      buffer.write(
        digits.substring(index, (index + 2).clamp(0, digits.length)),
      );
      index += 2;
    }

    // Hyphen
    if (digits.length > 2) buffer.write('-');

    // Next 3 digits (0 0 0)
    if (digits.length > index) {
      int end = (index + 3).clamp(0, digits.length);
      buffer.write(digits.substring(index, end));
      index = end;
    }

    // Hyphen
    if (digits.length > 5) buffer.write('-');

    // Last 2 letters (Y Y)
    if (digits.length > index) {
      int end = (index + 2).clamp(0, digits.length);
      buffer.write(digits.substring(index, end));
      index = end;
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
