part of 'reset_password_screen_route_imple.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String? email;
  const ResetPasswordScreen({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ResetPasswordScreenBloc(repository: AuthenticationApiCall()),
      child: ResetPasswordView(email: email),
    );
  }
}

class ResetPasswordView extends StatefulWidget {
  final String? email;
  const ResetPasswordView({super.key, required this.email});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool obscureRePassword = true;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    setState(() {
      _passwordError = null;
      _confirmPasswordError = null;

      // Check if password is empty
      if (_newPasswordController.text.isEmpty) {
        _passwordError = AppLocalizations.of(context)!.passwordRequired;
        return;
      }

      // Check minimum password length
      if (_newPasswordController.text.length < 6) {
        _passwordError = AppLocalizations.of(context)!.passwordMinLength;
        return;
      }

      // Check if confirm password is empty
      if (_confirmNewPasswordController.text.isEmpty) {
        _confirmPasswordError = AppLocalizations.of(
          context,
        )!.pleaseConfirmPassword;
        return;
      }

      // Check if passwords match
      if (_newPasswordController.text != _confirmNewPasswordController.text) {
        _confirmPasswordError = AppLocalizations.of(
          context,
        )!.passwordsDoNotMatch;
        return;
      }
    });
  }

  void _createPassword() {
    context.push(AppRoute.homeScreen);
    _validatePasswords();

    // Only proceed if validation passes
    if (_passwordError == null && _confirmPasswordError == null) {
      context.read<ResetPasswordScreenBloc>().add(
        ResetPasswordSubmitted(
          email: widget.email ?? '',
          password: _newPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Responsive.isDesktop(context)
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: resetWidget(screenSize),
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
                child: resetWidget(screenSize),
              ),
      ),
    );
  }

  Widget resetWidget(screenSize) {
    return BlocConsumer<ResetPasswordScreenBloc, ResetPasswordScreenState>(
      listener: (context, state) {
        if (state is ResetPasswordScreenLoading) {
          CustomLoader.showPopupLoader(context);
        } else {
          CustomLoader.hidePopupLoader(context);

          if (state is ResetPasswordScreenSuccess) {
            CherryToast.success(
              context,
              AppLocalizations.of(context)!.passwordResetSuccess,
            );
            context.pushNamed('login');
          } else if (state is ResetPasswordScreenFailure) {
            // add localization text --------------
            CherryToast.error(context, state.error);
          }
        }
      },
      builder: (context, state) {
        return Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 600),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 42),
                          Image.asset(
                            lockLayer1Icon,
                            height: 72,
                            width: 62,
                            fit: BoxFit.cover,
                          ),
                          vGap(10),
                          Text(
                            AppLocalizations.of(context)!.reset,
                            style: MontserratStyles.montserratBoldTextStyle(
                              size: 30,
                              color: AppColor().darkCharcoalBlueColor,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.password,
                            style: MontserratStyles.montserratMediumTextStyle(
                              size: 28,
                              color: AppColor().darkCharcoalBlueColor,
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF9CA3AF),
                                height: 1.4,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.emailSentMessage}\n',
                                  style:
                                      MontserratStyles.montserratNormalTextStyle(
                                        color: AppColor().silverShadeGrayColor,
                                        size: 14,
                                      ),
                                ),
                                TextSpan(
                                  text: maskEmail('${widget.email}'),
                                  style:
                                      MontserratStyles.montserratNormalTextStyle(
                                        color: AppColor().silverShadeGrayColor,
                                        size: 14,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          vGap(20),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: screenSize.height * 0.45,
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColor().darkCharcoalBlueColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      ),
                    ),
                    child: Column(
                      children: [
                        vGap(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              hintStyle:
                                  MontserratStyles.montserratRegularTextStyle(
                                    color: AppColor().silverShadeGrayColor,
                                    size: 15,
                                  ),
                              onChanged: (value) => _validatePasswords(),
                              fillColor: AppColor().darkCharcoalBlueColor,
                              textStyle:
                                  MontserratStyles.montserratRegularTextStyle(
                                    size: 15,
                                    color: AppColor().darkYellowColor,
                                  ),
                              focusedBorderColor: AppColor().darkYellowColor,
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
                              controller: _newPasswordController,
                              prefixIcon: Icon(Icons.lock, color: Colors.grey),

                              hintText: AppLocalizations.of(
                                context,
                              )!.newPassword,
                              borderRadius: 30,

                              borderColor: AppColor().silverShadeGrayColor,
                              borderWidth: 2,
                            ),
                            if (_passwordError != null)
                              Padding(
                                padding: EdgeInsets.only(top: 8, left: 16),
                                child: Text(
                                  _passwordError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        vGap(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(   textStyle:
                            MontserratStyles.montserratRegularTextStyle(
                              size: 15,
                              color: AppColor().darkYellowColor,
                            ), focusedBorderColor: AppColor().darkYellowColor,
                              hintStyle:
                              MontserratStyles.montserratRegularTextStyle(
                                color: AppColor().silverShadeGrayColor,
                                size: 15,
                              ),
                              onChanged: (value) => _validatePasswords(),
                              obscureText: obscureRePassword,
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
                              validator: InputValidators.validatePassword,
                              controller: _confirmNewPasswordController,
                              prefixIcon: Icon(Icons.lock, color: Colors.grey),

                              hintText: AppLocalizations.of(
                                context,
                              )!.confirmPassword,
                              borderRadius: 30,
                              fillColor: AppColor().darkCharcoalBlueColor,
                              borderColor: AppColor().silverShadeGrayColor,
                              borderWidth: 2,
                            ),
                            if (_confirmPasswordError != null)
                              Padding(
                                padding: EdgeInsets.only(top: 8, left: 16),
                                child: Text(
                                  _confirmPasswordError!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        vGap(25),
                        CustomButton(
                          height: 45,
                          width: screenSize.width * 0.95,
                          borderRadius: 48,
                          backgroundColor: AppColor().yellowWarmColor,
                          onPressed: state is ResetPasswordScreenLoading
                              ? null
                              : _createPassword,
                          text: state is ResetPasswordScreenLoading
                              ? AppLocalizations.of(context)!.loading
                              : AppLocalizations.of(context)!.create,
                          textStyle: MontserratStyles.montserratMediumTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
