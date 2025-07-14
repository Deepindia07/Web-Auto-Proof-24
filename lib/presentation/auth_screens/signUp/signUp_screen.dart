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
  bool _isVerified = false; // Changed from late to regular bool

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
      // Extract country code and phone number
      String fullPhoneNumber = _phoneController.text;
      String countryCode = "+91";
      String phoneNumber = fullPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');

      // Trigger the registration event
      context.read<SignUpScreenBloc>().add(
        RegisterUser(
          firstName: _fullNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          countryCode: countryCode,
          phoneNumber: phoneNumber,
          password: _passwordController.text,
          isEmailVerified: true,
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

  void _handleEmailVerification() {
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

    // Check if email is valid
    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Toggle verification state
    setState(() {
      _isVerified = !_isVerified;
    });

    // Show success message when verified
    if (_isVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email verified successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }

    // Here you can add actual email verification logic
    // For example, navigate to OTP screen or send verification email
    // context.push(AppRoute.otpScreen);
  }

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
                    vGap(headerHeight + 40),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 15,
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              spacing: 2,
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    controller: _fullNameController,
                                    hint: 'Full Name',
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Expanded(
                                  child: _buildTextField(
                                    controller: _lastNameController,
                                    hint: 'Last Name',
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                            _buildTextField(
                              controller: _emailController,
                              hint: 'Email Address',
                              suffix: TextButton(
                                onPressed: _handleEmailVerification,
                                child: Text(
                                  _isVerified ? "Verified" : "Verify",
                                  textAlign: TextAlign.center,
                                  style: MontserratStyles
                                      .montserratMediumTextStyle(
                                    color: _isVerified
                                        ? Colors.green
                                        : AppColor().darkYellowColor,
                                  ),
                                ),
                              ),
                              icon: Icons.mail_outline,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            _buildTextField(
                              controller: _phoneController,
                              hint: 'Phone',
                              suffix: TextButton(
                                onPressed: () {
                                  // Add phone verification logic here
                                },
                                child: Text(
                                  "Verify!",
                                  textAlign: TextAlign.center,
                                  style: MontserratStyles
                                      .montserratMediumTextStyle(
                                    color: AppColor().darkYellowColor,
                                  ),
                                ),
                              ),
                              icon: Icons.phone_android_rounded,
                              keyboardType: TextInputType.phone,
                            ),
                            CustomPasswordField(
                              borderRadius: 48,
                              borderWidth: 3,
                              fillColor: AppColor().backgroundColor,
                              controller: _passwordController,
                              hintText: "Password",
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
                              hintText: "Retype Password",
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
                                      text: 'I agree to the ',
                                      style: MontserratStyles
                                          .montserratMediumTextStyle(
                                        size: 14,
                                        color: AppColor().silverShadeGrayColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Terms & Privacy',
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
                                        ? "Creating Account..."
                                        : "Create an Account",
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
                                  'Already have an account?  ',
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
                                    'Sign In',
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
              // Header section (same as before)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor().darkCharcoalBlueColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            contextsIcon,
                            height: 200,
                            width: 200,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Keep your existing _buildTextField method
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
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
      prefixIcon: icon != null
          ? Icon(icon, color: Colors.grey[500], size: 20)
          : null,
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