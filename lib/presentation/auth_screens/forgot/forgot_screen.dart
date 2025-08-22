part of 'forgot_screen_route_imple.dart';

class ForgotScreen extends StatelessWidget {
  final String emailOrPhone;
  const ForgotScreen({required this.emailOrPhone, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ForgotScreenBloc>(
      create: (context) =>
          ForgotScreenBloc(apiRepository: AuthenticationApiCall()),
      child: ForgotScreenView(emailOrPhone: emailOrPhone),
    );
  }
}

class ForgotScreenView extends StatefulWidget {
  final String emailOrPhone;
  const ForgotScreenView({required this.emailOrPhone, super.key});

  @override
  State<ForgotScreenView> createState() => _ForgotScreenViewState();
}

class _ForgotScreenViewState extends State<ForgotScreenView> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.emailOrPhone.isNotEmpty) {
      _emailOrPhoneController.text = widget.emailOrPhone;
    }
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,

      body: BlocConsumer<ForgotScreenBloc, ForgotScreenState>(
        listener: (context, state) {
          if (state is! ForgotScreenLoading) {
            CustomLoader.hidePopupLoader(context);
          }

          if (state is ForgotScreenSuccess) {
          /*  CherryToast.success(
              context,
              AppLocalizations.of(context)!.forgotPasswordMsg,*/
           /* );*/
            log("email----${state.email}");
            context.push(
              AppRoute.otpScreen,
              extra: {
                'email': state.email,
                'isEmailFromSignUp': true,
                'otpType': '2',
              },
            );
          } else if (state is ForgotScreenError) {
            // add localization text --------------
            CherryToast.error(context, state.error);
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(child: _buildBody(context, screenWidth)),
                if (Responsive.isDesktop(context))
                  Expanded(flex: 1, child: CommonViewAuth()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, double screenWidth) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Image.asset(
                    lockLayer1Icon,
                    height: 80,
                    width: 62,
                    fit: BoxFit.cover,
                  ),
                  vGap(10),
                  Text(
                    AppLocalizations.of(context)!.forgot,
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 30,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // const SizedBox(height: ),
                  Text(
                    "${AppLocalizations.of(context)!.password}?",
                    style: MontserratStyles.montserratMediumTextStyle(
                      color: AppColor().darkCharcoalBlueColor,
                      size: 28, // Reduced from 48
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 9),
                  Text(
                    AppLocalizations.of(context)!.resetInstructionsMessage,
                    style: MontserratStyles.montserratNormalTextStyle(
                      color: AppColor().darkCharcoalBlueColor,
                      size: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  vGap(20),
                ],
              ),
            ),
            _buildBottomSheet(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.405,
          width: 600,
          padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 36),
          decoration: BoxDecoration(
            color: AppColor().darkCharcoalBlueColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
          ),
          child: _buildFormContent(context),
        );
      },
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 18), // Reduced from 20
          SizedBox(
            width: double.infinity,
            child: CustomTextField(
              textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                size: 14, // Reduced from 16
                color: AppColor().darkYellowColor,
              ),
              controller: _emailOrPhoneController,
              borderRadius: 43, // Reduced from 48
              prefixIcon: Icon(
                Icons.mail_outline,
                size: 18, // Reduced from 20
                color: AppColor().darkYellowColor,
              ),
              hintText: AppLocalizations.of(context)!.enterEmailOrPhone,
              borderWidth: 2,
              hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
                size: 14, // Reduced from 16
                color: AppColor().darkYellowColor,
              ),
              borderColor: AppColor().darkYellowColor,
              fillColor: AppColor().darkCharcoalBlueColor,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.pleaseEnterEmailOrPhone;
                }
                return null;
              },
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<ForgotScreenBloc>().add(
                    ValidateEmailEvent(value),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 27), // Reduced from 30
          BlocBuilder<ForgotScreenBloc, ForgotScreenState>(
            builder: (context, state) {
              return SizedBox(
                height: 45, // Reduced from 50
                width: double.infinity,
                child: CustomButton(
                  height: 45, // Reduced from 50
                  width: double.infinity,
                  borderRadius: 43, // Reduced from 48
                  onPressed: state is ForgotScreenLoading
                      ? null
                      : _handleResetPassword,
                  backgroundColor: state is ForgotScreenLoading
                      ? AppColor().darkYellowColor.withOpacity(0.6)
                      : AppColor().darkYellowColor,
                  text: state is ForgotScreenLoading
                      ? AppLocalizations.of(context)!.resetPassword
                      : AppLocalizations.of(context)!.resetPassword,
                  textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14, // Reduced from 16
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 36), // Reduced from 40
          GestureDetector(
            onTap: () => context.pop(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.backToLogin,
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 14, // Reduced from 16
                    color: AppColor().darkYellowColor,
                  ),
                ),
                const SizedBox(height: 14), // Reduced from 15
                Image.asset(
                  arrowbackRoundIcon,
                  height: 32, // Reduced from 35
                  width: 32, // Reduced from 35
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleResetPassword() {
    // Validate form first
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final email = _emailOrPhoneController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.emailValidationMsg),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    CustomLoader.showPopupLoader(context);
    context.read<ForgotScreenBloc>().add(SendOtpEvent(email));
  }
}
