part of 'signUp_screen_route_imple.dart';

class SignUpScreen extends StatefulWidget {
  final String email;
  const SignUpScreen({super.key, required this.email});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController authorizationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController retypePasController = TextEditingController();
  final TextEditingController approvalController = TextEditingController();
  bool _agreeToTerms = false;
  bool _isEmailVerified = false;
  bool _isSendingOtp = false;
  bool _isCheckingVerification = false;
  String selectedCountryCode = "+33";
  late final SignUpScreenBloc _signUpBloc;
  String? phoneError = "";
  bool termsPrivacy = false;
  String inputType = "";
  bool isVerifying = false;
  bool isVerified = false;
  bool obscurePassword = true;
  bool obscureRePassword = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    emailController.text = widget.email.toString();
    _signUpBloc = SignUpScreenBloc(apiRepository: AuthenticationApiCall());
    _loadEmailVerificationStatus();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _loadEmailVerificationStatus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    fullNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    phoneController.dispose();
    retypePasController.dispose();
    _signUpBloc.close();
    super.dispose();
  }

  void _loadEmailVerificationStatus() async {
    setState(() {
      _isCheckingVerification = true;
    });

    try {
      final isVerified = await SharedPrefsHelper.instance.getBool(
        isVerifiedEmail,
      );
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

  void _handleRegistration(BuildContext context) {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      if (!_isEmailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.verifyEmailAddress),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      String fullPhoneNumber = phoneController.text;
      String phoneNumber = fullPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');

      _signUpBloc.add(
        RegisterUser(
          firstName: fullNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          countryCode: selectedCountryCode,
          phoneNumber: phoneNumber,
          password: passwordController.text,
          isEmailVerified: _isEmailVerified,
          termsAndConditions: _agreeToTerms,
        ),
      );
    } else if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.agreeTermsPrivacy),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleEmailVerification() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.enterEmail),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(emailController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.emailInvalid),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSendingOtp = true;
    });

    _signUpBloc.add(
      SendOtpEmailSignUpEvent(email: emailController.text.trim()),
    );
  }

  void _navigateToOtpScreen() async {
    print("email-----${emailController.text}");
    final result = await context.push(
      AppRoute.otpScreen,
      extra: {
        'email': emailController.text,
        'isEmailFromSignUp': true,
        'otpType': '1',
      },
    );

    _loadEmailVerificationStatus();

    if (result == true) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.emailSuccessfully),
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

  void _saveEmailVerificationStatus(bool isVerified) async {
    try {
      await SharedPrefsHelper.instance.setBool(isVerifiedEmail, isVerified);
    } catch (e) {
      print('Error saving email verification status: $e');
    }
  }

  Widget _buildEmailVerificationButton() {
    if (_isCheckingVerification) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor().darkYellowColor),
        ),
      );
    }

    if (_isSendingOtp) {
      return SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor().darkYellowColor),
        ),
      );
    }

    return Text(
      _isEmailVerified
          ? AppLocalizations.of(context)!.verified
          : AppLocalizations.of(context)!.verify,
      textAlign: TextAlign.center,
      style: MontserratStyles.montserratMediumTextStyle(
        color: _isEmailVerified ? Colors.green : AppColor().darkYellowColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider<SignUpScreenBloc>.value(
          value: _signUpBloc,
          child: Responsive.isDesktop(context)
              ? Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: bodyWidget(screenHeight, screenWidth),
                      ),
                    ),
                    Expanded(child: CommonViewAuth()),
                  ],
                )
              : Container(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: bodyWidget(screenHeight, screenWidth),
                ),
        ),
      ),
    );
  }

  bodyWidget(screenHeight, screenWidth) {
    return BlocListener<SignUpScreenBloc, SignUpScreenState>(
      bloc: _signUpBloc,
      listener: (context, state) {
        // Handle registration success/error
        if (state is SignUpScreenSuccess) {
          CustomLoader.hidePopupLoader(context);

          CherryToast.success(
            context,
            AppLocalizations.of(context)!.accountCreatedSuccessfully,
          );
          // Clear verification status after successful registration
          _saveEmailVerificationStatus(false);
          context.pushNamed("login");
        } else if (state is SignUpScreenError) {
          CustomLoader.hidePopupLoader(context);
          CherryToast.error(context, state.message);
        } else if (state is SignUpSendOtpScreenLoading) {
          CustomLoader.showPopupLoader(context);
        }
        // Handle OTP send success
        else if (state is SignUpSendOtpOnEmailSuccess) {
          setState(() {
            _isSendingOtp = false;
          });
          CherryToast.success(
            context,
            AppLocalizations.of(context)!.verificationOtpMsg,
          );
          _navigateToOtpScreen();
        }
        // Handle OTP send error
        else if (state is SignUpSendOtpOnEmailError) {
          setState(() {
            _isSendingOtp = false;
          });

          // add localization text --------------
          CherryToast.error(context, state.message);
        }
        // Handle OTP send loading
        else if (state is SignUpSendOtpScreenLoading) {
          setState(() {
            _isSendingOtp = true;
          });
        }
      },
      child: Column(
        children: [
          UpperContainerWidget(height: screenHeight / 4),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(height: 30),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              validator: InputValidators.validateFirstName,
                              controller: fullNameController,
                              hintText: AppLocalizations.of(context)!.firstName,
                              borderRadius: 30,
                              fillColor: Colors.transparent,
                              borderColor: AppColor().darkCharcoalBlueColor,
                              borderWidth: 2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              validator: InputValidators.validateLastName,
                              controller: lastNameController,
                              hintText: AppLocalizations.of(context)!.lastName,

                              borderRadius: 30,
                              fillColor: Colors.transparent,
                              borderColor: AppColor().darkCharcoalBlueColor,
                              borderWidth: 2,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 15),

                      CustomTextField(
                        keyboardType: TextInputType.emailAddress,
                        readOnly: _isEmailVerified,
                        validator: InputValidators.validateEmailOrPhone,
                        controller: emailController,

                        prefixIcon: Icon(
                          _isEmailVerified
                              ? Icons.verified
                              : Icons.mail_outline,
                          color: _isEmailVerified ? Colors.green : null,
                        ),
                        suffixIcon: TextButton(
                          onPressed:
                              (_isEmailVerified ||
                                  _isSendingOtp ||
                                  _isCheckingVerification)
                              ? null
                              : _handleEmailVerification,
                          child: _buildEmailVerificationButton(),
                        ),
                        hintText: AppLocalizations.of(context)!.emailAddress,

                        borderRadius: 48,
                        fillColor: Colors.transparent,
                        borderColor: AppColor().darkCharcoalBlueColor,
                        borderWidth: 2,
                        onChanged: (value) {
                          if (_isEmailVerified) {
                            _resetEmailVerification();
                          }
                        },
                      ),

                      Container(height: 15),
                      PhoneNumberField(
                        controller: phoneController,
                        isVerified: false,
                        onVerify: () {},
                      ),
                      Container(height: 15),
                      CustomTextField(
                        obscureText: obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                        obscuringCharacter: '*',
                        validator: InputValidators.validatePassword,
                        controller: passwordController,
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        hintText: AppLocalizations.of(context)!.password,
                        borderRadius: 30,
                        fillColor: Colors.transparent,
                        borderColor: AppColor().darkCharcoalBlueColor,
                        borderWidth: 2,
                      ),
                      Container(height: 15),
                      CustomTextField(
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureRePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureRePassword = !obscureRePassword;
                            });
                          },
                        ),
                        obscuringCharacter: '*',
                        validator: (value) =>
                            InputValidators.validateConfirmPassword(
                              value,
                              retypePasController.text,
                            ),
                        controller: retypePasController,
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        obscureText: obscureRePassword,
                        hintText: AppLocalizations.of(context)!.retypePassword,
                        borderRadius: 30,
                        fillColor: Colors.transparent,
                        borderColor: AppColor().darkCharcoalBlueColor,
                        borderWidth: 2,
                      ),

                      SizedBox(height: 30),
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

                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text: AppLocalizations.of(
                                    context,
                                  )!.agreeTerms,
                                  style:
                                      MontserratStyles.montserratMediumTextStyle(
                                        size: 14,
                                        color: AppColor().silverShadeGrayColor,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _agreeToTerms = !_agreeToTerms;
                                      setState(() {});
                                      print("Agree Terms clicked");
                                    },
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.terms,
                                      style:
                                          MontserratStyles.montserratMediumTextStyle(
                                            size: 14,
                                            color: AppColor()
                                                .darkCharcoalBlueColor,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _openLink(
                                            "https://www.autoproof24.com/termes-et-conditions/",
                                          );
                                          // 👉 Link 1
                                          print(
                                            "Terms clicked - open Terms link",
                                          );
                                          // launchUrl(Uri.parse("https://example.com/terms"));
                                        },
                                    ),
                                    TextSpan(
                                      text: " & ", // connector
                                      style:
                                          MontserratStyles.montserratMediumTextStyle(
                                            size: 14,
                                            color: AppColor()
                                                .darkCharcoalBlueColor,
                                          ),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.privacy,
                                      style:
                                          MontserratStyles.montserratMediumTextStyle(
                                            size: 14,
                                            color: AppColor()
                                                .darkCharcoalBlueColor,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _openLink(
                                            "https://www.autoproof24.com/politique-de-confidentialite/",
                                          );
                                          // 👉 Link 2
                                          print(
                                            "Privacy clicked - open Privacy link",
                                          );
                                          // launchUrl(Uri.parse("https://example.com/privacy"));
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: BlocBuilder<SignUpScreenBloc, SignUpScreenState>(
                          bloc: _signUpBloc,
                          builder: (context, state) {
                            bool isLoading = state is SignUpScreenLoading;

                            return CustomButton(
                              onPressed: _agreeToTerms && !isLoading
                                  ? () => _handleRegistration(context)
                                  : null,
                              text: isLoading
                                  ? AppLocalizations.of(
                                      context,
                                    )!.creatingAccount
                                  : AppLocalizations.of(
                                      context,
                                    )!.createAnAccountTitle,
                              borderRadius: 48,
                              textStyle:
                                  MontserratStyles.montserratMediumTextStyle(
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
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!.haveAccount,
                          style: MontserratStyles.montserratSemiBoldTextStyle(
                            color: AppColor().silverShadeGrayColor,
                            size: 14,
                          ),
                          children: [
                            TextSpan(
                              text: AppLocalizations.of(context)!.signIn,
                              style:
                                  MontserratStyles.montserratSemiBoldTextStyle(
                                    color: AppColor().darkCharcoalBlueColor,
                                    size: 14,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LoginScreen(userRole: ''),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      // add localization text --------------
      throw Exception("Could not launch $url");
    }
  }

  void customGetValue() {
    final input = emailController.text.trim();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');

    if (emailRegex.hasMatch(input)) {
      inputType = 'email';
    } else if (phoneRegex.hasMatch(input)) {
      inputType = 'phone';
    } else {
      inputType = 'invalid';
    }

    print("User input: $input");
    print("Detected type: $inputType");
  }
}
