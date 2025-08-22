part of "change_password_screen_route_imple.dart";

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChangePasswordScreenBloc(repository: AuthenticationApiCall()),
      child: ChangePasswordScreenView(),
    );
  }
}

class ChangePasswordScreenView extends StatefulWidget {
  const ChangePasswordScreenView({super.key});

  @override
  State<ChangePasswordScreenView> createState() =>
      _ChangePasswordScreenViewState();
}

class _ChangePasswordScreenViewState extends State<ChangePasswordScreenView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool obscureRePassword = false;
  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswords() {
    setState(() {
      _oldPasswordError = null;
      _newPasswordError = null;
      _confirmPasswordError = null;

      // Check if old password is empty
      if (_oldPasswordController.text.isEmpty) {
        _oldPasswordError = 'Current password is required';
        return;
      }

      // Check if new password is empty
      if (_newPasswordController.text.isEmpty) {
        _newPasswordError = 'New password is required';
        return;
      }

      // Check minimum password length for new password
      if (_newPasswordController.text.length < 8) {
        _newPasswordError = 'New password must be at least 8 characters';
        return;
      }

      // Check if new password is same as old password
      if (_oldPasswordController.text == _newPasswordController.text) {
        _newPasswordError =
            'New password must be different from current password';
        return;
      }

      // Check if confirm password is empty
      if (_confirmNewPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Please confirm your new password';
        return;
      }

      // Check if passwords match
      if (_newPasswordController.text != _confirmNewPasswordController.text) {
        _confirmPasswordError = 'Passwords do not match';
        return;
      }
    });
  }

  void _changePassword() {
    _validatePasswords();

    // Only proceed if validation passes
    if (_oldPasswordError == null &&
        _newPasswordError == null &&
        _confirmPasswordError == null) {
      context.read<ChangePasswordScreenBloc>().add(
        ChangePasswordSubmitted(
          oldPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,

      body: SafeArea(
        child: BlocConsumer<ChangePasswordScreenBloc, ChangePasswordScreenState>(
          listener: (context, state) {
            if (state is ChangePasswordScreenLoading) {
              CustomLoader.showPopupLoader(context);
            } else {
              CustomLoader.hidePopupLoader(context);
              if (state is ChangePasswordScreenSuccess) {
                _oldPasswordController.clear();
                _newPasswordController.clear();
                _confirmNewPasswordController.clear();
                print("dsdssffsfsPassword changed successfully!");
                CherryToast.success(
                  context,
                  AppLocalizations.of(context)!.passwordResetSuccess,
                );
                context.pop();
              } else if (state is ChangePasswordScreenFailure) {
                // add localization text --------------
                CherryToast.error(context, state.error);
              }
            }
          },
          builder: (context, state) {
            return Container(
              constraints: BoxConstraints(
                maxWidth: Responsive.isDesktop(context)
                    ? (screenWidth > 1366 ? 1366 : screenWidth) // double
                    : 600,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: _formKey,
                child: Align(
                  alignment: Alignment.center,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 42),
                              Image.asset(
                                lockLayer1Icon,
                                height: 72,
                                width: 62,
                                fit: BoxFit.fill,
                              ),
                              vGap(10),

                              Text(
                                AppLocalizations.of(context)!.changeText,
                                style: MontserratStyles.montserratBoldTextStyle(
                                  size: 30,
                                  color: AppColor().darkCharcoalBlueColor,
                                ),
                              ),
                              Text(
                                AppLocalizations.of(context)!.passwordText,
                                style:
                                    MontserratStyles.montserratMediumTextStyle(
                                      size: 28,
                                      color: AppColor().darkCharcoalBlueColor,
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                  right: 20,
                                ),
                                child: Text(
                                  '${AppLocalizations.of(context)!.emailSentMessageTittle}\ndevesh***29gmail.com',
                                  textAlign: TextAlign.center,
                                  style:
                                      MontserratStyles.montserratNormalTextStyle(
                                        color: AppColor().silverShadeGrayColor,
                                        size: 14,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        vGap(20),
                        Container(
                          height: screenSize.height * 0.40,
                          padding: EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: AppColor().darkCharcoalBlueColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(48),
                              topRight: Radius.circular(48),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              spacing: 20,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                      hintStyle:
                                          MontserratStyles.montserratRegularTextStyle(
                                            size: 15,
                                            color:
                                                AppColor().silverShadeGrayColor,
                                          ),
                                      textStyle:
                                          MontserratStyles.montserratRegularTextStyle(
                                            size: 15,
                                            color: AppColor().darkYellowColor,
                                          ),
                                      focusedBorderColor:
                                          AppColor().yellowWarmColor,
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
                                      validator:
                                          InputValidators.validatePassword,
                                      controller: _oldPasswordController,

                                      hintText: AppLocalizations.of(
                                        context,
                                      )!.oldPassword,

                                      borderRadius: 30,
                                      fillColor: Colors.transparent,
                                      borderColor:
                                          AppColor().silverShadeGrayColor,

                                      borderWidth: 2,
                                    ),

                                    if (_oldPasswordError != null)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          left: 16,
                                        ),
                                        child: Text(
                                          _oldPasswordError!,
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
                                      validator:
                                          InputValidators.validatePassword,
                                      hintStyle:
                                          MontserratStyles.montserratRegularTextStyle(
                                            size: 15,
                                            color:
                                                AppColor().silverShadeGrayColor,
                                          ),
                                      textStyle:
                                          MontserratStyles.montserratRegularTextStyle(
                                            size: 15,
                                            color: AppColor().darkYellowColor,
                                          ),

                                      obscuringCharacter: "*",
                                      controller: _newPasswordController,
                                      focusedBorderColor:
                                          AppColor().darkYellowColor,
                                      borderWidth: 2,
                                      fillColor:
                                          AppColor().darkCharcoalBlueColor,
                                      borderRadius: 30,
                                      hintText:  AppLocalizations.of(context)!.newPassword,
                                      // textCapitalization: TextCapitalization.none,
                                      onChanged: (value) =>
                                          _validatePasswords(),
                                    ),
                                    if (_newPasswordError != null)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          left: 16,
                                        ),
                                        child: Text(
                                          _newPasswordError!,
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
                                      validator: (value) =>
                                          InputValidators.validateConfirmPassword(
                                            value,
                                            _newPasswordController.text,
                                          ),
                                      hintStyle:
                                          MontserratStyles.montserratRegularTextStyle(
                                            size: 15,
                                            color:
                                                AppColor().silverShadeGrayColor,
                                          ),
                                      textStyle:
                                          MontserratStyles.montserratRegularTextStyle(
                                            size: 15,
                                            color: AppColor().darkYellowColor,
                                          ),
                                      obscuringCharacter: "*",

                                      controller: _confirmNewPasswordController,
                                      focusedBorderColor:
                                          AppColor().darkYellowColor,
                                      borderWidth: 2,
                                      fillColor:
                                          AppColor().darkCharcoalBlueColor,
                                      borderRadius: 30,
                                      hintText: AppLocalizations.of(
                                        context,
                                      )!.confirmPassword,
                                      // textCapitalization: TextCapitalization.none,
                                      onChanged: (value) =>
                                          _validatePasswords(),
                                    ),
                                    if (_confirmPasswordError != null)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 8,
                                          left: 16,
                                        ),
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
                                  height: 45,
                                  width: screenSize.width * 0.90,
                                  borderRadius: 48,
                                  backgroundColor: AppColor().yellowWarmColor,
                                  onPressed: _changePassword,
                                  text:  AppLocalizations.of(context)!.changePassword,
                                  textStyle:
                                      MontserratStyles.montserratMediumTextStyle(
                                        color: AppColor().darkCharcoalBlueColor,
                                        size: 18,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
