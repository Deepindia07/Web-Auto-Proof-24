part of 'signUp_screen_route_imple.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenScreenState();
}

class _RegistrationScreenScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _retypePasswordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _retypePasswordController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
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
      hintStyle: MontserratStyles.montserratRegularTextStyle(size: 16,color: AppColor().silverShadeGrayColor),
      borderRadius: 48,
      prefixIcon: Icon(icon,color: Colors.grey[500],size: 20,),
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
      // suffixIcon: isPassword?,
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      children: List.generate(
        3,
            (index) => Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(
            color: Color(0xFFD4AF37),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final headerHeight = 200.0 + statusBarHeight + 40;

    return BlocProvider<SignUpScreenBloc>(
  create: (context) => SignUpScreenBloc(),
  child: Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                vGap(headerHeight+40),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 15,
                      children: [
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _fullNameController,
                          hint: 'Full Name',
                          icon: Icons.person_outline,
                          keyboardType: TextInputType.name,
                        ),
                        _buildTextField(
                          controller: _emailController,
                          hint: 'Email Address',
                          suffix: TextButton(onPressed: (){}, child: Text("Verify!",textAlign: TextAlign.center,style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkYellowColor))),
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        _buildTextField(
                          controller: _phoneController,
                          hint: 'Phone',
                          suffix: TextButton(onPressed: (){}, child: Text("Verify!",textAlign: TextAlign.center,style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkYellowColor),)),
                          icon: Icons.phone_android_rounded,
                          keyboardType: TextInputType.phone,
                        ),

                        CustomPasswordField(
                          borderRadius: 48,
                          borderWidth: 3,
                          fillColor: AppColor().backgroundColor,
                          controller: _passwordController,
                          hintText: "Password",
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            if (value == 'Email Address' && !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            if (value == 'Password' && value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (value == 'Retype Password' && value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          prefix: Icon(Icons.lock,color: Colors.grey,),
                        ),
                        CustomPasswordField(
                          borderRadius: 48,
                          borderWidth: 3,
                          fillColor: AppColor().backgroundColor,
                          controller: _retypePasswordController,
                          hintText: "Retype Password",
                          validator: (value){
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            if (value == 'Email Address' && !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            if (value == 'Password' && value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (value == 'Retype Password' && value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          prefix: Icon(Icons.lock,color: Colors.grey,),
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
                                  style: MontserratStyles.montserratMediumTextStyle(size: 14,color: AppColor().silverShadeGrayColor),
                                  children:  [
                                    TextSpan(
                                      text: 'Terms & Privacy',
                                      style: MontserratStyles.montserratMediumTextStyle(size: 14,color: AppColor().darkCharcoalBlueColor),
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
                          child: CustomButton(
                            onPressed: _agreeToTerms != false ? () {
                              if (_formKey.currentState!.validate() && _agreeToTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Account created successfully!'),
                                    backgroundColor: Color(0xFF2D3748),
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
                            } : null,
                            text: "Create an Account",
                            borderRadius: 48,
                            textStyle: MontserratStyles.montserratMediumTextStyle(
                              color: _agreeToTerms!= false?AppColor().yellowWarmColor:AppColor().darkCharcoalBlueColor,
                              size: 18,
                            ),
                            elevation: 5,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?  ',
                              style: MontserratStyles.montserratMediumTextStyle(size: 14,color: AppColor().silverShadeGrayColor),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigate to sign in screen
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Sign In',
                                style: MontserratStyles.montserratMediumTextStyle(size: 14,color: AppColor().darkCharcoalBlueColor),
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
                // Add shadow for better visual separation
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
);
  }
}