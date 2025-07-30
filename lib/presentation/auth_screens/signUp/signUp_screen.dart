part of 'signUp_screen_route_imple.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenScreenState();
}

class _RegistrationScreenScreenState extends State<RegistrationScreen> with WidgetsBindingObserver {
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
  bool _isSendingOtp = false;
  bool _isCheckingVerification = false;
  String selectedCountryCode = "+33";
  late final SignUpScreenBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _signUpBloc = SignUpScreenBloc(apiRepository: AuthenticationApiCall());
    _loadEmailVerificationStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _fullNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    _signUpBloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _loadEmailVerificationStatus();
    }
  }

  void _loadEmailVerificationStatus() async {
    setState(() {
      _isCheckingVerification = true;
    });

    try {
      final isVerified = await SharedPrefsHelper.instance.getBool(isVerifiedEmail);
      if (mounted) {
        setState(() {
          _isEmailVerified = isVerified ?? false;
          _isCheckingVerification = false;
        });
      }
    } catch (e) {
      print('Error loading email verification status: $e');
      if (mounted) {
        setState(() {
          _isEmailVerified = false;
          _isCheckingVerification = false;
        });
      }
    }
  }

  void _saveEmailVerificationStatus(bool isVerified) async {
    try {
      await SharedPrefsHelper.instance.setBool(isVerifiedEmail, isVerified);
    } catch (e) {
      print('Error saving email verification status: $e');
    }
  }

  void _handleRegistration(BuildContext context) {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      if (!_isEmailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please verify your email address first'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // if (!_isPhoneVerified) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Please verify your phone number first'),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      //   return;
      // }

      String fullPhoneNumber = _phoneController.text;
      String phoneNumber = fullPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');

      _signUpBloc.add(
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
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSendingOtp = true;
    });

    _signUpBloc.add(
        SendOtpEmailEvent(email: _emailController.text.trim())
    );
  }

  void _navigateToOtpScreen() async {
    final result = await context.push(AppRoute.otpScreen, extra: _emailController.text);

    // Check verification status after returning from OTP screen
    _loadEmailVerificationStatus();

    if (result == true) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }

  void _resetEmailVerification() {
    setState(() {
      _isEmailVerified = false;
    });
    _saveEmailVerificationStatus(false);
  }

  Widget _buildEmailVerificationButton() {
    if (_isCheckingVerification) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
              AppColor().darkYellowColor
          ),
        ),
      );
    }

    if (_isSendingOtp) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
              AppColor().darkYellowColor
          ),
        ),
      );
    }

    return Text(
      _isEmailVerified
          ? AppLocalizations.of(context)!.verified
          : AppLocalizations.of(context)!.verify,
      textAlign: TextAlign.center,
      style: MontserratStyles.montserratMediumTextStyle(
        color: _isEmailVerified
            ? Colors.green
            : AppColor().darkYellowColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final headerHeight = 180.0 + statusBarHeight;

    return BlocProvider<SignUpScreenBloc>.value(
      value: _signUpBloc,
      child: Scaffold(
        backgroundColor: AppColor().backgroundColor,
        body: BlocListener<SignUpScreenBloc, SignUpScreenState>(
          bloc: _signUpBloc,
          listener: (context, state) {
            // Handle registration success/error
            if (state is SignUpScreenSuccess) {
              CustomLoader.hidePopupLoader(context);
              CherryToast.success(context, "Account created successfully!");
              // Clear verification status after successful registration
              _saveEmailVerificationStatus(false);
              context.pushNamed("login");
            } else if (state is SignUpScreenError) {
              CustomLoader.hidePopupLoader(context);
              CherryToast.error(context, state.message);
            }
            else if (state is SignUpScreenLoading) {
              CustomLoader.showPopupLoader(context);
            }
            // Handle OTP send success
            else if (state is SendOtpOnEmailSuccess) {
              setState(() {
                _isSendingOtp = false;
              });
              CherryToast.success(context, "Verification code sent to your email!");
              _navigateToOtpScreen();
            }
            // Handle OTP send error
            else if (state is SendOtpOnEmailError) {
              setState(() {
                _isSendingOtp = false;
              });
              CherryToast.error(context, state.message);
            }
            // Handle OTP send loading
            else if (state is SendOtpScreenLoading) {
              setState(() {
                _isSendingOtp = true;
              });
            }
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    vGap(headerHeight),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 15,
                          children: [
                            Row(
                              spacing: 3,
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
                              readonly: _isEmailVerified,
                              controller: _emailController,
                              hint: AppLocalizations.of(context)!.emailAddress,
                              onChanged: (value) {
                                if (_isEmailVerified) {
                                  _resetEmailVerification();
                                }
                              },
                              suffix: TextButton(
                                onPressed: (_isEmailVerified || _isSendingOtp || _isCheckingVerification)
                                    ? null
                                    : _handleEmailVerification,
                                child: _buildEmailVerificationButton(),
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
                                onPressed: () {
                                  // TODO: Implement phone verification
                                },
                                child: Text(
                                  _isPhoneVerified
                                      ? AppLocalizations.of(context)!.verified
                                      : AppLocalizations.of(context)!.verify,
                                  textAlign: TextAlign.center,
                                  style: MontserratStyles.montserratMediumTextStyle(
                                    color: _isPhoneVerified
                                        ? Colors.green
                                        : AppColor().darkYellowColor,
                                  ),
                                ),
                              ),
                              icon: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomContainer(
                                  height: 35,
                                  width: 90,
                                  border: Border(
                                    right: BorderSide(
                                      width: 1,
                                      color: AppColor().silverShadeGrayColor,
                                    ),
                                  ),
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(0),
                                      topLeft: Radius.circular(48),
                                      bottomLeft: Radius.circular(48),
                                      bottomRight: Radius.circular(0)
                                  ),
                                  backgroundColor: AppColor().backgroundColor,
                                  padding: const EdgeInsets.all(8),
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
                                        MediaQuery.of(context).size.height * 0.6
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
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                            CustomPasswordField(
                              borderRadius: 48,
                              borderWidth: 1,
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
                              prefix: const Icon(Icons.lock, color: Colors.grey),
                            ),
                            CustomPasswordField(
                              borderRadius: 48,
                              borderWidth: 1,
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
                              prefix: const Icon(Icons.lock, color: Colors.grey),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40.0),
                              child: Row(
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
                                        style: MontserratStyles.montserratMediumTextStyle(
                                          size: 14,
                                          color: AppColor().silverShadeGrayColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!.termsPrivacy,
                                            style: MontserratStyles.montserratMediumTextStyle(
                                              size: 14,
                                              color: AppColor().darkCharcoalBlueColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: BlocBuilder<SignUpScreenBloc, SignUpScreenState>(
                                bloc: _signUpBloc,
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
                                    textStyle: MontserratStyles.montserratMediumTextStyle(
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
                                  style: MontserratStyles.montserratMediumTextStyle(
                                    size: 14,
                                    color: AppColor().silverShadeGrayColor,
                                  ),
                                ),
                                hGap(10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.signIn,
                                    style: MontserratStyles.montserratMediumTextStyle(
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
                child: UpperContainerWidget(height: headerHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    bool readonly = false,
    Widget? icon,
    final Widget? suffix,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return CustomTextField(
      controller: controller,
      readOnly: readonly,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      fillColor: AppColor().backgroundColor,
      hintText: hint,
      suffixIcon: suffix,
      onChanged: onChanged,
      hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
        size: 14,
        color: AppColor().silverShadeGrayColor,
      ),
      borderRadius: 48,
      prefixIcon: icon,
      borderWidth: 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        if (hint == 'Email Address') {
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return 'Please enter a valid email';
          }
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