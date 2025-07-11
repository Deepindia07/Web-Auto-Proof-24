part of 'collect_information_screen_route_implement.dart';

class CollectInformationScreen extends StatelessWidget {
  const CollectInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CollectInformationScreenView();
  }
}

class CollectInformationScreenView extends StatefulWidget {
  const CollectInformationScreenView({super.key});

  @override
  State<CollectInformationScreenView> createState() => _CollectInformationScreenViewState();
}

class _CollectInformationScreenViewState extends State<CollectInformationScreenView> {
  String _selectedInformationType = 'personal'; // Default to personal
  bool _rememberSetting = false;

  // Personal Information Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Company Information Controllers
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _vatNumberController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _shareCapitalController = TextEditingController();
  final TextEditingController _termsConditionController = TextEditingController();
  final TextEditingController _privacyPolicyController = TextEditingController();

  String _selectedCountryCode = '+33';

  @override
  void initState() {
    super.initState();
    // Initialize with placeholder values
    _firstNameController.text = 'Anna Katrina';
    _lastNameController.text = 'Anna Katrina';
    _phoneController.text = '123-456-7890';
    _addressController.text = '123 Anywhere St, Any City, ST 12345';
    _emailController.text = 'hello@reallygreatsite.com';

    _companyNameController.text = 'PREET';
    _websiteController.text = 'preet@gmail.com';
    _vatNumberController.text = '00-00-00';
    _registrationNumberController.text = '563267';
    _shareCapitalController.text = '5000€';
    _termsConditionController.text = 'https://www.';
    _privacyPolicyController.text = 'preet@gmail.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "",
          ),
          Expanded(child: _buildInformationView(context))
        ],
      ),
    );
  }

  Widget _buildInformationView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content based on selection (Personal shown by default)
          _selectedInformationType == 'personal'
              ? _buildPersonalInformationForm()
              : _buildCompanyInformationForm(),

          SizedBox(height: 32),

          // Radio Button Selection (moved below the form)
          _buildRadioSelection(),

          SizedBox(height: 32),

          // Navigation Buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildRadioSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Information Type',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text(
                  'Personal',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                value: 'personal',
                groupValue: _selectedInformationType,
                onChanged: (value) {
                  setState(() {
                    _selectedInformationType = value!;
                  });
                },
                activeColor: Color(0xFF4A5568),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text(
                  'Company',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                value: 'company',
                groupValue: _selectedInformationType,
                onChanged: (value) {
                  setState(() {
                    _selectedInformationType = value!;
                  });
                },
                activeColor: Color(0xFF4A5568),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonalInformationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        Row(
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColor().darkCharcoalBlueColor,
                    shape: BoxShape.circle
                ),
                child: Image.asset(personIcon,height: 20,width: 20,color: AppColor().darkYellowColor,)
            ),
            hGap(16),
            Text(
              'My Personal Information',
              style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 18),
            ),
          ],
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'First Name',
                controller: _firstNameController,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                label: 'Last Name',
                controller: _lastNameController,
              ),
            ),
          ],
        ),
        _buildPhoneField(),
        _buildTextField(
          label: 'Address',
          controller: _addressController,
        ),
        _buildTextField(
          label: 'Email',
          controller: _emailController,
        ),

        // // Remember Setting Checkbox
        // Row(
        //   children: [
        //     Checkbox(
        //       value: _rememberSetting,
        //       onChanged: (value) {
        //         setState(() {
        //           _rememberSetting = value!;
        //         });
        //       },
        //       activeColor: Color(0xFF4A5568),
        //     ),
        //     Text(
        //       'Remember my setting',
        //       style: TextStyle(
        //         fontSize: 14,
        //         color: Colors.grey[600],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildCompanyInformationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 15,
      children: [
        // Header with Icon
        Row(
          children: [
            Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColor().darkCharcoalBlueColor,
                    shape: BoxShape.circle
                ),
                child: Image.asset(personIcon,height: 20,width: 20,color: AppColor().darkYellowColor,)
            ),
            SizedBox(width: 16),
            Text(
              'My Company Information',
              style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 18),
            ),
          ],
        ),
        Divider(),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Balance',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[800],
                    ),
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 32,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Drop the file',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF4A5568),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2,
                    color: Colors.orange,
                    size: 32,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'WEPIK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          'Footer Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        _buildTextField(
          label: 'Company Name',
          controller: _companyNameController,
        ),
        _buildTextField(
          label: 'Website',
          controller: _websiteController,
        ),

        _buildTextField(
          label: 'VAT Number',
          controller: _vatNumberController,
        ),

        SizedBox(height: 24),

        // Company Registration No.
        _buildTextField(
          label: 'Company Registration No.',
          controller: _registrationNumberController,
        ),

        SizedBox(height: 24),

        // Share Capital
        _buildTextField(
          label: 'Share Capital',
          controller: _shareCapitalController,
        ),

        SizedBox(height: 24),

        // Term & Condition
        _buildTextField(
          label: 'Term & Condition',
          controller: _termsConditionController,
        ),

        SizedBox(height: 24),

        // Privacy Policy
        _buildTextField(
          label: 'Privacy Policy',
          controller: _privacyPolicyController,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            label,
            style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 16)
        ),
        SizedBox(height: 8),
        CustomTextField(
          borderRadius: 8,
          borderWidth: 2,
          fillColor: AppColor().backgroundColor,
          controller: controller,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().silverShadeGrayColor,size: 12),
          onChanged: (value){
            setState(() {
            });
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        )
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            SizedBox(
              width: 100,
              child: DropdownButtonFormField<String>(
                value: _selectedCountryCode,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF4A5568)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                items: [
                  DropdownMenuItem(
                    value: '+33',
                    child: Row(
                      children: [
                        Text('🇫🇷', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 4),
                        Text('+33', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: '+1',
                    child: Row(
                      children: [
                        Text('🇺🇸', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 4),
                        Text('+1', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCountryCode = value!;
                  });
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xFF4A5568)),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
              onPressed: () {},
              text: "Back"),
        ),
        SizedBox(width: 16),
        Expanded(
          child: CustomButton(
              onPressed: () {
                if (_selectedInformationType == 'personal') {
                  // Process personal information
                  _processPersonalInformation();
                } else {
                  // Process company information
                  _processCompanyInformation();
                }
              },
              text: _selectedInformationType == 'personal' ? 'Next' : 'Finish'),
        ),
      ],
    );
  }

  void _processPersonalInformation() {
    // Handle personal information processing
    print('Processing Personal Information:');
    print('Name: ${_firstNameController.text} ${_lastNameController.text}');
    print('Phone: $_selectedCountryCode ${_phoneController.text}');
    print('Address: ${_addressController.text}');
    print('Email: ${_emailController.text}');
    print('Remember Setting: $_rememberSetting');

    // Navigate to next screen or show success message
  }

  void _processCompanyInformation() {
    // Handle company information processing
    print('Processing Company Information:');
    print('Company Name: ${_companyNameController.text}');
    print('Website: ${_websiteController.text}');
    print('VAT Number: ${_vatNumberController.text}');
    print('Registration Number: ${_registrationNumberController.text}');
    print('Share Capital: ${_shareCapitalController.text}');

    // Navigate to next screen or show success message
  }

  @override
  void dispose() {
    // Dispose controllers
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _companyNameController.dispose();
    _websiteController.dispose();
    _vatNumberController.dispose();
    _registrationNumberController.dispose();
    _shareCapitalController.dispose();
    _termsConditionController.dispose();
    _privacyPolicyController.dispose();
    super.dispose();
  }
}