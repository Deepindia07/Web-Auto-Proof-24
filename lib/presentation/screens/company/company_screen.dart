part of 'company_screen_route_imple.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

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

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "My Company Information",
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 30,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Company Logo",
                            style: MontserratStyles.montserratSemiBoldTextStyle(
                              size: 15,
                              color: AppColor().darkCharcoalBlueColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: ResponsiveSizes(context).screenWidth,
                            height: 80,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(Icons.cloud_upload_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                _buildInput("Company Name", "Preet"),
                _buildInput("Website", "Preet@Gmail.Com"),
                _buildInput("VAT Number", "00-00-00"),
                _buildInput("Company Registration No.", "234789"),
                _buildInput("Share Capital", "5000€"),
                _buildInput("Term & Condition", "https://www."),
                _buildInput("Privacy Policy", "www.preet.com"),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonWeb(
                        text: "Save",
                        onPressed: () {},
                        color: AppColor().darkCharcoalBlueColor,
                        textColor: AppColor().yellowWarmColor,
                        borderRadius: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String label, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
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
            decoration: InputDecoration(isDense: true,
              hintText: hintText,
              hintStyle: MontserratStyles.montserratRegularTextStyle(
                size: 15,
                color: AppColor().silverShadeGrayColor,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF1F2D4A)),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF1F2D4A),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
