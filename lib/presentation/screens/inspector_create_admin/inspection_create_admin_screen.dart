part of 'inspection_create_admin_screen_route_imple.dart';

class InspectionCreateAdminScreen extends StatelessWidget {
  const InspectionCreateAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InspectorCreateAdminBloc(
        apiRepository: AuthenticationApiCall(),
      ),
      child: InspectionCreateAdminScreenView(),
    );
  }
}

class InspectionCreateAdminScreenView extends StatefulWidget {
  const InspectionCreateAdminScreenView({super.key});

  @override
  State<InspectionCreateAdminScreenView> createState() => _InspectionCreateAdminScreenViewState();
}

class _InspectionCreateAdminScreenViewState extends State<InspectionCreateAdminScreenView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedCountryCode = '+33';
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  bool _isPhoneNumberFocused = false;
  bool _isFirstNameFocused = false;
  bool _isLastNameFocused = false;
  bool _isEmailFocused = false;
  bool _isAddressFocused = false;

  String _selectedGenderType = "Male";
  bool _isFormSubmitted = false;

  // Enhanced validation patterns
  final RegExp _emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp _phoneRegex = RegExp(r'^[0-9]+$');
  final RegExp _nameRegex = RegExp(r'^[a-zA-Z\s]+$');

  @override
  void initState() {
    super.initState();
    _setupFocusListeners();
  }

  void _setupFocusListeners() {
    _phoneNumberFocusNode.addListener(_onPhoneNumberFocusChanged);
    _firstNameFocusNode.addListener(_onFirstNameFocusChanged);
    _lastNameFocusNode.addListener(_onLastNameFocusChanged);
    _emailFocusNode.addListener(_onEmailFocusChanged);
    _addressFocusNode.addListener(_onAddressFocusChanged);
  }

  void _onPhoneNumberFocusChanged() {
    if (mounted) {
      setState(() {
        _isPhoneNumberFocused = _phoneNumberFocusNode.hasFocus;
      });
    }
  }

  void _onFirstNameFocusChanged() {
    if (mounted) {
      setState(() {
        _isFirstNameFocused = _firstNameFocusNode.hasFocus;
      });
    }
  }

  void _onLastNameFocusChanged() {
    if (mounted) {
      setState(() {
        _isLastNameFocused = _lastNameFocusNode.hasFocus;
      });
    }
  }

  void _onEmailFocusChanged() {
    if (mounted) {
      setState(() {
        _isEmailFocused = _emailFocusNode.hasFocus;
      });
    }
  }

  void _onAddressFocusChanged() {
    if (mounted) {
      setState(() {
        _isAddressFocused = _addressFocusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    // Remove focus listeners before disposing
    _phoneNumberFocusNode.removeListener(_onPhoneNumberFocusChanged);
    _firstNameFocusNode.removeListener(_onFirstNameFocusChanged);
    _lastNameFocusNode.removeListener(_onLastNameFocusChanged);
    _emailFocusNode.removeListener(_onEmailFocusChanged);
    _addressFocusNode.removeListener(_onAddressFocusChanged);

    // Dispose controllers
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();

    // Dispose focus nodes
    _phoneNumberFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: BlocListener<InspectorCreateAdminBloc, InspectorCreateAdminState>(
        listener: (context, state) {
          if (state is InspectorCreateAdminSuccess) {
            if (mounted) {
              CustomLoader.hidePopupLoader(context);
              CherryToast.success(
                context,
                "Inspector created successfully!",
              );
              Navigator.of(context).pop();
              // _refreshTeamScreen(context);
            }
          } else if (state is InspectorCreateAdminError) {
            if (mounted) {
              CustomLoader.hidePopupLoader(context);
            }
          } else if (state is InspectorCreateAdminLoading) {
            if (mounted) {
              CustomLoader.showPopupLoader(context);
            }
          }
        },
        child: Column(
          children: [
            CustomAppBar(
              backgroundColor: AppColor().backgroundColor,
              title: "Add Inspector",
            ),
            Expanded(child: _buildPersonalInformationForm())
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInformationForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      hint: AppLocalizations.of(context)!.firstName,
                      label: AppLocalizations.of(context)!.firstName,
                      controller: _firstNameController,
                      focusNode: _firstNameFocusNode,
                      validator: _validateFirstName,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      hint: AppLocalizations.of(context)!.lastName,
                      label: AppLocalizations.of(context)!.lastName,
                      controller: _lastNameController,
                      focusNode: _lastNameFocusNode,
                      validator: _validateLastName,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _buildTextField(
                label: AppLocalizations.of(context)!.email,
                hint: AppLocalizations.of(context)!.email,
                controller: _emailController,
                focusNode: _emailFocusNode,
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15),
              _buildTextField(
                prefix: _buildCountryCodePicker(),
                label: AppLocalizations.of(context)!.phoneNumber,
                hint: AppLocalizations.of(context)!.phoneHint,
                controller: _phoneController,
                focusNode: _phoneNumberFocusNode,
                validator: _validatePhoneNumber,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 15),
              _buildTextField(
                label: AppLocalizations.of(context)!.address,
                hint: AppLocalizations.of(context)!.addressHint,
                controller: _addressController,
                focusNode: _addressFocusNode,
                validator: _validateAddress,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 30),
              BlocBuilder<InspectorCreateAdminBloc, InspectorCreateAdminState>(
                builder: (context, state) {
                  final isLoading = state is InspectorCreateAdminLoading;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButtonView(
                        onTap: isLoading ? null : () => _handleCancel(context),
                        text: "Cancel",
                        isSecondary: true,
                      ),
                      _buildButtonView(
                        onTap: isLoading ? null : _handleCreateInspector,
                        text: "Create",
                        isSecondary: false,
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountryCodePicker() {
    return CustomContainer(
      height: 50,
      width: 80,
      border: Border.all(
        width: 2,
        color: _isPhoneNumberFocused
            ? AppColor().darkCharcoalBlueColor
            : AppColor().silverShadeGrayColor,
      ),
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8)),
      backgroundColor: AppColor().backgroundColor,
      padding: const EdgeInsets.all(8),
      child: CountryCodePicker(
        onChanged: (CountryCode countryCode) {
          if (mounted) {
            setState(() {
              _selectedCountryCode = countryCode.toString();
            });
          }
        },
        // Fix: Set initial selection to 'FR' for France (+33)
        initialSelection: 'FR',
        favorite: const ['+33', 'FR'],
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
          hintText: AppLocalizations.of(context)!.searchCountry,
          hintStyle: TextStyle(
            color: AppColor().darkCharcoalBlueColor.withOpacity(0.6),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor().darkCharcoalBlueColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColor().darkCharcoalBlueColor),
          ),
        ),
        dialogBackgroundColor: AppColor().backgroundColor,
        barrierColor: Colors.black54,
        dialogSize: Size(
            MediaQuery.of(context).size.width * 0.8,
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
              const SizedBox(width: 5),
              Text(
                countryCode?.dialCode ?? '',
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
    );
  }

  // Enhanced validation methods
  String? _validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.firstNameRequired;
    }
    if (value.trim().length < 2) {
      return "First name must be at least 2 characters long";
    }
    if (value.trim().length > 50) {
      return "First name must be less than 50 characters";
    }
    if (!_nameRegex.hasMatch(value.trim())) {
      return "First name can only contain letters and spaces";
    }
    return null;
  }

  String? _validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.lastNameRequired;
    }
    if (value.trim().length < 2) {
      return "Last name must be at least 2 characters long";
    }
    if (value.trim().length > 50) {
      return "Last name must be less than 50 characters";
    }
    if (!_nameRegex.hasMatch(value.trim())) {
      return "Last name can only contain letters and spaces";
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.emailRequired;
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return AppLocalizations.of(context)!.emailInvalid;
    }
    if (value.trim().length > 254) {
      return "Email address is too long";
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.phoneRequired;
    }
    if (!_phoneRegex.hasMatch(value.trim())) {
      return "Phone number can only contain digits";
    }
    if (value.trim().length < 7) {
      return "Phone number must be at least 7 digits long";
    }
    if (value.trim().length > 15) {
      return "Phone number must be less than 15 digits long";
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }
    if (value.trim().length < 10) {
      return "Address must be at least 10 characters long";
    }
    if (value.trim().length > 200) {
      return "Address must be less than 200 characters";
    }
    return null;
  }

  void _handleCreateInspector() {
    if (!mounted) return;

    setState(() {
      _isFormSubmitted = true;
    });

    if (!_formKey.currentState!.validate()) {
      if (mounted) {
        CherryToast.error(
          context,
          "Please correct the errors in the form",
        );
      }
      return;
    }

    final adminId = _getAdminId();
    final companyId = _getCompanyId();

    if (adminId == null || adminId.isEmpty) {
      if (mounted) {
        CherryToast.error(
          context,
          "Admin ID not found. Please log in again.",

        );
      }
      return;
    }

    if (companyId == null || companyId.isEmpty) {
      if (mounted) {
        CherryToast.error(
          context,
          "Company ID not found. Please contact support.",

        );
      }
      return;
    }

    if (mounted) {
   /*   context.read<InspectorCreateAdminBloc>().add(
        CreateInspectorEvent(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim().toLowerCase(),
          phoneNumber: _phoneController.text.trim(),
          countryCode: _selectedCountryCode,
          gender: _selectedGenderType,
          address: _addressController.text.trim(),
          adminId: adminId,
          companyId: companyId,
        ),
      );*/
    }
  }

  void _handleCancel(BuildContext context) {
    // Check if any field has content
    if (_firstNameController.text.isNotEmpty ||
        _lastNameController.text.isNotEmpty ||
        _emailController.text.isNotEmpty ||
        _phoneController.text.isNotEmpty ||
        _addressController.text.isNotEmpty) {

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Discard Changes?'),
            content: const Text('You have unsaved changes. Are you sure you want to discard them?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.of(context).pop(); // Close screen
                },
                child: const Text('Discard'),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  String? _getAdminId() {
    try {
      return SharedPrefsHelper.instance.getString(userId);
    } catch (e) {
      debugPrint('Error getting admin ID: $e');
      return null;
    }
  }

  String? _getCompanyId() {
    try {
      return SharedPrefsHelper.instance.getString(companyId);
    } catch (e) {
      debugPrint('Error getting company ID: $e');
      return null;
    }
  }

  // void _refreshTeamScreen(BuildContext context) {
  //   try {
  //     // Check if TeamScreenBloc is available in the current context
  //     final teamBloc = context.read<TeamScreenBloc>();
  //     teamBloc.add(LoadTeamMembers(isRefresh: true));
  //   } catch (e) {
  //     debugPrint('Error refreshing team screen: $e');
  //     // If bloc is not available, we can still navigate back successfully
  //     // The parent screen should handle refreshing when this screen is popped
  //   }
  // }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    Widget? prefix,
    FocusNode? focusNode,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction = TextInputAction.next,
    int maxLines = 1,
  }) {
    return CustomTextField(
      controller: controller,
      focusNode: focusNode,
      labelText: "$label *",
      labelStyle: MontserratStyles.montserratSemiBoldTextStyle(
          color: AppColor().darkCharcoalBlueColor, size: 14),
      hintText: hint,
      hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
          color: AppColor().silverShadeGrayColor, size: 14),
      prefixIcon: prefix,
      fillColor: AppColor().backgroundColor,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      validator: validator,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      maxLines: maxLines,
      // autovalidateMode: _isFormSubmitted
      //     ? AutovalidateMode.onUserInteraction
      //     : AutovalidateMode.disabled,
    );
  }

  Widget _buildButtonView({
    required VoidCallback? onTap,
    required String text,
    bool isSecondary = false,
  }) {
    return CustomButton(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      onPressed: onTap,
      text: text,
      backgroundColor: AppColor().darkCharcoalBlueColor,
      textColor: Colors.white,

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
              style: MontserratStyles.montserratSemiBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor, size: 14),
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
}



