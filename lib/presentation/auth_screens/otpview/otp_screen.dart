part of 'otp_screen_route_imple.dart';

class OtpScreen extends StatelessWidget {
  final String? email;
  final bool isEmailFromSignUp;
  final String otpType;
  const OtpScreen({
    required this.email,
    required this.isEmailFromSignUp,
    super.key,
    required this.otpType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpViewBloc>(
      create: (context) => OtpViewBloc(apiService: AuthenticationApiCall()),
      child: OtpScreenView(
        email: email!,
        isEmailFromSignUp: isEmailFromSignUp,
        otpType: otpType,
      ),
    );
  }
}

class OtpScreenView extends StatefulWidget {
  final String? email;
  final bool isEmailFromSignUp;
  final String otpType;
  const OtpScreenView({
    required this.email,
    required this.isEmailFromSignUp,
    required this.otpType,
    super.key,
  });

  @override
  State<OtpScreenView> createState() => _OtpScreenViewState();
}

class _OtpScreenViewState extends State<OtpScreenView>
    with TickerProviderStateMixin {
  TextEditingController pinController = TextEditingController();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    log("email0----->${widget.email}");
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();

    pinController.dispose();

    super.dispose();
  }

  void _verifyCode() {
    if (pinController.text.length == 4) {
      context.read<OtpViewBloc>().add(
        VerifyOtpEvent(otp: pinController.text, email: widget.email!),
      );
    } else {
      CherryToast.warning(
        context,
        AppLocalizations.of(context)!.pleaseEnterCompleteCode,
      );
    }
  }

  void _resendCode() {
     pinController.clear();
    context.read<OtpViewBloc>().add(ResendOtpEvent(email: widget.email!));
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  String maskEmail(String email) {
    if (email.contains('@')) {
      final parts = email.split('@');
      final username = parts[0];
      final domain = parts[1];

      if (username.length <= 3) {
        return '${username[0]}***@$domain';
      } else {
        final visiblePart = username.substring(0, 3);
        return '$visiblePart***@$domain';
      }
    }
    return email;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<OtpViewBloc, OtpViewState>(
        listener: (context, state) {
          if (state is OtpViewLoading) {
            CustomLoader.showPopupLoader(context);
          } else {
            CustomLoader.hidePopupLoader(context);
            if (state is OtpViewSuccess) {
              log("hh----${widget.email}");
              String email = widget.email.toString();
              if (widget.otpType == "1") {
                context.push(AppRoute.signUpScreen, extra: email);
              } else {
                context.push(AppRoute.resetPasswordScreen, extra: email);
              }

              CherryToast.success(
                context,
                AppLocalizations.of(context)!.otpVerified,
              );
            } else if (state is OtpViewFailure) {
              // add localization text --------------
              CherryToast.error(context, state.error);
            } else if (state is OtpResendSuccess) {

              CherryToast.success(context,  AppLocalizations.of(context)!.otpVerified);
            } else if (state is OtpResendFailure) {
              // add localization text --------------
              CherryToast.error(context, state.error);
            }
          }
        },
        child: Responsive.isDesktop(context)
            ? Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: _buildDesktopLayout(screenSize, keyboardHeight),
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
                child: _buildDesktopLayout(screenSize, keyboardHeight),
              ),
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 40,
    height: 40,
    textStyle: TextStyle(fontSize: 20, color: Colors.white),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColor().silverShadeGrayColor),
    ),
  );

  Widget _buildDesktopLayout(Size screenSize, double keyboardHeight) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 600),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24)),
          child: Column(
            children: [
              // Header section
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 42),
                        Image.asset(
                          mailIcon,
                          height: 52,
                          width: 62,
                          fit: BoxFit.cover,
                        ),
                        vGap(10),
                        Text(
                          AppLocalizations.of(context)!.email,
                          style: MontserratStyles.montserratLitleBoldTextStyle(
                            size: 35,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),

                        Text(
                          AppLocalizations.of(context)!.verification,
                          style: MontserratStyles.montserratMediumTextStyle(
                            size: 28,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                        vGap(9),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF9CA3AF),
                              height: 1.4,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${AppLocalizations.of(context)!.emailSentMessage}\n',
                                style:
                                    MontserratStyles.montserratRegularTextStyle(
                                      color: AppColor().silverShadeGrayColor,
                                      size: 13,
                                    ),
                              ),
                              TextSpan(
                                text: maskEmail(widget.email!),
                                style:
                                    MontserratStyles.montserratNormalTextStyle(
                                      color: AppColor().darkCharcoalBlueColor,
                                      size: 13,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // OTP Input section
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColor().darkCharcoalBlueColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(43),
                    topRight: Radius.circular(43),
                  ),
                ),
                child: Column(
                  children: [
                    vGap(keyboardHeight > 0 ? 20 : 45),

                    Pinput(
                      controller: pinController,
                      preFilledWidget: Container(
                        padding: EdgeInsets.only(top: 5),
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                            '*',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => SizedBox(width: 10),
                      validator: (value) {
                        if (value == pinController.text) {
                          return null; // Correct
                        } else {
                          return  AppLocalizations.of(context)!.pinIncorrect;
                        }
                      },

                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) => debugPrint('onCompleted: $pin'),
                      onChanged: (value) => debugPrint('onChanged: $value'),

                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: keyboardHeight * 0.012,
                            ),
                            width: keyboardHeight * 0.06,
                            height: 1,
                            color: AppColor().silverShadeGrayColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppColor().silverShadeGrayColor,
                          ),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: const Color.fromRGBO(243, 246, 249, 0),
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(
                            color: AppColor().silverShadeGrayColor,
                          ),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),

                    vGap(keyboardHeight > 0 ? 20 : 29),
                    BlocBuilder<OtpViewBloc, OtpViewState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: CustomButton(
                            height: 45,
                            width: screenSize.width * 0.58,
                            borderRadius: 43,
                            backgroundColor: AppColor().yellowWarmColor,
                            onPressed: state is OtpViewLoading
                                ? null
                                : _verifyCode,
                            text: state is OtpViewLoading
                                ? AppLocalizations.of(context)!.verified
                                : AppLocalizations.of(context)!.verify,
                            textStyle:
                                MontserratStyles.montserratMediumTextStyle(
                                  color: AppColor().darkCharcoalBlueColor,
                                  size: 18,
                                ),
                          ),
                        );
                      },
                    ),
                    vGap(keyboardHeight > 0 ? 15 : 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontReceiveCode,
                          style: MontserratStyles.montserratSemiBoldTextStyle(
                            size: 13,
                            color: AppColor().silverShadeGrayColor,
                          ),
                        ),
                        hGap(5),
                        BlocBuilder<OtpViewBloc, OtpViewState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: state is OtpViewLoading
                                  ? null
                                  : _resendCode,
                              child: Text(
                                AppLocalizations.of(context)!.resend,
                                style: TextStyle(
                                  color: state is OtpViewLoading
                                      ? Color(0xFF9CA3AF)
                                      : Color(0xFFECC94B),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    if (keyboardHeight == 0) SizedBox(height: 14),
                    vGap(keyboardHeight > 0 ? 20 : 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
