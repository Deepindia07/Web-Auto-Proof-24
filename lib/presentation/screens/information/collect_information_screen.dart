part of 'collect_information_screen_route_implement.dart';

class CollectInformationScreen extends StatelessWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  final String userId; // Add userId parameter

  const CollectInformationScreen({
    super.key,
    required this.isBacked,
    required this.onBack,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectInformationScreenBloc(
        authenticationApiCall: AuthenticationApiCall()
      ),
      child: CollectInformationScreenView(
        isBacked: isBacked,
        onBack: onBack,
        userId: userId,
      ),
    );
  }
}

class CollectInformationScreenView extends StatefulWidget {
  bool? isBacked;
  final VoidCallback? onBack;
  final String userId;

  CollectInformationScreenView({
    super.key,
    required this.isBacked,
    required this.onBack,
    required this.userId,
  });

  @override
  State<CollectInformationScreenView> createState() => _CollectInformationScreenViewState();
}

class _CollectInformationScreenViewState extends State<CollectInformationScreenView> {
  String _selectedInformationType = 'personal';
  bool _rememberSetting = false;
  bool _isDataLoaded = false;
  File? _selectedCompanyLogo;

  final _formKey = GlobalKey<FormState>();

  // Controllers (same as before)
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _vatNumberController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  final TextEditingController _shareCapitalController = TextEditingController();
  final TextEditingController _termsConditionController = TextEditingController();
  final TextEditingController _privacyPolicyController = TextEditingController();

  String _selectedCountryCode = '+33';
  bool _isCompanyLogoSelected = false;
  String _selectedGenderType = "Male";
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _isPhoneNumberFocused = false;

  @override
  void initState() {
    super.initState();
    _phoneNumberFocusNode.addListener(() {
      setState(() {
        _isPhoneNumberFocused = _phoneNumberFocusNode.hasFocus;
      });
    });
  }

  void _populateUserData(dynamic userProfile) {
    if (userProfile != null && userProfile.user != null && !_isDataLoaded) {
      final user = userProfile.user!;

      _firstNameController.text = user.firstName ?? '';
      _lastNameController.text = user.lastName ?? '';
      _addressController.text = user.address ?? '';
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phoneNumber ?? '';

      if (user.countryCode != null && user.countryCode!.isNotEmpty) {
        _selectedCountryCode = user.countryCode!;
      }

      if (user.company != null) {
        _companyNameController.text = user.company!.companyName ?? '';
        _websiteController.text = user.company!.website ?? '';
        _vatNumberController.text = user.company!.vatNumber ?? '';
        _registrationNumberController.text = user.company!.companyRegistrationNumber ?? '';
        _shareCapitalController.text = user.company!.shareCapital ?? '';
        _termsConditionController.text = user.company!.termAndConditions ?? '';
        _privacyPolicyController.text = user.company!.companyPolicy ?? '';

        if (user.company!.companyLogo != null && user.company!.companyLogo!.isNotEmpty) {
          _isCompanyLogoSelected = true;
        }
      }

      _isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: BlocListener<CollectInformationScreenBloc, CollectInformationScreenState>(
        listener: (context, state) {
          if (state is CollectInformationScreenLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is CollectInformationScreenPersonalSuccess) {
            context.pop();
            CherryToast.success(context, state.message);
          } else if (state is CollectInformationScreenCompanySuccess) {
            context.pop();
            CherryToast.success(context, state.message);
          } else if (state is CollectInformationScreenError) {
            context.pop();
            CherryToast.error(context, state.error);
          }
        },
        child: Column(
          children: [
            CustomAppBar(
              onBackPressed: widget.onBack,
              isBacked: widget.isBacked,
              backgroundColor: AppColor().backgroundColor,
              title: _selectedInformationType == 'personal'
                  ? AppLocalizations.of(context)!.myPersonalInformation
                  : AppLocalizations.of(context)!.myCompanyInformation,
            ),
            Expanded(child: _buildInformationView(context))
          ],
        ),
      ),
    );
  }

  Widget _buildInformationView(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _selectedInformationType == "personal"
                ? _buildPersonalInformationForm()
                : _buildCompanyInformationForm(),
            SizedBox(height: 32),
            _buildRadioSelection(),
            SizedBox(height: 32),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }
/*  Widget _buildInformationView(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content based on selection (Personal shown by default)
            _selectedInformationType == 'personal'
                ? _buildPersonalInformationForm()
                : _buildCompanyInformationForm(),

            SizedBox(height: 32),
            _buildRadioSelection(),

            SizedBox(height: 32),
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }*/

  Widget _buildRadioSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.informationType,
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
                  AppLocalizations.of(context)!.personal,
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
                activeColor: AppColor().darkCharcoalBlueColor,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text(
                  AppLocalizations.of(context)!.company,
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
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {

        if (state is HomeScreenProfileLoaded) {
          _populateUserData(state.userProfile);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    hint: AppLocalizations.of(context)!.firstName,
                    label: AppLocalizations.of(context)!.firstName,
                    controller: _firstNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.firstNameRequired;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    hint: AppLocalizations.of(context)!.lastName,
                    label: AppLocalizations.of(context)!.lastName,
                    controller: _lastNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.lastNameRequired;
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            _buildTextField(
              prefix: CustomContainer(
                height: 50,
                width: 80,
                border: Border.all(
                  width: 2,
                  color: _isPhoneNumberFocused
                      ? AppColor().darkCharcoalBlueColor
                      : AppColor().silverShadeGrayColor,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)
                ),
                backgroundColor: AppColor().backgroundColor,
                padding: EdgeInsets.all(8),
                child: CountryCodePicker(
                  onChanged: (CountryCode countryCode) {
                    setState(() {
                      _selectedCountryCode = countryCode.toString();
                    });
                    print("Selected Country: ${countryCode.name}");
                    print("Selected Code: ${countryCode.dialCode}");
                  },
                  initialSelection: _selectedCountryCode.replaceAll('+', '').isEmpty ? 'US' : null,
                  favorite: ['+1', '+91', '+44'],
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
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    hintText: AppLocalizations.of(context)!.searchCountry,
                    hintStyle: TextStyle(
                      color: AppColor().darkCharcoalBlueColor.withOpacity(0.6),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: AppColor().darkCharcoalBlueColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: AppColor().darkCharcoalBlueColor),
                    ),
                  ),
                  dialogBackgroundColor: AppColor().backgroundColor,
                  barrierColor: Colors.black54,
                  dialogSize: Size(MediaQuery.of(context).size.width * 0.8,
                      MediaQuery.of(context).size.height * 0.6),
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
                        hGap(5),
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
              label: AppLocalizations.of(context)!.phoneNumber,
              hint: AppLocalizations.of(context)!.phoneHint,
              controller: _phoneController,
              focusNode: _phoneNumberFocusNode,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.phoneRequired;
                }
                if (value.length < 10) {
                  return AppLocalizations.of(context)!.phoneInvalid;
                }
                return null;
              },
            ),
            _buildDropdownField(
              label: 'Select Gender',
              value: _selectedGenderType,
              items: [
                RadioDropdownOption(value: "Male", label: "Male"),
                RadioDropdownOption(value: "Female", label: "Female"),
              ],
              onChanged: (String? value) {
                if (value != null && mounted) {
                  setState(() {
                    _selectedGenderType = value;
                  });
                }
              },
              isRequired: true,
            ),
            _buildTextField(
              label: AppLocalizations.of(context)!.address,
              hint: AppLocalizations.of(context)!.addressHint,
              controller: _addressController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.addressHint;
                }
                return null;
              },
            ),
            _buildTextField(
              label: AppLocalizations.of(context)!.email,
              hint: AppLocalizations.of(context)!.email,
              controller: _emailController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.emailRequired;
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return AppLocalizations.of(context)!.emailInvalid;
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildCompanyInformationForm() {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {

        if (state is HomeScreenProfileLoaded) {
          _populateUserData(state.userProfile);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.companyLogo,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          // Use the custom image selector
                          final File? selectedFile = await CustomImageSelector.show(
                            context,
                            title: AppLocalizations.of(context)!.selectCompanyLogo,
                            primaryColor: AppColor().darkCharcoalBlueColor,
                            backgroundColor: AppColor().backgroundColor,
                          );

                          if (selectedFile != null) {
                            setState(() {
                              _selectedCompanyLogo = selectedFile;
                              _isCompanyLogoSelected = true;
                            });
                          }
                        },
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _isCompanyLogoSelected ? Colors.grey[300]! : Colors.red,
                              width: _isCompanyLogoSelected ? 1 : 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _buildLogoDisplay(state),
                        ),
                      ),
                      if (!_isCompanyLogoSelected)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            AppLocalizations.of(context)!.companyLogoRequired,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            _buildTextField(
              label: AppLocalizations.of(context)!.companyName,
              hint: AppLocalizations.of(context)!.companyName,
              controller: _companyNameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.companyNameRequired;
                }
                return null;
              },
            ),
            _buildTextField(
              label: AppLocalizations.of(context)!.website,
              hint: AppLocalizations.of(context)!.websiteHint,
              controller: _websiteController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.websiteRequired;
                }
                if (!RegExp(r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$').hasMatch(value)) {
                  return AppLocalizations.of(context)!.websiteInvalid;
                }
                return null;
              },
            ),
            _buildTextField(
              label: AppLocalizations.of(context)!.vatNumber,
              hint: "DU00000000",
              controller: _vatNumberController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.vatRequired;
                }
                return null;
              },
            ),
            _buildTextField(
              label: AppLocalizations.of(context)!.companyRegistrationNumber,
              hint: 'U12345DL2022PTC123456',
              controller: _registrationNumberController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.companyRegistrationNumber;
                }
                return null;
              },
            ),
            _buildTextField(
              label: AppLocalizations.of(context)!.shareCapital,
              hint: AppLocalizations.of(context)!.shareCapitalHint,
              controller: _shareCapitalController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.shareCapitalRequired;
                }
                return null;
              },
            ),
            _buildTextField(
              label: AppLocalizations.of(context)!.termsAndConditions,
              hint: "https://yourwebsite.com/terms-and-conditions",
              controller: _termsConditionController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.termsRequired;
                }
                if (!RegExp(r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$').hasMatch(value)) {
                  return AppLocalizations.of(context)!.urlInvalid;
                }
                return null;
              },
            ),
            _buildTextField(
              label: 'Privacy Policy',
              hint: "https://yourwebsite.com/privacy-policy",
              controller: _privacyPolicyController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Privacy policy URL is required';
                }
                if (!RegExp(r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$').hasMatch(value)) {
                  return 'Please enter a valid URL';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildLogoDisplay(dynamic state) {
    if (_selectedCompanyLogo != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          _selectedCompanyLogo!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    if (_isDataLoaded && state is HomeScreenProfileLoaded) {
      if (state.userProfile?.user?.company?.companyLogo != null &&
          state.userProfile!.user!.company!.companyLogo!.isNotEmpty) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            state.userProfile!.user!.company!.companyLogo!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholder();
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              );
            },
          ),
        );
      }
    }

    // Show placeholder for file selection
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Center(
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
            AppLocalizations.of(context)!.selectTheFile,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    Widget? prefix,
    FocusNode? focusNode,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '$label *',
            style: MontserratStyles.montserratMediumTextStyle(
                color: AppColor().darkCharcoalBlueColor, size: 16)
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().silverShadeGrayColor, size: 12),
            prefixIcon: prefix,
            fillColor: AppColor().backgroundColor,
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor().silverShadeGrayColor, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor().silverShadeGrayColor, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor().darkCharcoalBlueColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: () {
              if (widget.onBack != null) {
                widget.onBack!();
              }
            },
            text: AppLocalizations.of(context)!.previous,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_selectedInformationType == 'company') {
                  bool hasLogo = _selectedCompanyLogo != null ||
                      (_isDataLoaded && _isCompanyLogoSelected);

                  if (!hasLogo) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.selectCompanyLogo),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                }

                if (_selectedInformationType == AppLocalizations.of(context)!.personal && _selectedCountryCode.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppLocalizations.of(context)!.selectCountryCode),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (_selectedInformationType == 'personal') {
                  _processPersonalInformation();
                } else {
                  _processCompanyInformation();
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.fillAllFields),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            text: _selectedInformationType == 'personal' ? AppLocalizations.of(context)!.next : AppLocalizations.of(context)!.finish,
          ),
        ),
      ],
    );

  }
  Widget _buildDropdownField({
    required String label,
    required String value,
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
              style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkCharcoalBlueColor, size: 16),
            ),
            if (isRequired)
              const Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        const SizedBox(height: 8),
        RadioDropdownField(
          value: value,
          options: items,
          onChanged: onChanged,
        )
      ],
    );
  }

  void _processPersonalInformation() {
    context.read<CollectInformationScreenBloc>().updatePersonalInformation(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      countryCode: _selectedCountryCode,
      address: _addressController.text.trim(),
      userId: widget.userId,
    );
  }

  void _processCompanyInformation() {
    // Use BLoC to update company information
    context.read<CollectInformationScreenBloc>().updateCompanyInformation(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      countryCode: _selectedCountryCode,
      address: _addressController.text.trim(),
      companyName: _companyNameController.text.trim(),
      website: _websiteController.text.trim(),
      vatNumber: _vatNumberController.text.trim(),
      companyRegistrationNumber: _registrationNumberController.text.trim(),
      shareCapital: _shareCapitalController.text.trim(),
      termAndConditions: _termsConditionController.text.trim(),
      companyPolicy: _privacyPolicyController.text.trim(),
      userId: widget.userId,
      companyLogo: _selectedCompanyLogo,
    );
  }
  @override
  void dispose() {
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
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }
}