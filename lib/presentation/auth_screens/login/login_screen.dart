part of 'login_screen_route_imple.dart';

class LoginScreen extends StatelessWidget {
  final String userRole;

  const LoginScreen({
    super.key,
   required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginScreenBloc>(
      create: (context) =>
          LoginScreenBloc(authRepository: AuthenticationApiCall()),
      child: LoginViewScreen(userRole: userRole,),
    );
  }
}

class LoginViewScreen extends StatefulWidget {
  final String userRole;
  const LoginViewScreen({super.key,required this.userRole});

  @override
  State<LoginViewScreen> createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _instructorRefrenceNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    _instructorRefrenceNumberController.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      CustomLoader.showPopupLoader(context);
      await Future.delayed(Duration(seconds: 3));
      CustomLoader.hidePopupLoader(context);
      context.read<LoginScreenBloc>().add(
        LoginSubmitted(
          emailOrPhone: _emailOrPhoneController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  void _onForgetPasswordPressed() {
    final emailOrPhone = _emailOrPhoneController.text.trim();

    if (emailOrPhone.isEmpty) {
      CherryToast.error(
        context,
        AppLocalizations.of(context)!.pleaseEnterEmailOrPhoneFirst,
      );
      return;
    }
    if (!_isValidEmailOrPhone(emailOrPhone)) {
      CherryToast.error(
        context,
        AppLocalizations.of(context)!.pleaseEnterValidEmailOrPhone,
      );
      return;
    }

    context.read<LoginScreenBloc>().add(
      EmailValidationCheck(emailOrPhone: emailOrPhone),
    );
  }

  ///  Validation
  bool _isValidEmailOrPhone(String input) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^[\+]?[1-9][\d]{0,15}$');

    return emailRegex.hasMatch(input) || phoneRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor().backgroundColor,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(widget.userRole!="owner")
                  vGap(screenHeight*0.1),
                  SizedBox(
                    height: screenHeight * 0.24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          appLogo,
                          height: screenHeight * 0.16,
                          width: screenHeight * 0.16,
                          fit: BoxFit.contain,
                        ),
                        vGap(screenHeight * 0.015),
                        Text(
                          "Auto Proof 24",
                          style: MontserratStyles.montserratBoldTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                            size: screenWidth * 0.11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  vGap(screenHeight * 0.012),
                  Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: MontserratStyles.montserratRegularTextStyle(
                      size: 16,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                  if(widget.userRole!="owner")
                    vGap(screenHeight * 0.030),
                  if(widget.userRole!="owner")
                    CustomTextField(
                      controller: _instructorRefrenceNumberController,
                      fillColor: AppColor().backgroundColor,
                      borderWidth: 2,
                      borderRadius: 30,
                      hintStyle: MontserratStyles.montserratRegularTextStyle(
                        size: 16,
                        color: AppColor().silverShadeGrayColor,
                      ),
                      hintText: "Enter Registration Number"/*AppLocalizations.of(context)!.emailOrPhone*/,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.pleaseEnterEmailOrPhoneShort;
                        }
                        return null;
                      },
                    ),
                  if(widget.userRole!="instructor")
                    vGap(screenHeight * 0.018),
                  if(widget.userRole!="instructor")
                  CustomTextField(
                    controller: _emailOrPhoneController,
                    fillColor: AppColor().backgroundColor,
                    borderWidth: 2,
                    borderRadius: 30,
                    hintStyle: MontserratStyles.montserratRegularTextStyle(
                      size: 16,
                      color: AppColor().silverShadeGrayColor,
                    ),
                    hintText: AppLocalizations.of(context)!.emailOrPhone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          context,
                        )!.pleaseEnterEmailOrPhoneShort;
                      }
                      return null;
                    },
                  ),
                  if(widget.userRole!="instructor")
                    vGap(screenHeight * 0.018),
                  if(widget.userRole!="instructor")
                    CustomPasswordField(
                    controller: _passwordController,
                    borderWidth: 2,
                    fillColor: AppColor().backgroundColor,
                    borderRadius: 30,
                    hintText: AppLocalizations.of(context)!.password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(
                          context,
                        )!.pleaseEnterPassword;
                      }
                      return null;
                    },
                  ),
                  if(widget.userRole!="instructor")
                    vGap(screenHeight * 0.018),
                  if(widget.userRole!="instructor")
                    Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: _onForgetPasswordPressed,
                        child: Text(
                          AppLocalizations.of(context)!.forgotPassword,
                          style: MontserratStyles.montserratSemiBoldTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  vGap(screenHeight * 0.018),
                  BlocConsumer<LoginScreenBloc, LoginScreenState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        CherryToast.success(
                          context,
                          AppLocalizations.of(context)!.loginSuccessful,
                        );
                        context.pushReplacement(AppRoute.homeScreen);
                      } else if (state is LoginFailure) {
                        CherryToast.error(context, state.error);
                      } else if (state is EmailValidationSuccess) {
                        CherryToast.success(
                          context,
                          AppLocalizations.of(context)!.emailValidated,
                        );
                        context.push(
                          AppRoute.forgotScreen,
                          extra: {
                            'email': state.emailOrPhone,
                            'response': state.forgotResponse,
                          },
                        );
                      } else if (state is EmailValidationFailure) {
                        CherryToast.error(context, state.error);
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        borderRadius: 48,
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.95,
                        /*onPressed: () {
                          context.push(AppRoute.homeScreen);
                        },*/
                        onPressed: state is LoginLoading || state is EmailValidationLoading
                            ? null
                            : _onLoginPressed,
                        text: state is LoginLoading
                            ? AppLocalizations.of(context)!.loggingIn
                            : AppLocalizations.of(context)!.login,
                        textStyle: MontserratStyles.montserratMediumTextStyle(
                          color: AppColor().yellowWarmColor,
                          size: 18,
                        ),
                        elevation: 5,
                        child: state is LoginLoading
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColor().yellowWarmColor,
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                  if(widget.userRole!="instructor")
                    vGap(screenHeight * 0.018),
                  if(widget.userRole!="instructor")
                    BlocBuilder<LoginScreenBloc, LoginScreenState>(
                    builder: (context, state) {
                      if (state is EmailValidationLoading) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColor().darkCharcoalBlueColor,
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.validatingEmail,
                              style:
                                  MontserratStyles.montserratRegularTextStyle(
                                    size: 14,
                                    color: AppColor().darkCharcoalBlueColor,
                                  ),
                            ),
                          ],
                        );
                      }
                      return Text(
                        AppLocalizations.of(context)!.or,
                        style: MontserratStyles.montserratRegularTextStyle(
                          size: 16,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      );
                    },
                  ),
                  if(widget.userRole!="instructor")
                    vGap(screenHeight * 0.018),
                  if(widget.userRole!="instructor")
                    CustomButton(
                    borderRadius: 48,
                    height: screenHeight * 0.07,
                    width: screenWidth * 0.95,
                    onPressed: () {
                      context.push(AppRoute.signUpScreen);
                    },
                    text: AppLocalizations.of(context)!.createAccount,
                    textStyle: MontserratStyles.montserratMediumTextStyle(
                      color: AppColor().yellowWarmColor,
                      size: 18,
                    ),
                    elevation: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
