part of 'otp_screen_route_imple.dart';

class OtpScreen extends StatelessWidget {
  final String? email;
  final bool isEmailFromSignUp;
  const OtpScreen({required this.email, required this.isEmailFromSignUp,super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OtpViewBloc>(
      create: (context) => OtpViewBloc(apiService: AuthenticationApiCall()),
      child: OtpScreenView(email: email!,isEmailFromSignUp: isEmailFromSignUp),
    );
  }
}

class OtpScreenView extends StatefulWidget {
  final String? email;
  final bool isEmailFromSignUp;
  const OtpScreenView({required this.email,required this.isEmailFromSignUp,  super.key});

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

  void _resendCode() {for (var controller in controllers) {
      controller.clear();
    }
    focusNodes[0].requestFocus();
    context.read<OtpViewBloc>().add(ResendOtpEvent());
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SafeArea(
        child: BlocListener<OtpViewBloc, OtpViewState>(
          listener: (context, state) {
            if (state is OtpViewLoading) {
              CustomLoader.showPopupLoader(context);
            } else {
              CustomLoader.hidePopupLoader(context);
              if (state is OtpViewSuccess) {
                if(widget.isEmailFromSignUp != false){
                  context.pop();
                }else{
                  context.push(AppRoute.resetPasswordScreen,extra: widget.email);
                }
                CherryToast.success(context, AppLocalizations.of(context)!.otpVerified);
              } else if (state is OtpViewFailure) {
                CherryToast.error(context, state.error);
              } else if (state is OtpResendSuccess) {
                CherryToast.success(context, AppLocalizations.of(context)!.otpVerified);
              } else if (state is OtpResendFailure) {
                CherryToast.error(context, state.error);
              }
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Image.asset(mailIcon, height: 100, width: 100),
                    Text(
                      AppLocalizations.of(context)!.email,
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 48,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.verification,
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
                            text: widget.email,
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
                height: 450,
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
                    vGap(70),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF718096),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
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
                              hintText: index == 0 ? '1' : '*',
                              hintStyle: TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 24,
                              ),
                            ),
                            onChanged: (value) => _onCodeChanged(value, index),
                          ),
                        );
                      }),
                    ),
                    vGap(32),
                    BlocBuilder<OtpViewBloc, OtpViewState>(
                      builder: (context, state) {
                        return CustomButton(
                          height: screenSize.height * 0.06,
                          width: screenSize.width * 0.95,
                          borderRadius: 48,
                          backgroundColor: AppColor().yellowWarmColor,
                          onPressed: state is OtpViewLoading ? null : _verifyCode,
                          text: state is OtpViewLoading ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.verify,
                          textStyle: MontserratStyles.montserratMediumTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                            size: 20,
                          ),
                        );
                      },
                    ),
                    vGap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.dontReceiveCode,
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 14,
                          ),
                        ),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
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
