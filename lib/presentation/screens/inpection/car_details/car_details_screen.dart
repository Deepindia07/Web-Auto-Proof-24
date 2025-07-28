part of "car_detail_route_imple.dart";

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarDetailsScreenBloc>(
      create: (context) => CarDetailsScreenBloc(),
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
  String? profileImagePath;
  final _formKey = GlobalKey<FormState>();
  final _numberPlateController = TextEditingController();
  final _tyreConditionsController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _mileageController = TextEditingController();
  final _kmDayController = TextEditingController();
  final _extraKmController = TextEditingController();
  final _priceTotalController = TextEditingController();
  final _commentController = TextEditingController();

  String selectedGasType = 'Diesel';
  String selectedGasLevel = '1/8';
  String selectedTyreCondition = 'Good';

  bool softPackYes = true;
  bool spareWheelYes = true;
  bool phoneOlderYes = true;
  bool gpsYes = true;
  bool chargingPortYes = true;
  bool carPapersYes = true;

  @override
  void initState() {
    super.initState();
    // Add listeners to text controllers
    _addControllerListeners();
  }

  void _addControllerListeners() {
    _numberPlateController.addListener(_updateCarDetails);
    _brandController.addListener(_updateCarDetails);
    _modelController.addListener(_updateCarDetails);
    _mileageController.addListener(_updateCarDetails);
    _tyreConditionsController.addListener(_updateCarDetails);
    _kmDayController.addListener(_updateCarDetails);
    _extraKmController.addListener(_updateCarDetails);
    _priceTotalController.addListener(_updateCarDetails);
    _commentController.addListener(_updateCarDetails);
  }

  void _updateCarDetails() {
    final carDetails = _createCarDetailsModel();
    context.read<CarDetailsScreenBloc>().add(UpdateCarDetailsEvent(carDetails: carDetails));
  }

  CarDetailsModel _createCarDetailsModel() {
    return CarDetailsModel(
      numberPlate: _numberPlateController.text,
      brand: _brandController.text,
      model: _modelController.text,
      mileage: _mileageController.text,
      gasType: selectedGasType,
      gasLevel: selectedGasLevel,
      tyreCondition: _tyreConditionsController.text,
      kmDay: _kmDayController.text,
      extraKm: _extraKmController.text,
      priceTotal: _priceTotalController.text,
      comment: _commentController.text,
      softPack: softPackYes,
      spareWheel: spareWheelYes,
      phoneOlder: phoneOlderYes,
      gps: gpsYes,
      chargingPort: chargingPortYes,
      carPapers: carPapersYes,
    );
  }

  @override
  void dispose() {
    _numberPlateController.dispose();
    _brandController.dispose();
    _tyreConditionsController.dispose();
    _modelController.dispose();
    _mileageController.dispose();
    _kmDayController.dispose();
    _extraKmController.dispose();
    _priceTotalController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_createCarDetailsModel().toJson());

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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInformationSection(),
                  SizedBox(height: 24),
                  _buildChecklistSection(),
                  SizedBox(height: 24),
                  _buildCommentSection(),
                  SizedBox(height: 24),
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
          children: [
            Text(
              AppLocalizations.of(context)!.information,
              style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor, size: 18),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
            Spacer(),
            CustomButton(
              side: BorderSide.none,
              onPressed: (){},
              borderRadius: 12,
              text: AppLocalizations.of(context)!.importInformation,
              textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkYellowColor,size: 14),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                hintText: AppLocalizations.of(context)!.numberPlateHint,
                label: AppLocalizations.of(context)!.numberPlate,
                controller: _numberPlateController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.brand,
                hintText: AppLocalizations.of(context)!.brandHint,
                controller: _brandController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.model,
                hintText: AppLocalizations.of(context)!.modelHint,
                controller: _modelController,
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        // Second row: Mileage, Gas Type, Gas Level
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                keyboardType: TextInputType.number,
                label: AppLocalizations.of(context)!.mileage,
                hintText: AppLocalizations.of(context)!.mileageHint,
                controller: _mileageController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildDropdownField(
                label: AppLocalizations.of(context)!.gasType,
                value: selectedGasType,
                items: [
                  RadioDropdownOption(value: 'Diesel', label: AppLocalizations.of(context)!.diesel),
                  RadioDropdownOption(value: 'Petrol', label: AppLocalizations.of(context)!.petrol),
                  RadioDropdownOption(value: 'Electric', label: AppLocalizations.of(context)!.electric),
                  RadioDropdownOption(value: 'Hybrid', label: AppLocalizations.of(context)!.hybrid),
                ],
                onChanged: (newValue) {
                  setState(() {
                    selectedGasType = newValue!;
                  });
                  _updateCarDetails();
                },
                isRequired: true,
                dropValue: 'Diesel',
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildDropdownField(
                label: AppLocalizations.of(context)!.gasLevel,
                value: selectedGasLevel,
                items: [
                  RadioDropdownOption(value: 'Empty', label: AppLocalizations.of(context)!.empty),
                  RadioDropdownOption(value: '1/8', label: AppLocalizations.of(context)!.oneEighth),
                  RadioDropdownOption(value: '2/8', label: AppLocalizations.of(context)!.twoEighths),
                  RadioDropdownOption(value: '3/8', label: AppLocalizations.of(context)!.threeEighths),
                  RadioDropdownOption(value: 'Half', label: AppLocalizations.of(context)!.half),
                  RadioDropdownOption(value: '5/8', label: AppLocalizations.of(context)!.fiveEighths),
                  RadioDropdownOption(value: '6/8', label: AppLocalizations.of(context)!.sixEighths),
                  RadioDropdownOption(value: '7/8', label: AppLocalizations.of(context)!.sevenEighths),
                  RadioDropdownOption(value: 'Full', label: AppLocalizations.of(context)!.full),
                ],
                onChanged: (newValue) {
                  setState(() {
                    selectedGasLevel = newValue!;
                  });
                  _updateCarDetails();
                },
                isRequired: true,
                dropValue: '1/8',
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.tyreCondition,
                hintText: AppLocalizations.of(context)!.tyreConditionHint,
                controller: _tyreConditionsController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                keyboardType: TextInputType.number,
                label: AppLocalizations.of(context)!.kmDay,
                controller: _kmDayController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                keyboardType: TextInputType.number,
                label: AppLocalizations.of(context)!.extraKm,
                controller: _extraKmController,
                hintText: AppLocalizations.of(context)!.euroSymbol,
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                keyboardType: TextInputType.number,
                label: AppLocalizations.of(context)!.priceTotal,
                controller: _priceTotalController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildFileUploadField(
                label: AppLocalizations.of(context)!.uploadInsurance,
                onTap: () {
                  _updateProfileImage(context);
                },
              ),
            ),
            // SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildImageField(
                label: AppLocalizations.of(context)!.insuranceFile,
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
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.checklist,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex:1,
              child: _buildSwitchField(
                label: AppLocalizations.of(context)!.softyPack,
                value: softPackYes,
                onChanged: (value) => setState(() => softPackYes = value),
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildSwitchField(
                label: AppLocalizations.of(context)!.spareWheel,
                value: spareWheelYes,
                onChanged: (value) => setState(() => spareWheelYes = value),
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
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
        SizedBox(height: 20),
        // Second row: GPS, Charging Port, Car Papers
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildSwitchField(
                label: AppLocalizations.of(context)!.chargingPort,
                value: chargingPortYes,
                onChanged: (value) => setState(() => chargingPortYes = value),
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
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
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 16),
        CustomTextField(
          controller: _commentController,
          maxLines: 3,
          fillColor: Colors.white,
          hintText: AppLocalizations.of(context)!.enterComments,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(size: 14, color: AppColor().silverShadeGrayColor),
        )
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType?keyboardType,
    String? hintText,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8),
        CustomTextField(
          controller:controller,
          hintText: hintText,
          keyboardType: keyboardType,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(size: 14, color: AppColor().silverShadeGrayColor),
          fillColor: AppColor().backgroundColor,
        )
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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8),
        RadioDropdownField(
          value: value,
          options: items,
          onChanged: onChanged, // Pass the callback directly
        )
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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8),
        CustomRectangularSwitch(
          value: value,
          width: 80,
          height: 40,
          inactiveColor: Colors.red,
          activeColor: Colors.green,
          onChanged: (newValue) {
            onChanged(newValue);
            _updateCarDetails(); // Trigger BLoC update
          },
        )
      ],
    );
  }

  Widget _buildFileUploadField({
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        CustomContainer(
          backgroundColor: AppColor().backgroundColor,
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          padding: EdgeInsets.symmetric(horizontal: 18,vertical: 5),
          border: Border.all(color: AppColor().darkCharcoalBlueColor.withOpacity(0.2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 32,
                color: Colors.grey[400],
              ),
              Text(
                AppLocalizations.of(context)!.dropTheFile,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildImageField({required String label}) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.black87,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              // insetPadding: EdgeInsets.all(16),
              child: Hero(
                tag: "unique_hero_tag",
                child: Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      child: Stack(
                        children: [
                          profileImagePath != null
                              ? Image.file(
                            File(profileImagePath!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.error_outline,
                                      size: 48,
                                      color: Colors.red[400],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      AppLocalizations.of(context)!.errorLoadingImage,
                                      style: TextStyle(
                                        color: Colors.red[400],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                              : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 48,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.noImageSelected,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Hero(
            tag: "unique_hero_tag",
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[50],
              ),
              child: profileImagePath != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(profileImagePath!),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 32,
                            color: Colors.red[400],
                          ),
                          SizedBox(height: 4),
                          Text(
                            AppLocalizations.of(context)!.errorLoadingImage,
                            style: TextStyle(
                              color: Colors.red[400],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
                  : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 32,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(context)!.noImageSelected,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
          profileImagePath = selectedImage.path;
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
          CherryToast.error(context, AppLocalizations.of(context)!.invalidImageFormat);
        }
      }
    } catch (e) {
      // Reset to previous state on error
      setState(() {
        profileImagePath = null;
      });
      CherryToast.error(context, AppLocalizations.of(context)!.errorSelectingImage(e.toString()));
    }
  }

  Future<String?> _getCurrentUserId() async {
    final userid = SharedPrefsHelper.instance.getString(userId);
    return userid;
  }
}