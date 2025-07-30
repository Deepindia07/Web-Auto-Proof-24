part of 'client_details_screen_route_imple.dart';

class ClientDetailsScreen extends StatelessWidget {
  const ClientDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientDetailsScreenBloc>(
      create: (context) => ClientDetailsScreenBloc(),
      child: ClientDetailsScreenView(),
    );
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
  final TextEditingController _drivingLicenseController = TextEditingController();
  final TextEditingController _dateOfIssueController = TextEditingController();
  final TextEditingController _rentalDurationController = TextEditingController();
  final TextEditingController _leaseEndDateTimeController = TextEditingController();

  bool _driverLicenseChecked = false;
  bool _driverIdChecked = false;

  late final ClientDetailsScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<ClientDetailsScreenBloc>();
  }

  void _addClientDetails() {
    final clientDetails = ClientDetailsModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      dob: _birthDayController.text,
      mobileNo: _mobileController.text,
      email: _emailController.text,
      drivingLicense: _drivingLicenseController.text,
      dateOfIssues: _dateOfIssueController.text,
      rentalDuration: _rentalDurationController.text,
      leaseEndDateTime: _leaseEndDateTimeController.text,
    );
  }

  void _resetFields() {
    _firstNameController.clear();
    _lastNameController.clear();
    _addressController.clear();
    _birthDayController.clear();
    _mobileController.clear();
    _emailController.clear();
    _drivingLicenseController.clear();
    _dateOfIssueController.clear();
    _rentalDurationController.clear();
    _leaseEndDateTimeController.clear();

    setState(() {
      _driverLicenseChecked = false;
      _driverIdChecked = false;
    });
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
    _leaseEndDateTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Added padding
        child: Form(child: _buildInformationSection()),
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section - compact
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.information,
              style: MontserratStyles.montserratMediumTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: 16, // Reduced from 18
              ),
            ),
            Text(' *', style: TextStyle(color: Colors.red, fontSize: 16)),
            Spacer(),
            CustomButton(
              side: BorderSide.none,
              onPressed: () {},
              borderRadius: 8, // Reduced from 12
              text: AppLocalizations.of(context)!.importInformation,
              textStyle: MontserratStyles.montserratMediumTextStyle(
                color: AppColor().darkYellowColor,
                size: 12, // Reduced from 14
              ),
            ),
          ],
        ),
        SizedBox(height: 8), // Replaced Divider

        // Personal info row - 3 fields in one row (more compact)
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
            SizedBox(width: 8), // Reduced spacing
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.lastName,
                hintText: AppLocalizations.of(context)!.lastName,
                controller: _lastNameController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.birthDate,
                hintText: '02/12/1982',
                controller: _birthDayController,
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 10), // Reduced spacing

        // Contact info row
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.phone,
                hintText: "1234567890",
                controller: _mobileController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.email,
                hintText: 'abcd@gmail.com',
                controller: _emailController,
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        // Address field
        _buildTextField(
          label: AppLocalizations.of(context)!.address,
          hintText: "123 Anywhere St, Any City, ST 12345",
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
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.dateOfIssue,
                hintText: '7.7.25',
                controller: _dateOfIssueController,
                isRequired: true,
              ),
            ),
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
            SizedBox(width: 8),
            Expanded(
              child: _buildTextField(
                label: AppLocalizations.of(context)!.leaseEndDateTime,
                hintText: '2025/12/18 at 9:00 AM',
                controller: _leaseEndDateTimeController,
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Compact checklist items
        _buildCompactCheckList(
          label: AppLocalizations.of(context)!.checklist,
          title: AppLocalizations.of(context)!.licenseInstruction,
          value: _driverLicenseChecked,
          onChanged: (value) {
            setState(() {
              _driverLicenseChecked = value;
            });
          },
        ),
        SizedBox(height: 8),

        _buildCompactCheckList(
          label: AppLocalizations.of(context)!.checklist,
          title: AppLocalizations.of(context)!.licenseInstructionId,
          value: _driverIdChecked,
          onChanged: (value) {
            setState(() {
              _driverIdChecked = value;
            });
          },
        ),
        SizedBox(height: 16), // Reduced from vGap(20)
      ],
    );
  }

  // New compact checklist widget (horizontal layout)
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
                  size: 14, // Reduced from 18
                ),
              ),
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
            Flexible( // Added Flexible to prevent overflow
              child: Text(
                label,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 12, // Reduced from 14
                ),
                overflow: TextOverflow.ellipsis, // Handle long labels
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
            size: 11, // Reduced from 14
          ),
          borderRadius: 6, // Reduced from 8
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), // Reduced padding
        ),
      ],
    );
  }
}