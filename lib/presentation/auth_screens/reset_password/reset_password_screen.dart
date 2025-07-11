part of 'reset_password_screen_route_imple.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResetPasswordView();
  }
}

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
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
      print('Verification code: $code');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the complete code')),
      );
    }
  }

  void _resendCode() {
    print('Resending code...');
    for (var controller in controllers) {
      controller.clear();
    }
    focusNodes[0].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  vGap(50),
                  Image.asset(lockLayer1Icon,height: 80,width: 80,),
                  Text(
                    'Reset',
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 48,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),

                  Text(
                    'Password',
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
                        TextSpan(text: 'We have sent code to your email\n',style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().silverShadeGrayColor,
                          size: 16,
                        ),),
                        TextSpan(text: 'devesh***29gmail.com',style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().silverShadeGrayColor,
                          size: 16,
                        ),),
                      ],
                    ),
                  ),
                  vGap(20),
                ],
              ),
            ),

            Container(
              height: screenSize.height*0.48,
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
                  CustomPasswordField(
                    borderWidth: 2,
                    fillColor: AppColor().darkCharcoalBlueColor,
                    borderRadius: 30,
                    hintText: "New Password",
                  ),
                  CustomPasswordField(
                    borderWidth: 2,
                    fillColor: AppColor().darkCharcoalBlueColor,
                    borderRadius: 30,
                    hintText: "Confirm New Password",
                  ),
                  vGap(1),
                  CustomButton(
                    height: screenSize.height*0.06,
                    width: screenSize.width*0.95,
                    borderRadius: 48,
                    backgroundColor: AppColor().yellowWarmColor,
                    onPressed: (){},
                    text: "Create",
                    textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 20),
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Don't receive code ? ",
                  //       style: TextStyle(
                  //         color: Color(0xFF9CA3AF),
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: _resendCode,
                  //       child: Text(
                  //         'Resend',
                  //         style: TextStyle(
                  //           color: Color(0xFFECC94B),
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  //
                  // SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
