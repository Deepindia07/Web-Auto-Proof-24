part of 'login_screen_route_imple.dart';

int selectedIndex = 0;

class LoginScreen extends StatelessWidget {
  final String userRole;

  const LoginScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginScreenBloc>(
      create: (context) => LoginScreenBloc(
        authRepository: AuthenticationApiCall(),
        userRole: userRole,
      ),
      child: LoginViewScreen(userRole: userRole),
    );
  }
}

class LoginViewScreen extends StatefulWidget {
  final String userRole;
  const LoginViewScreen({super.key, required this.userRole});

  @override
  State<LoginViewScreen> createState() => _LoginViewScreenState();
}

class _LoginViewScreenState extends State<LoginViewScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _instructorRefrenceNumberController =
      TextEditingController();
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
          refNo: _instructorRefrenceNumberController.text.trim(),
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

  /// Validation
  bool _isValidEmailOrPhone(String input) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^[\+]?[1-9][\d]{0,15}$');
    return emailRegex.hasMatch(input) || phoneRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Responsive.isDesktop(context)
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 130.0,
                        vertical: 30,
                      ),
                      child: _buildPortraitLayout(context),
                    ),
                  ),
                  Expanded(child: CommonViewAuth()),
                ],
              )
            : Center(
                // For mobile/tablet, keep it centered with maxWidth
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 30,
                    ),
                    constraints: BoxConstraints(maxWidth: 600),
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
                    child: _buildPortraitLayout(context),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),

      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.userRole != "owner") vGap(screenHeight * 0.09),

                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        /*   Text(
                          AppLocalizations.of(context)!.selectLanguage,
                          style: MontserratStyles.montserratSemiBoldTextStyle(
                            size: 12,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                        vGap(screenHeight * 0.0120),
                        BlocBuilder<
                          LocalizationsBlocController,
                          LocalizationsState
                        >(
                          builder: (context, state) {
                            final currentLocale =
                                state.locale ?? const Locale('en');

                            // Map locale to index
                            selectedIndex = currentLocale.languageCode == 'en'
                                ? 0
                                : 1;

                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ToggleButtons(
                                borderRadius: BorderRadius.circular(30),
                                borderWidth: 0,
                                borderColor: Colors.transparent,
                                selectedBorderColor: Colors.transparent,
                                fillColor: Colors.amber,
                                selectedColor: Colors.white,
                                color: Colors.black,
                                constraints: const BoxConstraints(
                                  minWidth: 120,
                                  minHeight: 35,
                                ),
                                isSelected: [
                                  selectedIndex == 0, // English
                                  selectedIndex == 1, // French
                                ],
                                onPressed: (index) {
                                  final newLocale = index == 0
                                      ? const Locale('en')
                                      : const Locale('fr');

                                  // Dispatch change event to bloc
                                  context
                                      .read<LocalizationsBlocController>()
                                      .add(ChangeLanguageEvent(newLocale));
                                },
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.english,
                                    style:
                                        MontserratStyles.montserratSemiBoldTextStyle(
                                          size: 12,
                                          color:
                                              AppColor().darkCharcoalBlueColor,
                                        ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.frenchText,
                                    style:
                                        MontserratStyles.montserratSemiBoldTextStyle(
                                          size: 12,
                                          color:
                                              AppColor().darkCharcoalBlueColor,
                                        ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        vGap(screenHeight * 0.02),*/
                        Image.asset(
                          appLogo,
                          height: screenHeight * 0.126,
                          width: screenHeight * 0.126,
                          fit: BoxFit.contain,
                        ),

                        Text(
                          "Auto Proof 24",
                          style: MontserratStyles.montserratBoldTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                            size: 35,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  vGap(screenHeight * 0.0110),
                  Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: MontserratStyles.montserratSemiBoldTextStyle(
                      size: 12,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                  vGap(screenHeight * 0.0120),
                  // Form fields
                  _buildFormFields(context, screenHeight, screenWidth, false),

                  // Buttons
                  _buildButtons(context, screenHeight, screenWidth, false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(
    BuildContext context,
    double screenHeight,
    double screenWidth,
    bool isLandscape,
  ) {
    final verticalSpacing = isLandscape
        ? screenHeight * 0.025
        : screenHeight * 0.0162;
    final topSpacing = isLandscape
        ? screenHeight * 0.02
        : screenHeight * 0.0315;

    return Column(
      children: [
        vGap(2),
        if (widget.userRole != "instructor") vGap(verticalSpacing),
        if (widget.userRole != "instructor")
          CustomTextField(
            borderWidth: 2,
            borderColor: AppColor().darkCharcoalBlueColor,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            controller: _emailOrPhoneController,
            fillColor: Colors.white,
            borderRadius: 30,

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

        //---------- Password field
        if (widget.userRole != "instructor") vGap(verticalSpacing),
        if (widget.userRole != "instructor")
          CustomPasswordField(
            borderColor: AppColor().darkCharcoalBlueColor,
            obscuringCharacter: "*",
            onSubmitted: (value) {
              _onLoginPressed();
            },
            controller: _passwordController,
            borderWidth: 2,
            fillColor: Colors.white,
            borderRadius: 30,
            hintText: AppLocalizations.of(context)!.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.pleaseEnterPassword;
              }
              return null;
            },
          ),

        // Forgot password link
        if (widget.userRole != "instructor") vGap(verticalSpacing),
        if (widget.userRole != "instructor")
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: _onForgetPasswordPressed,
                child: Text(
                  AppLocalizations.of(context)!.forgotPassword,
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: isLandscape ? 11 : 14,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildButtons(
    BuildContext context,
    double screenHeight,
    double screenWidth,
    bool isLandscape,
  ) {
    final verticalSpacing = isLandscape
        ? screenHeight * 0.025
        : screenHeight * 0.0162;

    return Column(
      children: [
        vGap(verticalSpacing),
        BlocConsumer<LoginScreenBloc, LoginScreenState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              CherryToast.success(
                context,
                AppLocalizations.of(context)!.loginSuccessful,
              );
              context.go(AppRoute.homeScreen);
            } else if (state is EmployeeLoginSuccess) {
              CherryToast.success(
                context,
                AppLocalizations.of(context)!.loginSuccessful,
              );
              context.go(AppRoute.homeScreen);
            } else if (state is LoginFailure) {
              // add localization text --------------
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
              // add localization text --------------
              CherryToast.error(context, state.error);
            }
          },
          builder: (context, state) {
            return CustomButton(
              borderRadius: 48,
              height: 45,
              width: double.infinity,

              onPressed:
                  state is LoginLoading || state is EmailValidationLoading
                  ? null
                  : _onLoginPressed,
              text: state is LoginLoading
                  ? AppLocalizations.of(context)!.loggingIn
                  : AppLocalizations.of(context)!.login,
              textStyle: MontserratStyles.montserratMediumTextStyle(
                color: AppColor().yellowWarmColor,
                size: isLandscape ? 14 : 16,
              ),
              elevation: 5,
              child: state is LoginLoading
                  ? SizedBox(
                      height: isLandscape ? 16 : 18,
                      width: isLandscape ? 16 : 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor().yellowWarmColor,
                      ),
                    )
                  : null,
            );
          },
        ),

        // "Or" text and create account button (only for non-instructor)
        if (widget.userRole != "instructor") ...[
          vGap(verticalSpacing),
          BlocBuilder<LoginScreenBloc, LoginScreenState>(
            builder: (context, state) {
              if (state is EmailValidationLoading) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: isLandscape ? 12 : 14,
                      width: isLandscape ? 12 : 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.validatingEmail,
                      style: MontserratStyles.montserratRegularTextStyle(
                        size: isLandscape ? 11 : 13,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                  ],
                );
              }
              return Text(
                AppLocalizations.of(context)!.or,
                style: MontserratStyles.montserratRegularTextStyle(
                  size: isLandscape ? 12 : 14,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              );
            },
          ),
          vGap(verticalSpacing),
          CustomButton(
            borderRadius: 48,
            height: 45,
            width: double.infinity,
            onPressed: () {
              SharedPrefsHelper.instance.setBool(isVerifiedEmail, false);
              context.push(AppRoute.signUpScreen);
            },
            text: AppLocalizations.of(context)!.createAccount,
            textStyle: MontserratStyles.montserratMediumTextStyle(
              color: AppColor().yellowWarmColor,
              size: isLandscape ? 13 : 15,
            ),
            elevation: 5,
          ),
        ],
      ],
    );
  }
}
