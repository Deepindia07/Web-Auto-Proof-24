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
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      bottomSheet: _buildBottomSheet(context),
      body: BlocConsumer<ForgotScreenBloc, ForgotScreenState>(
        listener: (context, state) {
          if (state is! ForgotScreenLoading) {
            CustomLoader.hidePopupLoader(context);
          }

          if (state is ForgotScreenSuccess) {
            CherryToast.success(context, state.message);
            context.push(AppRoute.otpScreen, extra: state.email);
          } else if (state is ForgotScreenError) {
            CherryToast.error(context, state.error);
          }
        },
        builder: (context, state) {
          return Align(alignment: Alignment.center,
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: _buildBody(context)),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(lockLayer1Icon, height: 72, width: 72),
              const SizedBox(height: 14),
              Text(
                AppLocalizations.of(context)!.forgot,
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 43,
                  color: AppColor().darkCharcoalBlueColor,
                ),
                textAlign: TextAlign.center,
              ),
              // const SizedBox(height: ),
              Text(
                "${AppLocalizations.of(context)!.password}?",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 43, // Reduced from 48
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 9), // Reduced from 10
              Text(
                AppLocalizations.of(context)!.resetInstructionsMessage,
                style: MontserratStyles.montserratNormalTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 16, // Reduced from 18
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 270),
            ],
          ),
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
          height:
              MediaQuery.of(context).size.height * 0.405,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 27,
            vertical: 36,
          ),
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
        const SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    CustomLoader.showPopupLoader(context);
    context.read<ForgotScreenBloc>().add(SendOtpEvent(email));
  }
}
