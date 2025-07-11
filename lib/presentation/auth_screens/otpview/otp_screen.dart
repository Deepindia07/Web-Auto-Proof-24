part of 'otp_screen_route_imple.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OtpScreenView();
  }
}

class OtpScreenView extends StatefulWidget {
  const OtpScreenView({super.key});

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
                  SizedBox(height: 60),
                  Image.asset(mailIcon,height: 100,width: 100,),
                  Text(
                    'Email',
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 48,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),

                  Text(
                    'Verification',
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
                  CustomButton(
                    height: screenSize.height*0.06,
                    width: screenSize.width*0.95,
                    borderRadius: 48,
                    backgroundColor: AppColor().yellowWarmColor,
                    onPressed: (){
                      context.push(AppRoute.resetPasswordScreen);
                    },
                      text: "Verify",
                    textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 20),

                  ),

                  vGap(24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't receive code ? ",
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: _resendCode,
                        child: Text(
                          'Resend',
                          style: TextStyle(
                            color: Color(0xFFECC94B),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
    );
  }
}
