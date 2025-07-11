part of 'forgot_screen_route_imple.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ForgotScreenView();
  }
}

class ForgotScreenView extends StatefulWidget {
  const ForgotScreenView({super.key});

  @override
  State<ForgotScreenView> createState() => _ForgotScreenViewState();
}

class _ForgotScreenViewState extends State<ForgotScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: _buildBody(context),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0, left: 70, right: 60.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            lockLayer1Icon,
            height: 100,
            width: 100,
          ),
          Text(
            "Forgot",
            style: MontserratStyles.montserratBoldTextStyle(
              size: 40,
              color: AppColor().darkCharcoalBlueColor,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Password?",
            style: MontserratStyles.montserratRegularTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 50,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "No worries, we'll send you \n   reset instructions",
            style: MontserratStyles.montserratNormalTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return BottomSheet(
      backgroundColor: Colors.transparent,
      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.51,
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: AppColor().darkCharcoalBlueColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: _buildFormContent(context),
        );
      },
    );
  }

  Widget _buildFormContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextField(
            borderRadius: 48,
            prefixIcon: Icon(
              Icons.mail_outline,
              size: 20,
              color: AppColor().darkYellowColor,
            ),
            hintText: "Enter Your Email/Phone No.",
            borderWidth: 2,
            hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
              size: 16,
              color: AppColor().darkYellowColor,
            ),
            borderColor: AppColor().darkYellowColor,
            fillColor: AppColor().darkCharcoalBlueColor,
          ),
          const SizedBox(height: 20),
          CustomButton(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.8,
            borderRadius: 48,
            onPressed: _handleResetPassword,
            backgroundColor: AppColor().darkYellowColor,
            text: "Reset Password",
            textStyle: MontserratStyles.montserratSemiBoldTextStyle(
              size: 16,
              color: AppColor().darkCharcoalBlueColor,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "Back To Login",
            style: MontserratStyles.montserratMediumTextStyle(
              size: 16,
              color: AppColor().darkYellowColor,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => context.pop(),
            child: Image.asset(
              arrowbackRoundIcon,
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
    );
  }

  void _handleResetPassword() {
    // TODO: Implement reset password logic
    context.push(AppRoute.otpScreen);
  }
}