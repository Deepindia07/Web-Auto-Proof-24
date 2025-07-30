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
      mobileNo: _mobileController.text,
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
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
      children: [
        // Header section - more compact
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.information,
              style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 16 // Reduced from 18
              ),
            ),
            Text(' *', style: TextStyle(color: Colors.red, fontSize: 16)),
            Spacer(),
            CustomButton(
              side: BorderSide.none,
              onPressed: _importInformation,
              borderRadius: 8, // Reduced from 12
              text: AppLocalizations.of(context)!.importInformation,
              textStyle: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkYellowColor,
                  size: 12 // Reduced from 14
              ),
            )
          ],
        ),
        SizedBox(height: 8), // Replaced Divider with spacing

        // Name fields - more compact spacing
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
            SizedBox(width: 12), // Reduced from 16
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
        SizedBox(height: 12), // Replaced Divider

        // Contact fields
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.phoneNumber,
                hintText: "1234567890",
                controller: _mobileController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.email,
                hintText: AppLocalizations.of(context)!.email,
                controller: _emailController,
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Address field
        _buildTextField(
          label: AppLocalizations.of(context)!.address,
          hintText: "123 Anywhere St, Any City, ST 12345",
          controller: _addressController,
          isRequired: true,
        ),
        SizedBox(height: 12),

        // Compact checklist items
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
        SizedBox(height: 16), // Reduced from vGap(20)

        // Compact debug section
        BlocBuilder<OwnerDetailsScreenBloc, OwnerDetailsScreenState>(
          builder: (context, state) {
            if (state is OwnerDetailsScreenLoaded) {
              return Container(
                padding: EdgeInsets.all(12), // Reduced from 16
                margin: EdgeInsets.symmetric(vertical: 4), // Reduced margin
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6), // Reduced radius
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Data in BLoC:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    SizedBox(height: 6), // Reduced spacing
                    ...[ // More compact data display
                      'Name: ${state.ownerDetails.firstName} ${state.ownerDetails.lastName}',
                      'Mobile: ${state.ownerDetails.mobileNo}',
                      'Email: ${state.ownerDetails.email}',
                      'Address: ${state.ownerDetails.address}',
                      'Driver License: ${state.ownerDetails.isDriverLicense}',
                      'Driver ID: ${state.ownerDetails.isDriverId}',
                    ].map((text) => Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Text(text, style: TextStyle(fontSize: 11)),
                    )).toList(),
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
  }

  // New compact checklist widget
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
              Text(
                '$label *',
                style: MontserratStyles.montserratMediumTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: 14 // Reduced from 18
                ),
              ),
              SizedBox(height: 4), // Reduced spacing
              Text(
                title,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: 12 // Reduced from 14
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
                  size: 12 // Reduced from 14
              ),
            ),
            if (isRequired)
              Text(' *', style: TextStyle(color: Colors.red, fontSize: 12)),
          ],
        ),
        SizedBox(height: 6), // Reduced from 8
        CustomTextField(
          fillColor: AppColor().backgroundColor,
          controller: controller,
          hintText: hintText,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().silverShadeGrayColor.withOpacity(0.5),
              size: 12 // Reduced from 14
          ),
          borderRadius: 6, // Reduced from 8
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
        ),
      ],
    );
  }
}