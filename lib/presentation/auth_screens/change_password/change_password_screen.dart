part of "change_password_screen_route_imple.dart";

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordScreenBloc(
        repository: AuthenticationApiCall(),
      ),
      child: ChangePasswordScreenView(),
    );
  }
}

class ChangePasswordScreenView extends StatefulWidget {
  const ChangePasswordScreenView({super.key});

  @override
  State<ChangePasswordScreenView> createState() => _ChangePasswordScreenViewState();
}

class _ChangePasswordScreenViewState extends State<ChangePasswordScreenView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        _newPasswordError = 'New password must be different from current password';
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
    if (_oldPasswordError == null && _newPasswordError == null && _confirmPasswordError == null) {
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
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor().backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColor().darkCharcoalBlueColor,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Change Password',
          style: MontserratStyles.montserratMediumTextStyle(
            size: 18,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<ChangePasswordScreenBloc, ChangePasswordScreenState>(
          listener: (context, state) {
            if (state is ChangePasswordScreenLoading) {
              CustomLoader.showPopupLoader(context);
            } else {
              CustomLoader.hidePopupLoader(context);
              if (state is ChangePasswordScreenSuccess) {
                CherryToast.success(context, "Password changed successfully!");
                context.pop();
              } else if (state is ChangePasswordScreenFailure) {
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
                        Image.asset(lockLayer1Icon, height: 80, width: 80),
                        Text(
                          'Change',
                          style: MontserratStyles.montserratBoldTextStyle(
                            size: 48,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                        Text(
                          'New Password',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF4A5568),
                            height: 1.1,
                          ),
                        ),
                        Text(
                          'Update your current password to keep your account secure.',
                          textAlign: TextAlign.center,
                          style: MontserratStyles.montserratNormalTextStyle(
                            color: AppColor().silverShadeGrayColor,
                            size: 16,
                          ),
                        ),
                        vGap(20),
                      ],
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
                    child: SingleChildScrollView(
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
                                controller: _oldPasswordController,
                                focusedBorderColor: AppColor().darkYellowColor,
                                borderWidth: 2,
                                fillColor: AppColor().darkCharcoalBlueColor,
                                borderRadius: 30,
                                hintText: "Current Password",
                                onChanged: (value) => _validatePasswords(),
                              ),
                              if (_oldPasswordError != null)
                                Padding(
                                  padding: EdgeInsets.only(top: 8, left: 16),
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
                                textStyle: MontserratStyles.montserratRegularTextStyle(
                                  size: 15,
                                  color: AppColor().darkYellowColor,
                                ),
                                controller: _newPasswordController,
                                focusedBorderColor: AppColor().darkYellowColor,
                                borderWidth: 2,
                                fillColor: AppColor().darkCharcoalBlueColor,
                                borderRadius: 30,
                                hintText: "New Password",
                                onChanged: (value) => _validatePasswords(),
                              ),
                              if (_newPasswordError != null)
                                Padding(
                                  padding: EdgeInsets.only(top: 8, left: 16),
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
                                textStyle: MontserratStyles.montserratRegularTextStyle(
                                  size: 15,
                                  color: AppColor().darkYellowColor,
                                ),
                                controller: _confirmNewPasswordController,
                                focusedBorderColor: AppColor().darkYellowColor,
                                borderWidth: 2,
                                fillColor: AppColor().darkCharcoalBlueColor,
                                borderRadius: 30,
                                hintText: "Confirm New Password",
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
                            onPressed: state is ChangePasswordScreenLoading ? null : _changePassword,
                            text: state is ChangePasswordScreenLoading ? "Loading..." : "Change Password",
                            textStyle: MontserratStyles.montserratMediumTextStyle(
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
            );
          },
        ),
      ),
    );
  }
}
