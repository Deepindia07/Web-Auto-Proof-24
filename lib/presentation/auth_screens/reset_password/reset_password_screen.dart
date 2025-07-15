part of 'reset_password_screen_route_imple.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String? email;
  const ResetPasswordScreen({required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordScreenBloc(
        repository: AuthenticationApiCall(),
      ),
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
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        _confirmPasswordError = AppLocalizations.of(context)!.pleaseConfirmPassword;
        return;
      }

      // Check if passwords match
      if (_newPasswordController.text != _confirmNewPasswordController.text) {
        _confirmPasswordError = AppLocalizations.of(context)!.passwordsDoNotMatch;
        return;
      }
    });
  }

  void _createPassword() {
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
      backgroundColor: AppColor().backgroundColor,
      body: SafeArea(
        child: BlocConsumer<ResetPasswordScreenBloc, ResetPasswordScreenState>(
          listener: (context, state) {
            if (state is ResetPasswordScreenLoading) {
              CustomLoader.showPopupLoader(context);
            } else {
              CustomLoader.hidePopupLoader(context);

              if (state is ResetPasswordScreenSuccess) {
                CherryToast.success(context, AppLocalizations.of(context)!.passwordResetSuccess );
                context.pushNamed('login');
              } else if (state is ResetPasswordScreenFailure) {
                CherryToast.error(context, state.error);
              }
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        vGap(50),
                        Image.asset(lockLayer1Icon, height: 80, width: 80),
                        Text(
                         AppLocalizations.of(context)!.reset,
                          style: MontserratStyles.montserratBoldTextStyle(
                            size: 48,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.password,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF4A5568),
                            height: 1.1,
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
                                text: '${AppLocalizations.of(context)!.emailSentMessage}\n',
                                style: MontserratStyles.montserratNormalTextStyle(
                                  color: AppColor().silverShadeGrayColor,
                                  size: 16,
                                ),
                              ),
                              TextSpan(
                                text: '${widget.email}',
                                style: MontserratStyles.montserratNormalTextStyle(
                                  color: AppColor().silverShadeGrayColor,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        vGap(20),
                      ],
                    ),
                  ),
                  Container(
                    height: screenSize.height * 0.48,
                    padding: EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColor().darkCharcoalBlueColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      ),
                    ),
                    child: Column(
                      spacing: 20,
                      children: [
                        vGap(30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomPasswordField(
                              textStyle: MontserratStyles.montserratRegularTextStyle(
                                size: 15,
                                color: AppColor().darkYellowColor,
                              ),
                              controller: _newPasswordController,
                              focusedBorderColor: AppColor().darkYellowColor,
                              borderWidth: 2,
                              fillColor: AppColor().darkCharcoalBlueColor,
                              borderRadius: 30,
                              hintText: AppLocalizations.of(context)!.newPassword,
                              onChanged: (value) => _validatePasswords(),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomPasswordField(
                              textStyle: MontserratStyles.montserratRegularTextStyle(
                                size: 15,
                                color: AppColor().darkYellowColor,
                              ),
                              controller: _confirmNewPasswordController,
                              focusedBorderColor: AppColor().darkYellowColor,
                              borderWidth: 2,
                              fillColor: AppColor().darkCharcoalBlueColor,
                              borderRadius: 30,
                              hintText: AppLocalizations.of(context)!.confirmPassword,
                              onChanged: (value) => _validatePasswords(),
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
                        vGap(1),
                        CustomButton(
                          height: screenSize.height * 0.06,
                          width: screenSize.width * 0.95,
                          borderRadius: 48,
                          backgroundColor: AppColor().yellowWarmColor,
                          onPressed: state is ResetPasswordScreenLoading ? null : _createPassword,
                          text: state is ResetPasswordScreenLoading ? AppLocalizations.of(context)!.loading: AppLocalizations.of(context)!.create,
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
            );
          },
        ),
      ),
    );
  }
}