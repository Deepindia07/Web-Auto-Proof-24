part of 'otp_screen_route_imple.dart';

/*
class OtpScreen extends StatelessWidget {
  final String? email;
  final bool isEmailFromSignUp;
  const OtpScreen({required this.email, required this.isEmailFromSignUp, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpViewBloc>(
      create: (context) => OtpViewBloc(apiService: AuthenticationApiCall()),
      child: OtpScreenView(email: email!, isEmailFromSignUp: isEmailFromSignUp),
    );
  }
}

class OtpScreenView extends StatefulWidget {
  final String? email;
  final bool isEmailFromSignUp;
  const OtpScreenView({required this.email, required this.isEmailFromSignUp, super.key});

  @override
  State<OtpScreenView> createState() => _OtpScreenViewState();
}

class _OtpScreenViewState extends State<OtpScreenView> {
  List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 3) {
        focusNodes[index + 1].requestFocus();
      }
    } else if (value.isEmpty) {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  void _verifyCode() {
    String code = controllers.map((controller) => controller.text).join();
    if (code.length == 4) {
      context.read<OtpViewBloc>().add(VerifyOtpEvent(
        otp: code,
        email: widget.email!,
      ));
    } else {
      CherryToast.warning(context, AppLocalizations.of(context)!.pleaseEnterCompleteCode);
    }
  }

  void _resendCode() {
    // Clear all input fields
    for (var controller in controllers) {
      controller.clear();
    }
    focusNodes[0].requestFocus();
    context.read<OtpViewBloc>().add(ResendOtpEvent(email: widget.email!));
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocListener<OtpViewBloc, OtpViewState>(
          listener: (context, state) {
            if (state is OtpViewLoading) {
              CustomLoader.showPopupLoader(context);
            } else {
              CustomLoader.hidePopupLoader(context);
              if (state is OtpViewSuccess) {
                if (widget.isEmailFromSignUp != false) {
                  context.pop();
                } else {
                  context.push(AppRoute.resetPasswordScreen, extra: widget.email);
                }
                CherryToast.success(context, AppLocalizations.of(context)!.otpVerified);
              } else if (state is OtpViewFailure) {
                CherryToast.error(context, state.error);
              } else if (state is OtpResendSuccess) {
                CherryToast.success(context, state.message);
              } else if (state is OtpResendFailure) {
                CherryToast.error(context, state.error);
              }
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Top content - flexible space
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: keyboardHeight > 0 ? 20 : 54),
                                Image.asset(mailIcon, height: keyboardHeight > 0 ? 60 : 72, width: keyboardHeight > 0 ? 60 : 72),
                                Text(
                                  AppLocalizations.of(context)!.email,
                                  style: MontserratStyles.montserratLitleBoldTextStyle(
                                    size: keyboardHeight > 0 ? 32 : 43,
                                    color: AppColor().darkCharcoalBlueColor,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.verification,
                                  style: MontserratStyles.montserratSemiBoldTextStyle(
                                      size: keyboardHeight > 0 ? 32 : 43,
                                      color: AppColor().darkCharcoalBlueColor
                                  ),
                                ),
                                vGap(keyboardHeight > 0 ? 5 : 9),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: keyboardHeight > 0 ? 12 : 14,
                                      color: Color(0xFF9CA3AF),
                                      height: 1.4,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${AppLocalizations.of(context)!.emailSentMessage}\n',
                                        style: MontserratStyles.montserratRegularTextStyle(
                                          color: AppColor().silverShadeGrayColor,
                                          size: keyboardHeight > 0 ? 11 : 13,
                                        ),
                                      ),
                                      TextSpan(
                                        text: maskEmail(widget.email!),
                                        style: MontserratStyles.montserratNormalTextStyle(
                                          color: AppColor().darkCharcoalBlueColor,
                                          size: keyboardHeight > 0 ? 11 : 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                vGap(keyboardHeight > 0 ? 10 : 18),
                              ],
                            ),
                          ),
                        ),
                        // Bottom container - fixed size but responsive
                        Container(
                          height: keyboardHeight > 0 ? 280 : 360,
                          padding: EdgeInsets.all(keyboardHeight > 0 ? 20 : 29),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(4, (index) {
                                  return Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: TextField(
                                      controller: controllers[index],
                                      focusNode: focusNodes[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(1),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "*",
                                        hintStyle: TextStyle(
                                          color: Color(0xFF9CA3AF),
                                          fontSize: 18,
                                        ),
                                      ),
                                      onChanged: (value) => _onCodeChanged(value, index),
                                    ),
                                  );
                                }),
                              ),
                              vGap(keyboardHeight > 0 ? 20 : 29),
                              BlocBuilder<OtpViewBloc, OtpViewState>(
                                builder: (context, state) {
                                  return CustomButton(
                                    height: screenSize.height * 0.054,
                                    width: screenSize.width * 0.855,
                                    borderRadius: 43,
                                    backgroundColor: AppColor().yellowWarmColor,
                                    onPressed: state is OtpViewLoading ? null : _verifyCode,
                                    text: state is OtpViewLoading ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.verify,
                                    textStyle: MontserratStyles.montserratMediumTextStyle(
                                      color: AppColor().darkCharcoalBlueColor,
                                      size: 18,
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
                                        color: AppColor().silverShadeGrayColor
                                    ),
                                  ),
                                  hGap(5),
                                  BlocBuilder<OtpViewBloc, OtpViewState>(
                                    builder: (context, state) {
                                      return GestureDetector(
                                        onTap: state is OtpViewLoading ? null : _resendCode,
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}*/

class OtpScreen extends StatelessWidget {
  final String? email;
  final bool isEmailFromSignUp;
  const OtpScreen({
    required this.email,
    required this.isEmailFromSignUp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
      return BlocProvider<OtpViewBloc>(
      create: (context) => OtpViewBloc(apiService: AuthenticationApiCall()),
      child: OtpScreenView(email: email!, isEmailFromSignUp: isEmailFromSignUp),
    );
  }
}

class OtpScreenView extends StatefulWidget {
  final String? email;
  final bool isEmailFromSignUp;
  const OtpScreenView({
    required this.email,
    required this.isEmailFromSignUp,
    super.key,
  });

  @override
  State<OtpScreenView> createState() => _OtpScreenViewState();
}

class _OtpScreenViewState extends State<OtpScreenView>
    with TickerProviderStateMixin {
  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  bool _isLoading = false;
  bool _isResending = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;



  @override
  void initState() {
    super.initState();
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
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onCodeChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 3) {
        focusNodes[index + 1].requestFocus();
      } else {
        // Auto-verify when all 4 digits are entered
        _verifyCode();
      }
    } else if (value.isEmpty) {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  void _verifyCode() {
    String code = controllers.map((controller) => controller.text).join();
    if (code.length == 4) {
      context.read<OtpViewBloc>().add(VerifyOtpEvent(
        otp: code,
        email: widget.email!,
      ));
    } else {
      CherryToast.warning(context, AppLocalizations.of(context)!.pleaseEnterCompleteCode);
    }
  }


  void _resendCode() {
    // Clear all input fields
    for (var controller in controllers) {
      controller.clear();
    }
    focusNodes[0].requestFocus();
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
      backgroundColor:  AppColor().backgroundColor,
      body: BlocListener<OtpViewBloc, OtpViewState>(
        listener: (context, state) {
          if (state is OtpViewLoading) {
            CustomLoader.showPopupLoader(context);
          } else {
            CustomLoader.hidePopupLoader(context);
            if (state is OtpViewSuccess) {
              if (widget.isEmailFromSignUp != false) {
                context.pop();
              } else {
                context.push(AppRoute.resetPasswordScreen, extra: widget.email);
              }
              CherryToast.success(context, AppLocalizations.of(context)!.otpVerified);
            } else if (state is OtpViewFailure) {
              CherryToast.error(context, state.error);
            } else if (state is OtpResendSuccess) {
              CherryToast.success(context, state.message);
            } else if (state is OtpResendFailure) {
              CherryToast.error(context, state.error);
            }
          }
        },
  child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive design
          bool isLargeDesktop = constraints.maxWidth > 1400;
          bool isDesktop = constraints.maxWidth > 1000;
          bool isTablet = constraints.maxWidth > 600;

        return  _buildDesktopLayout(isLargeDesktop,screenSize,keyboardHeight);
         
        },
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

  Widget _buildDesktopLayout(bool isLargeDesktop,Size screenSize,double keyboardHeight, ) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 600),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ AppColor().backgroundColor, Colors.white],
            ),
          ),
          child: Column(
            children: [
              // Header section
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(mailIcon, height: 72, width: 72),
                      SizedBox(height: 32),
                      Text(
                        AppLocalizations.of(context)!.email,
                        style: MontserratStyles.montserratLitleBoldTextStyle(
                          size: 35,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),

                      Text(
                        AppLocalizations.of(context)!.verification,
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 43,
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
                              style: MontserratStyles.montserratNormalTextStyle(
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
              // OTP Input section
              Container(

                padding: EdgeInsets.all(20 ),
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
                      separatorBuilder: (index) => SizedBox(width:10),
                      validator: (value) =>
                      value == '2222' ? null : 'Pin is incorrect',
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) => debugPrint('onCompleted: $pin'),
                      onChanged: (value) => debugPrint('onChanged: $value'),
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: keyboardHeight * 0.012),
                            width: keyboardHeight * 0.06,
                            height: 1,
                            color: AppColor().silverShadeGrayColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor().silverShadeGrayColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: const Color.fromRGBO(243, 246, 249, 0),
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(color: AppColor().silverShadeGrayColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                    vGap(keyboardHeight > 0 ? 20 : 29),
                    BlocBuilder<OtpViewBloc, OtpViewState>(
                      builder: (context, state) {
                        return CustomButton(
                          height: screenSize.height * 0.054,
                          width: screenSize.width * 0.58,
                          borderRadius: 43,
                          backgroundColor: AppColor().yellowWarmColor,
                          onPressed: state is OtpViewLoading ? null : _verifyCode,
                          text: state is OtpViewLoading ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.verify,
                          textStyle: MontserratStyles.montserratMediumTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                            size: 18,
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
                              color: AppColor().silverShadeGrayColor
                          ),
                        ),
                        hGap(5),
                        BlocBuilder<OtpViewBloc, OtpViewState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: state is OtpViewLoading ? null : _resendCode,
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
                    if (keyboardHeight == 0) SizedBox(height: 14), vGap(keyboardHeight > 0 ? 20 : 30),
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
