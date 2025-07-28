part of 'owner_details_screen_route_imple.dart';

class OwnerDetailsScreen extends StatelessWidget {
  const OwnerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OwnerDetailsScreenBloc(),
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

  bool _isDrivingLicense = false;
  bool _isDriverId = false;

  @override
  void initState() {
    super.initState();
    _addListenerOwnerDetailsListener();
    // context.read<OwnerDetailsScreenBloc>().add(
    //     UpdateOwnerDetailsEvent(ownerDetails: OwnerDetailsModel())
    // );
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
        UpdateOwnerDetailsEvent(ownerDetails: ownerDetails)
    );
  }

  OwnerDetailsModel _createOwnerDetails() {
    return OwnerDetailsModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      mobileNo: _mobileController.text, // Fixed: was using _addressController
      email: _emailController.text,
      address: _addressController.text,
      isDriverLicense: _isDrivingLicense,
      isDriverId: _isDriverId,
    );
  }

  void _updateDriverLicense(bool value) {
    setState(() {
      _isDrivingLicense = value;
    });
    context.read<OwnerDetailsScreenBloc>().add(
        UpdateDriverLicenseEvent(isDriverLicense: value)
    );
  }

  void _updateDriverId(bool value) {
    setState(() {
      _isDriverId = value;
    });
    context.read<OwnerDetailsScreenBloc>().add(
        UpdateDriverIdEvent(isDriverId: value)
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
      body: BlocBuilder<OwnerDetailsScreenBloc, OwnerDetailsScreenState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Form(
              child: _buildInformationSection(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Row(
          children: [
            Text(
             AppLocalizations.of(context)!.information,
              style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 18
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
            Spacer(),
            CustomButton(
              side: BorderSide.none,
              onPressed: _importInformation,
              borderRadius: 12,
              text: AppLocalizations.of(context)!.importInformation,
              textStyle: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkYellowColor,
                  size: 14
              ),
            )
          ],
        ),
        Divider(color: AppColor().lightSilverGrayColor),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.firstName,
                hintText:AppLocalizations.of(context)!.firstName,
                controller: _firstNameController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.lastName,
                hintText: AppLocalizations.of(context)!.lastName,
                controller: _lastNameController,
                isRequired: true,
              ),
            ),
          ],
        ),
        Divider(color: AppColor().lightSilverGrayColor),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.phoneNumber,
                hintText: "1234567890",
                controller: _mobileController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.email,
                hintText: AppLocalizations.of(context)!.email,
                controller: _emailController,
                isRequired: true,
              ),
            ),
          ],
        ),
        Divider(color: AppColor().lightSilverGrayColor),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: AppLocalizations.of(context)!.address,
                hintText: "123 Anywhere St, Any City, ST 12345",
                controller: _addressController,
                isRequired: true,
              ),
            ),
          ],
        ),
        Divider(color: AppColor().lightSilverGrayColor),
        _checkLists(
          label:AppLocalizations.of(context)!.checklist,
          title: AppLocalizations.of(context)!.licenseInstruction,
          isRequired: true,
          value: _isDrivingLicense,
          onChanged: _updateDriverLicense,
        ),
        Divider(color: AppColor().lightSilverGrayColor),
        _checkLists(
          label: AppLocalizations.of(context)!.checklist,
          title: AppLocalizations.of(context)!.licenseInstructionId,
          isRequired: true,
          value: _isDriverId,
          onChanged: _updateDriverId,
        ),
        vGap(20),

        // Debug section (remove in production)
        BlocBuilder<OwnerDetailsScreenBloc, OwnerDetailsScreenState>(
          builder: (context, state) {
            if (state is OwnerDetailsScreenLoaded) {
              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Data in BLoC:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Name: ${state.ownerDetails.firstName} ${state.ownerDetails.lastName}'),
                    Text('Mobile: ${state.ownerDetails.mobileNo}'),
                    Text('Email: ${state.ownerDetails.email}'),
                    Text('Address: ${state.ownerDetails.address}'),
                    Text('Driver License: ${state.ownerDetails.isDriverLicense}'),
                    Text('Driver ID: ${state.ownerDetails.isDriverId}'),
                  ],
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  void _importInformation() {
    // Implementation for importing information
    // You can populate the controllers and update BLoC here
  }

  Widget _checkLists({
    required String label,
    required String title,
    required bool value,
    required Function(bool) onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Row(
          children: [
            Text(
              label,
              style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 18
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
          ],
        ),
        Text(
          title,
          style: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 14
          ),
        ),
        CustomRectangularSwitch(
          width: 80,
          height: 40,
          inactiveColor: Colors.red,
          activeColor: Colors.green,
          value: value,
          onChanged: onChanged,
        )
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
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
              style: MontserratStyles.montserratSemiBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 14
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
          ],
        ),
        SizedBox(height: 8),
        CustomTextField(
          fillColor: AppColor().backgroundColor,
          controller: controller,
          hintText: hintText,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().silverShadeGrayColor.withOpacity(0.5),
              size: 14
          ),
          borderRadius: 8,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
      ],
    );
  }
}
