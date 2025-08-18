// Make sure this import exists
part of "contact_us_screen_route_imple.dart";



class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(20),

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Center(
                  child: Text(
                    "Contact Us",
                    style: MontserratStyles.montserratSemiBoldTextStyle(
                      size: 30,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                 Center(
                  child: Text(
                    "We're happy to assist! If you need help with our\nmobile app or have any race-related questions, don't\nhesitate to reach out.",
                    textAlign: TextAlign.center,
                    style: MontserratStyles.montserratSemiBoldTextStyle(
                      size: 16,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                 Text(
                  "Write us",
                  style: MontserratStyles.montserratBoldTextStyle(
                    size: 24,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInput("Subject", "Enter Subject"),
                const SizedBox(height: 20),
                _buildInput("Message", "Enter Message", maxLines: 8),
                const SizedBox(height: 30),
               CustomButtonWeb(
                   width: double.infinity,
                   text: "Submit",
                   onPressed: (){}, color: AppColor().darkCharcoalBlueColor,
                   textColor: AppColor().yellowWarmColor, borderRadius: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, String hintText, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 15,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(isDense: true,
            hintText: hintText,
            helperStyle: MontserratStyles.montserratRegularTextStyle(
              size: 15,
              color: AppColor().silverShadeGrayColor,
            ),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF1F2D4A)),
              borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF1F2D4A), width: 2),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }
}
