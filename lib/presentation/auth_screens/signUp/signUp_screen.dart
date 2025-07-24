part of 'signUp_screen_route_imple.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenScreenState();
}

class _RegistrationScreenScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  bool _agreeToTerms = false;
  bool _isEmailVerified = false;
  bool _isPhoneVerified = false;
  String selectedCountryCode = "+33";

  @override
  void dispose() {
    _fullNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  void _handleRegistration(BuildContext context) {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      // Check if email and phone are verified
      if (!_isEmailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please verify your email address first'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (!_isPhoneVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please verify your phone number first'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Extract country code and phone number
      String fullPhoneNumber = _phoneController.text;
      String phoneNumber = fullPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');

      // Trigger the registration event
      context.read<SignUpScreenBloc>().add(
        RegisterUser(
          firstName: _fullNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          countryCode: selectedCountryCode,
          phoneNumber: phoneNumber,
          password: _passwordController.text,
          isEmailVerified: _isEmailVerified,
          termsAndConditions: _agreeToTerms,
        ),
      );
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms & Privacy'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleEmailVerification() async {
    // Check if email is entered
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Show loading
      CustomLoader.showPopupLoader(context);

      // Call API to send OTP to email
      // await _sendEmailOTP(_emailController.text.trim());

      CustomLoader.hidePopupLoader(context);

      // Navigate to OTP screen
      // final result = await Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OTPVerificationScreen(
      //       verificationType: 'email',
      //       contactInfo: _emailController.text.trim(),
      //       onVerificationSuccess: () {
      //         setState(() {
      //           _isEmailVerified = true;
      //         });
      //       },
      //     ),
      //   ),
      // );

      // Show success message if verification was successful
      // if (result == true && _isEmailVerified) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Email verified successfully!'),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      // }
    } catch (e) {
      CustomLoader.hidePopupLoader(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send verification code: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // void _handlePhoneVerification() async {
  //   // Check if phone is entered
  //   if (_phoneController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please enter your phone number first'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   try {
  //     // Show loading
  //     CustomLoader.showPopupLoader(context);
  //
  //     // Get full phone number with country code
  //     String fullPhoneNumber = selectedCountryCode + _phoneController.text.trim();
  //
  //     // Call API to send OTP to phone
  //     await _sendPhoneOTP(fullPhoneNumber);
  //
  //     CustomLoader.hidePopupLoader(context);
  //
  //     // Navigate to OTP screen
  //     final result = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => OTPVerificationScreen(
  //           verificationType: 'phone',
  //           contactInfo: fullPhoneNumber,
  //           onVerificationSuccess: () {
  //             setState(() {
  //               _isPhoneVerified = true;
  //             });
  //           },
  //         ),
  //       ),
  //     );
  //
  //     // Show success message if verification was successful
  //     if (result == true && _isPhoneVerified) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Phone number verified successfully!'),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     CustomLoader.hidePopupLoader(context);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to send verification code: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  // // API call to send email OTP
  // Future<void> _sendEmailOTP(String email) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('YOUR_API_BASE_URL/send-email-otp'), // Replace with your API endpoint
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         'email': email,
  //       }),
  //     );
  //
  //     if (response.statusCode != 200) {
  //       throw Exception('Failed to send OTP');
  //     }
  //   } catch (e) {
  //     throw Exception('Network error: ${e.toString()}');
  //   }
  // }

  // // API call to send phone OTP
  // Future<void> _sendPhoneOTP(String phoneNumber) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('YOUR_API_BASE_URL/send-phone-otp'), // Replace with your API endpoint
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode({
  //         'phoneNumber': phoneNumber,
  //       }),
  //     );
  //
  //     if (response.statusCode != 200) {
  //       throw Exception('Failed to send OTP');
  //     }
  //   } catch (e) {
  //     throw Exception('Network error: ${e.toString()}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;
    final headerHeight = 200.0 + statusBarHeight + 40;

    return BlocProvider<SignUpScreenBloc>(
      create: (context) =>
          SignUpScreenBloc(
              apiRepository: AuthenticationApiCall()
          ),
      child: Scaffold(
        backgroundColor: AppColor().backgroundColor,
        body: BlocListener<SignUpScreenBloc, SignUpScreenState>(
          listener: (context, state) {
            if (state is SignUpScreenSuccess) {
              CustomLoader.showPopupLoader(context);
              CherryToast.success(context, "Account created successfully!");
              context.pushNamed("login");
              CustomLoader.hidePopupLoader(context);
            } else if (state is SignUpScreenError) {
              CustomLoader.hidePopupLoader(context);
              CherryToast.error(context, state.message);
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    vGap(headerHeight + 20),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 15,
                          children: [
                            Row(
                              spacing: 2,
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _fullNameController,
                                    hint: AppLocalizations.of(context)!.firstName,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Expanded(
                                  child: _buildTextField(
                                    controller: _lastNameController,
                                    hint: AppLocalizations.of(context)!.lastName,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                            _buildTextField(
                              controller: _emailController,
                              hint: AppLocalizations.of(context)!.emailAddress,
                              suffix: TextButton(
                                onPressed: _isEmailVerified ? null : _handleEmailVerification,
                                child: Text(
                                  _isEmailVerified ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.verify,
                                  textAlign: TextAlign.center,
                                  style: MontserratStyles
                                      .montserratMediumTextStyle(
                                    color: _isEmailVerified
                                        ? Colors.green
                                        : AppColor().darkYellowColor,
                                  ),
                                ),
                              ),
                              icon: Icon(
                                _isEmailVerified ? Icons.verified : Icons.mail_outline,
                                color: _isEmailVerified ? Colors.green : null,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            _buildTextField(
                              controller: _phoneController,
                              hint: AppLocalizations.of(context)!.phone,
                              suffix: TextButton(
                                onPressed: (){}/*isPhoneVerified ? null : _handlePhoneVerification*/,
                                child: Text(
                                  _isPhoneVerified ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.verify,
                                  textAlign: TextAlign.center,
                                  style: MontserratStyles
                                      .montserratMediumTextStyle(
                                    color: _isPhoneVerified
                                        ? Colors.green
                                        : AppColor().darkYellowColor,
                                  ),
                                ),
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomContainer(
                                  height: 50,
                                  width: 90,
                                  border: Border(
                                    right: BorderSide(
                                      width: 1,
                                      color: AppColor().silverShadeGrayColor,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(0),
                                      topLeft: Radius.circular(48),
                                      bottomLeft: Radius.circular(48),
                                      bottomRight: Radius.circular(0)
                                  ),
                                  backgroundColor: AppColor().backgroundColor,
                                  padding: EdgeInsets.all(8),
                                  child: CountryCodePicker(
                                    onChanged: (CountryCode countryCode) {
                                      setState(() {
                                        selectedCountryCode = countryCode.toString();
                                        // Reset phone verification when country code changes
                                        _isPhoneVerified = false;
                                      });
                                      print("Selected Country: ${countryCode.name}");
                                      print("Selected Code: ${countryCode.dialCode}");
                                    },
                                    initialSelection: 'FR',
                                    favorite: ["+33"],
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
                                      hintText: 'Search country',
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
                                          SizedBox(width: 8),
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
                              ),
                              keyboardType: TextInputType.phone,
                            ),

                            CustomPasswordField(
                              borderRadius: 48,
                              borderWidth: 3,
                              fillColor: AppColor().backgroundColor,
                              controller: _passwordController,
                              hintText: AppLocalizations.of(context)!.password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              prefix: Icon(Icons.lock, color: Colors.grey),
                            ),
                            CustomPasswordField(
                              borderRadius: 48,
                              borderWidth: 3,
                              fillColor: AppColor().backgroundColor,
                              controller: _retypePasswordController,
                              hintText: AppLocalizations.of(context)!.retypePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              prefix: Icon(Icons.lock, color: Colors.grey),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _agreeToTerms,
                                  onChanged: (value) {
                                    setState(() {
                                      _agreeToTerms = value ?? false;
                                    });
                                  },
                                  activeColor: const Color(0xFF2D3748),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: AppLocalizations.of(context)!.agreeTerms,
                                      style: MontserratStyles
                                          .montserratMediumTextStyle(
                                        size: 14,
                                        color: AppColor().silverShadeGrayColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: AppLocalizations.of(context)!.termsPrivacy,
                                          style: MontserratStyles
                                              .montserratMediumTextStyle(
                                            size: 14,
                                            color: AppColor()
                                                .darkCharcoalBlueColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: BlocBuilder<
                                  SignUpScreenBloc,
                                  SignUpScreenState>(
                                builder: (context, state) {
                                  bool isLoading = state is SignUpScreenLoading;

                                  return CustomButton(
                                    onPressed: _agreeToTerms && !isLoading
                                        ? () => _handleRegistration(context)
                                        : null,
                                    text: isLoading
                                        ? AppLocalizations.of(context)!.creatingAccount
                                        : AppLocalizations.of(context)!.createAnAccountTitle,
                                    borderRadius: 48,
                                    textStyle: MontserratStyles
                                        .montserratMediumTextStyle(
                                      color: _agreeToTerms && !isLoading
                                          ? AppColor().yellowWarmColor
                                          : AppColor().darkCharcoalBlueColor,
                                      size: 18,
                                    ),
                                    elevation: 5,
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.haveAccount,
                                  style: MontserratStyles
                                      .montserratMediumTextStyle(
                                    size: 14,
                                    color: AppColor().silverShadeGrayColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.signIn,
                                    style: MontserratStyles
                                        .montserratMediumTextStyle(
                                      size: 14,
                                      color: AppColor().darkCharcoalBlueColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            vGap(30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Header section
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: UpperContainerWidget(height: headerHeight+20,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Updated _buildTextField method
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    Widget? icon,
    final Widget? suffix,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    TextInputType? keyboardType,
  }) {
    return CustomTextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      fillColor: AppColor().backgroundColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintText: hint,
      suffixIcon: suffix,
      hintStyle: MontserratStyles.montserratRegularTextStyle(
        size: 16,
        color: AppColor().silverShadeGrayColor,
      ),
      borderRadius: 48,
      prefixIcon: icon,
      borderWidth: 3,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (hint == 'Email Address' && !value.contains('@')) {
          return 'Please enter a valid email';
        }
        if (hint == 'Password' && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (hint == 'Retype Password' && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}