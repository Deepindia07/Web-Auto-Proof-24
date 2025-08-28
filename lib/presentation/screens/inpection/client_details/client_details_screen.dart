part of 'client_details_screen_route_imple.dart';

class ClientDetailsScreen extends StatelessWidget {
  const ClientDetailsScreen({super.key, required this.bloc});

  final ClientDetailsScreenBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: bloc, child: ClientDetailsScreenView());
  }
}

class ClientDetailsScreenView extends StatefulWidget {
  const ClientDetailsScreenView({super.key});

  @override
  State<ClientDetailsScreenView> createState() =>
      _ClientDetailsScreenViewState();
}

class _ClientDetailsScreenViewState extends State<ClientDetailsScreenView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _drivingLicenseController =
      TextEditingController();
  final TextEditingController _dateOfIssueController = TextEditingController();
  final TextEditingController _rentalDurationController =
      TextEditingController();
  final TextEditingController _leaseStartDateController =
      TextEditingController(); // Added missing controller
  final TextEditingController _leaseEndDateTimeController =
      TextEditingController();
  final TextEditingController _commentController =
      TextEditingController(); // Added missing controller

  bool _isDrivingLicense = false;
  bool _isDriverId = false;
  DateTime? _leaseStartDate = DateTime.now();
  DateTime? _leaseEndDate;

  @override
  void initState() {
    super.initState();
    _addListenerOwnerDetailsListener();
  }

  void _addListenerOwnerDetailsListener() {
    _firstNameController.addListener(_updateOwnerDetails);
    _lastNameController.addListener(_updateOwnerDetails);
    _addressController.addListener(_updateOwnerDetails);
    _mobileController.addListener(_updateOwnerDetails);
    _emailController.addListener(_updateOwnerDetails);
  }

  void _updateOwnerDetails() {
    final ownerDetails = _createOwnerDetails();
    context.read<ClientDetailsScreenBloc>().add(
      UpdateClientDetailsScreenEvent(carDetailsModel: ownerDetails),
    );
  }

  ClientDetails _createOwnerDetails() {
    return ClientDetails(
      firstName: _firstNameController.text.isNotEmpty
          ? _firstNameController.text
          : null,
      lastName: _lastNameController.text.isNotEmpty
          ? _lastNameController.text
          : null,
      birthdate: "1990-05-15",
      countryCode: "+91",
      phoneNumber: "9999988888",
      email: "client@example.com",
      address: _addressController.text.isNotEmpty
          ? _addressController.text
          : null,
      gender: "FEMALE",
      drivingLicenseNumber: "DL123456789",
      dateOfIssue: "2025-08-01T10:00:00Z",
      rentalDuration: 4,
      leaseStartDate: "2025-08-01T10:00:00Z",
      leaseEndDate: "2025-08-08T10:00:00Z",
      comments: _commentController.text.isNotEmpty
          ? _commentController.text
          : null,
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _birthDayController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _drivingLicenseController.dispose();
    _dateOfIssueController.dispose();
    _rentalDurationController.dispose();
    _leaseStartDateController.dispose(); // Fixed: added missing disposal
    _leaseEndDateTimeController.dispose();
    _commentController.dispose(); // Fixed: added missing disposal
    super.dispose();
  }

  void _updateDriverLicense(bool value) {
    setState(() {
      _isDrivingLicense = value;
    });
    context.read<ClientDetailsScreenBloc>().add(
      UpdateClientLicenseEvent(isDriverLicense: value),
    );
  }

  void _updateDriverId(bool value) {
    setState(() {
      _isDriverId = value;
    });
    context.read<ClientDetailsScreenBloc>().add(
      UpdateClientIdEvent(isDriverId: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusScopeNode());
        },
        child: BlocBuilder<ClientDetailsScreenBloc, ClientDetailsScreenState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Form(child: _buildInformationSection()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.clientDetails,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              size: 30,
              color: AppColor().darkCharcoalBlueColor,
            ),
          ),
        ),

        vGap(20),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.firstName,
                hintText: AppLocalizations.of(context)!.firstName,
                controller: _firstNameController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.lastName,
                hintText: AppLocalizations.of(context)!.lastName,
                controller: _lastNameController,
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        _buildBirthDatePicker(context), SizedBox(height: 10),
        // Contact info row
        _buildTextField(
          label: AppLocalizations.of(context)!.email,
          hintText: 'abcd@gmail.com',
          /*  keyboard: TextInputType.emailAddress,*/
          controller: _emailController,
          isRequired: true,
        ),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.phoneNumber,
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: 15,
                  ),
                ),
                Text(' *', style: TextStyle(color: Colors.red, fontSize: 12)),
              ],
            ),
            SizedBox(height: 3),
            Row(
              children: [
                CustomContainer(
                  width: 112,
                  margin: EdgeInsets.only(right: 10),
                  border: Border.all(
                    color: AppColor().darkCharcoalBlueColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  backgroundColor: AppColor().backgroundColor,
                  padding: const EdgeInsets.all(7),
                  child: CountryCodePicker(
                    onChanged: (CountryCode countryCode) {
                      // setState(() {
                      //   selectedCountryCode = countryCode.toString();
                      //   _isPhoneVerified = false;
                      // });
                      print("Selected Country: ${countryCode.name}");
                      print("Selected Code: ${countryCode.dialCode}");
                    },
                    initialSelection: 'FR',
                    favorite: const ["+33"],
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                    textStyle: TextStyle(
                      color: AppColor().darkCharcoalBlueColor,
                      fontSize: 16,
                    ),
                    dialogTextStyle: TextStyle(
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                    searchStyle: TextStyle(
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                    searchDecoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      hintText: 'Search country',
                      hintStyle: TextStyle(
                        color: AppColor().darkCharcoalBlueColor.withOpacity(
                          0.6,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                    ),
                    dialogBackgroundColor: AppColor().backgroundColor,
                    barrierColor: Colors.black54,
                    dialogSize: Size(
                      MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.6,
                    ),
                    builder: (countryCode) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (countryCode != null)
                            Image.asset(
                              countryCode.flagUri!,
                              package: 'country_code_picker',
                              width: 24,
                              height: 18,
                              fit: BoxFit.fill,
                            ),
                          const SizedBox(width: 8),
                          Text(
                            countryCode!.dialCode ?? '',
                            style: TextStyle(
                              color: AppColor().darkCharcoalBlueColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    maxLines: 1,
                    fillColor: AppColor().backgroundColor,
                    controller: _mobileController,
                    hintText: "Enter phone number",
                    keyboardType: TextInputType.phone,
                    inputFormatters: [],
                    hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
                      color: AppColor().silverShadeGrayColor.withOpacity(0.5),
                      size: 11,
                    ),
                    borderRadius: 8,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),

        // Address field
        _buildTextField(
          maxLines: 3,
          label: AppLocalizations.of(context)!.address,
          hintText: AppLocalizations.of(context)!.address,
          controller: _addressController,
          isRequired: true,
        ),
        SizedBox(height: 10),

        // License info row
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.drivingLicense,
                hintText: "00-000-00",
                controller: _drivingLicenseController,
                isRequired: true,
                inputFormatters: [NumberPlateFormatter()],
              ),
            ),
            SizedBox(width: 8),
            Expanded(child: _buildIssueDatePicker(context)),
          ],
        ),
        SizedBox(height: 10),

        // Rental info row
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.rentalDuration,
                hintText: "2",
                controller: _rentalDurationController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 10),
            Expanded(child: _buildLeaseDatePickers(context)),
      ]  ),
        SizedBox(height: 10),
        SizedBox(width: 10),
        _buildLeaseDatePickers(context),

        /* // Lease end date
        _buildLeaseEndDate(),*/
        SizedBox(height: 12),

        _buildTextField(
          maxLines: 3,
          label: "Comments",
          /*  maxLine: 3,*/
          hintText: 'Enter comments',
          controller: _commentController,
          isRequired: false,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.checklist,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: 20, // Reduced from 18
              ),
            ),
            Text(' *', style: TextStyle(color: Colors.red)),
          ],
        ),
        vGap(15),
        _buildCompactCheckList(
          label: AppLocalizations.of(context)!.checklist,
          title: AppLocalizations.of(context)!.licenseInstruction,
          value: _isDrivingLicense,
          onChanged: _updateDriverLicense,
        ),
        SizedBox(height: 10),

        _buildCompactCheckList(
          label: AppLocalizations.of(context)!.checklist,
          title: AppLocalizations.of(context)!.licenseInstructionId,
          value: _isDriverId,
          onChanged: _updateDriverId,
        ),

        // BlocBuilder<ClientDetailsScreenBloc, ClientDetailsScreenState>(
        //   builder: (context, state) {
        //     if (state is ClientDetailsScreenLoaded) {
        //       return Container(
        //         padding: EdgeInsets.all(12), // Reduced from 16
        //         margin: EdgeInsets.symmetric(vertical: 4), // Reduced margin
        //         decoration: BoxDecoration(
        //           color: Colors.grey[100],
        //           borderRadius: BorderRadius.circular(6), // Reduced radius
        //         ),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Text('Current Data in BLoC:',
        //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        //             SizedBox(height: 6), // Reduced spacing
        //             ...[ // More compact data display
        //               'Name: ${state.carOwnerDetails.clientDetails?.firstName} ${state.carOwnerDetails..clientDetails?.lastName}',
        //               'Mobile: ${state.carOwnerDetails.clientDetails?.phoneNumber}',
        //               'Email: ${state.carOwnerDetails.clientDetails?.email}',
        //               'Address: ${state.carOwnerDetails.clientDetails?.address}',
        //               'Driver License: ${state.carOwnerDetails.clientDetails?.drivingLicenseNumber}',
        //               // 'Driver ID: ${state.carOwnerDetails.clientDetails?.isDriverId}',
        //             ].map((text) => Padding(
        //               padding: EdgeInsets.only(bottom: 2),
        //               child: Text(text, style: TextStyle(fontSize: 11)),
        //             )).toList(),
        //           ],
        //         ),
        //       );
        //     }
        //     return SizedBox.shrink();
        //   },
        // ),
      ],
    );
  }
  Widget _buildLeaseEndDate(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(AppLocalizations.of(context)!.selectLeaseEndDate, style: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 12,
            ),),
            Text(" *", style: TextStyle(color: Colors.red, fontSize: 12))
          ],
        ),
        GestureDetector(
          onTap: () async {
            if (_leaseStartDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select Lease Start Date first")),
              );
              return;
            }

            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: _leaseStartDate!.add(const Duration(days: 1)),
              firstDate: _leaseStartDate!.add(const Duration(days: 1)), // must be after start
              lastDate: DateTime(2100),
            );

            if (pickedDate != null) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );

              if (pickedTime != null) {
                final DateTime combinedDateTime = DateTime(
                  pickedDate.year,
                  pickedDate.month,
                  pickedDate.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );

                if (combinedDateTime.isAfter(_leaseStartDate!)) {
                  setState(() {
                    _leaseEndDate = combinedDateTime;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("End Date must be after Start Date")),
                  );
                }
              }
            }
          },
          child: Container(width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            margin: const EdgeInsets.only(top: 3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor().borderColor),
            ),
            child: Text(
              _leaseEndDate == null
                  ? "Select Lease End Date"
                  : "${_leaseEndDate!.year}/${_leaseEndDate!.month.toString().padLeft(2, '0')}/${_leaseEndDate!.day.toString().padLeft(2, '0')} "
                  "at ${TimeOfDay.fromDateTime(_leaseEndDate!).format(context)}",
              style: TextStyle(
                fontSize: 14,
                color: _leaseEndDate == null ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaseDatePickers(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.selectLeaseStartDate,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: 12,
              ),
            ),
            Text(" *", style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
        GestureDetector(
          child: Container(width:double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColor().darkCharcoalBlueColor),
            ),
            child: Text(
              _leaseStartDate == null
                  ? "${DateTime.now().year}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().day.toString().padLeft(2, '0')} "
                        "at ${TimeOfDay.fromDateTime(DateTime.now()).format(context)}"
                  : "${_leaseStartDate!.year}/${_leaseStartDate!.month.toString().padLeft(2, '0')}/${_leaseStartDate!.day.toString().padLeft(2, '0')} "
                        "at ${TimeOfDay.fromDateTime(_leaseStartDate!).format(context)}",
              style: MontserratStyles.montserratMediumTextStyle(
                size: 13,
                color: AppColor().silverShadeGrayColor,
              ),
            ),
          ),
        ),
      ],
    );
  }



  DateTime? selectedBirthDate;

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime today = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(
      today.year - 18,
      today.month,
      today.day,
    );

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eighteenYearsAgo,
      firstDate: DateTime(1900),
      lastDate: eighteenYearsAgo,
      useRootNavigator: false,

    );

    if (picked != null) {
      setState(() {
        selectedBirthDate = picked;
      });
    }
  }

  Widget _buildBirthDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.birthDate,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: 12,
              ),
            ),
            const Text(' *', style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
        InkWell(
          onTap: () => _selectBirthDate(context),
          child: Container(
            width: double.infinity, // ✅ replaces Expanded
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: selectedBirthDate != null ? 16 : 20,
            ),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedBirthDate != null
                  ? "${selectedBirthDate!.day.toString().padLeft(2, '0')}/"
                  "${selectedBirthDate!.month.toString().padLeft(2, '0')}/"
                  "${selectedBirthDate!.year}"
                  : "02/12/1982",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: selectedBirthDate != null ? 14 : 11,
                color: selectedBirthDate != null
                    ? Colors.black
                    : AppColor().silverShadeGrayColor.withOpacity(0.5),
              ),
            ),
          ),
        ),

      ],
    );
  }

  DateTime? selectedIssueDate;

  Future<void> _selectIssueDate(BuildContext context) async {
    final DateTime today = DateTime.now();

    final DateTime? picked = await showDatePicker(
      useRootNavigator: false,
      context: context,
      initialDate: today,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedIssueDate = picked;
      });
    }
  }

  Widget _buildIssueDatePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.dateOfIssue,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: 12,
              ),
            ),
            const Text(' *', style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
        InkWell(
          onTap: () => _selectIssueDate(context),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 9,
              horizontal: selectedBirthDate != null ? 16 : 20,
            ),
            margin: const EdgeInsets.only(top: 6),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedIssueDate != null
                  ? "${selectedIssueDate!.day.toString().padLeft(2, '0')}/"
                        "${selectedIssueDate!.month.toString().padLeft(2, '0')}/"
                        "${selectedIssueDate!.year}"
                  : "02/12/1982",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: selectedIssueDate != null ? 14 : 11,
                color: selectedIssueDate != null
                    ? Colors
                          .black // 🔹 when selected
                    : AppColor().silverShadeGrayColor.withOpacity(
                        0.5,
                      ), // 🔹 placeholder grey
              ),
            ),
          ),
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
    int? maxLines,
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
          maxLines: maxLines,
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

  Widget _buildPhoneField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    List<TextInputFormatter>? inputFormatters,
    int? maxLine,
    TextInputType? keyboard,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          maxLines: maxLine,
          fillColor: AppColor().backgroundColor,
          controller: controller,
          hintText: hintText,
          keyboardType: keyboard,
          inputFormatters: inputFormatters,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
            color: AppColor().silverShadeGrayColor.withOpacity(0.5),
            size: 11,
          ),
          borderRadius: 6,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
      ],
    );
  }

  Widget _buildCompactCheckList({
    required String label,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4), // Reduced spacing
              Text(
                title,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 12, // Reduced from 14
                ),
              ),
            ],
          ),
        ),
        CustomRectangularSwitch(
          width: 60, // Reduced from 80
          height: 30, // Reduced from 40
          inactiveColor: Colors.red,
          activeColor: Colors.green,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
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
