part of 'owner_details_screen_route_imple.dart';

class OwnerDetailsScreen extends StatelessWidget {
  final void Function(ScreenType type, {String? inspectorId}) onScreenChange;

  const OwnerDetailsScreen({
    super.key,
    required this.ownerDetailsScreenBloc,
    required this.onScreenChange,
  });

  final OwnerDetailsScreenBloc ownerDetailsScreenBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ownerDetailsScreenBloc,
      child: OwnerDetailsScreenView(),
    );
  }
}

class OwnerDetailsScreenView extends StatefulWidget {
  const OwnerDetailsScreenView({super.key});

  @override
  State<OwnerDetailsScreenView> createState() => _OwnerDetailsScreenViewState();
}

class _OwnerDetailsScreenViewState extends State<OwnerDetailsScreenView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  GetSingleTeamMemberModel? getSingleTeamMemberModel;
  bool _isDrivingLicense = false;
  bool _isDriverId = false;
  String initialCountryCode = "+33";
  String? insId;
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
    context.read<OwnerDetailsScreenBloc>().add(
      UpdateOwnerDetailsEvent(carDetailsModel: ownerDetails),
    );
  }

  OwnerDetails _createOwnerDetails() {
    return OwnerDetails(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      phoneNumber: _mobileController.text,
      email: _emailController.text,
      address: _addressController.text,
      countryCode: initialCountryCode,
      inspectId: insId,
      gender: 'MALE',
      checkList: OwnerCheckList(driverLicensePhoto: true, driverIdPhoto: true),
    );
  }

  void _updateDriverLicense(bool value) {
    setState(() {
      _isDrivingLicense = value;
    });
    context.read<OwnerDetailsScreenBloc>().add(
      UpdateDriverLicenseEvent(isDriverLicense: value),
    );
  }

  void _updateDriverId(bool value) {
    setState(() {
      _isDriverId = value;
    });
    context.read<OwnerDetailsScreenBloc>().add(
      UpdateDriverIdEvent(isDriverId: value),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
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
        child: BlocBuilder<OwnerDetailsScreenBloc, OwnerDetailsScreenState>(
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
    return BlocConsumer<TeamScreenBloc, TeamScreenState>(
      listener: (context, state) {
        if (state is GetSingleTeamMemberSuccess) {
          getSingleTeamMemberModel = state.getSingleTeamMemberModel;
             _firstNameController.text =
              state.getSingleTeamMemberModel.inspector?.firstName ?? "";
          _lastNameController.text =
              getSingleTeamMemberModel?.inspector?.lastName ?? "";
          _emailController.text =
              getSingleTeamMemberModel?.inspector?.email ?? "";
          _mobileController.text =
              getSingleTeamMemberModel?.inspector?.phoneNumber ?? "";
          initialCountryCode =
              getSingleTeamMemberModel?.inspector?.countryCode ?? "";
          _addressController.text =
              getSingleTeamMemberModel?.inspector?.address ?? "";
          insId = getSingleTeamMemberModel?.inspector?.inspectorId;
          final updatedOwnerDetails = _createOwnerDetails().copyWith(
            firstName: state.getSingleTeamMemberModel.inspector?.firstName,
            lastName: state.getSingleTeamMemberModel.inspector?.lastName,
            phoneNumber: state.getSingleTeamMemberModel.inspector?.phoneNumber,
            email: state.getSingleTeamMemberModel.inspector?.email,
            address: state.getSingleTeamMemberModel.inspector?.address,
            inspectId: state
                .getSingleTeamMemberModel
                .inspector
                ?.inspectorId, // ✅ set from API
          );

          // Dispatch update event to your bloc
          context.read<OwnerDetailsScreenBloc>().add(
            UpdateOwnerDetailsEvent(carDetailsModel: updatedOwnerDetails),
          );
          print(
            "test --3--${getSingleTeamMemberModel?.inspector?.inspectorId}-------$insId",
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppLocalizations.of(context)!.agentDetails,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 30,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              ),
            ),
            vGap(20),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.information,
                  style: MontserratStyles.montserratMediumTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: 16,
                  ),
                ),
                Text(' *', style: TextStyle(color: Colors.red, fontSize: 16)),
                Spacer(),
                CustomButton(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  side: BorderSide.none,
                  onPressed: () async {
                    final inspectorId = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyTeamScreen(
                          screenType: "AddAgent",
                          onScreenChange: (screen, {inspectorId}) {
                            // Handle navigation or state here
                            debugPrint(
                              "Navigated to $screen with inspectorId: $inspectorId",
                            );
                          },
                        ),
                      ),
                    );

                    if (inspectorId != null) {
                      print("api call on back button ");
                      context.read<TeamScreenBloc>().add(
                        GetSingleTeamMemberEvent(inspectorId: inspectorId),
                      );
                    }
                  },
                  borderRadius: 8,
                  text: AppLocalizations.of(context)!.addAgent,
                  textStyle: MontserratStyles.montserratMediumTextStyle(
                    color: AppColor().darkYellowColor,
                    size: 12,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    hintText: AppLocalizations.of(context)!.firstName,
                    label: AppLocalizations.of(context)!.firstName,
                    keyboardType: TextInputType.text,
                    controller: _firstNameController,

                    isRequired: true,
                  ),
                ),
                SizedBox(width: 12),
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
            SizedBox(height: 12),
            _buildTextField(
              label: AppLocalizations.of(context)!.email,
              hintText: AppLocalizations.of(context)!.email,
              keyboardType: TextInputType.emailAddress,
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
                    Text(
                      ' *',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
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
                      padding: const EdgeInsets.all(8),
                      child: CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          print("Selected Country: ${countryCode.name}");
                          print("Selected Code: ${countryCode.dialCode}");
                          initialCountryCode = countryCode.dialCode.toString();

                          print("initialCountryCode---__$initialCountryCode");
                        },
                        initialSelection: initialCountryCode,
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
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 5,
                          ),
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
                          color: AppColor().silverShadeGrayColor.withOpacity(
                            0.5,
                          ),
                          size: 11,
                        ),
                        borderRadius: 8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            CustomTextField(
              maxLines: 4,
              isRequired: true,
              borderWidth: 1,
              borderColor: AppColor().darkCharcoalBlueColor,
              controller: _addressController,
              validator: InputValidators.validateAddress,
              hintText: AppLocalizations.of(context)!.address,
              labelText: AppLocalizations.of(context)!.address,
              hintStyle: MontserratStyles.montserratRegularTextStyle(
                size: 15,
                color: AppColor().silverShadeGrayColor,
              ),
            ),
            SizedBox(height: 12),
            BlocBuilder<OwnerDetailsScreenBloc, OwnerDetailsScreenState>(
              builder: (context, state) {
                if (state is OwnerDetailsScreenLoaded) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Data in BLoC:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 6),
                        ...[
                          'Name: ${state.carOwnerDetails} ${state.carOwnerDetails.lastName}',
                          'Mobile: ${state.carOwnerDetails.phoneNumber}',
                          'Email: ${state.carOwnerDetails.email}',
                          'Address: ${state.carOwnerDetails.address}',
                          'Driver License: ${state.carOwnerDetails.checkList?.driverLicensePhoto}',
                          'Driver ID: ${state.carOwnerDetails.checkList?.driverIdPhoto}',
                          "Inspector ID: ${state.carOwnerDetails.inspectId}",
                        ].map(
                          (text) => Padding(
                            padding: EdgeInsets.only(bottom: 2),
                            child: Text(text, style: TextStyle(fontSize: 11)),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? hintText,
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
}
