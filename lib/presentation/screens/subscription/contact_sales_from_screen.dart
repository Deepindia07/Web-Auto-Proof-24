part of 'subscription_screen_route_imple.dart';

class ContactSalesFromScreen extends StatelessWidget {
  const ContactSalesFromScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFF),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1000;
          final isTall = constraints.maxHeight >= 700;

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 100 : 30,
                vertical: isTall ? 60 : 30,
              ),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColor().backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Contact Sales Form',
                        textAlign: TextAlign.center,
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 30,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(child: _buildField("First Name")),
                          const SizedBox(width: 16),
                          Expanded(child: _buildField("Last Name")),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildField("Company Name"),
                      const SizedBox(height: 16),
                      _buildField("Email ID", hint: "Email ID"),
                      const SizedBox(height: 16),
                      _buildField("Phone Number", hint: "234-345-6789"),
                      const SizedBox(height: 16),
                      _buildField("Numerical Addition", hint: "345"),
                      const SizedBox(height: 16),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: true,
                            onChanged: (_) {},
                            side: const BorderSide(
                              color: Color(0xFF1F2D4A),
                              width: 1.5,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "I have read and agree to Auto proof 24 terms & condition privacy policy",
                                style:
                                    MontserratStyles.montserratRegularTextStyle(
                                      size: 14,
                                      color: AppColor().darkCharcoalBlueColor,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: const Color(0xFF1F2D4A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            "Submit",
                            style: MontserratStyles.montserratRegularTextStyle(
                              size: 14,
                              color: AppColor().yellowWarmColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildField(String label, {String? hint}) {
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
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            hintText: hint ?? label,
            hintStyle: MontserratStyles.montserratRegularTextStyle(
              size: 14,
              color: AppColor().silverShadeGrayColor,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 9,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFF1F2D4A)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFF1F2D4A)),
            ),
          ),
        ),
      ],
    );
  }
}
