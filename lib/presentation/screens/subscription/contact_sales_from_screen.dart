part of 'subscription_screen_route_imple.dart';

/*
class ContactSalesFromScreen extends StatefulWidget {
  const ContactSalesFromScreen({super.key});

  @override
  State<ContactSalesFromScreen> createState() => _ContactSalesFromScreenState();
}

class _ContactSalesFromScreenState extends State<ContactSalesFromScreen> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final headerHeight = 230.0 + statusBarHeight;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: AppColor().backgroundColor, // White center background
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                vGap(headerHeight),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      spacing: 15,
                      children: [
                        Text(
                          "Contact Sales Form",
                          style: MontserratStyles.montserratSemiBoldTextStyle(
                            size: 30,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                        Row(
                          spacing: 3,
                          children: [
                            Expanded(
                              child: CustomTextField(labelText: "First Name"),
                            ),
                            Expanded(
                              child: CustomTextField(labelText: "First Name"),
                            ),
                          ],
                        ),
                        CustomTextField(
                          labelText: "First Name",
                          hintText: "First Name",
                          hintStyle:
                              MontserratStyles.montserratRegularTextStyle(
                                size: 14,
                                color: AppColor().silverShadeGrayColor,
                              ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                        ),
                        CustomTextField(labelText: "First Name"),
                        CustomTextField(
labelStyle: "efef",
                          fillColor: AppColor().backgroundColor,
                          borderWidth: 2,
                          borderRadius: 30,
                          hintStyle: MontserratStyles.montserratRegularTextStyle(
                            size:  14,
                            color: AppColor().silverShadeGrayColor,
                          ),
                          hintText: "Enter Registration Number",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.pleaseEnterEmailOrPhoneShort;
                            }
                            return null;
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.haveAccount,
                              style: MontserratStyles.montserratMediumTextStyle(
                                size: 14,
                                color: AppColor().silverShadeGrayColor,
                              ),
                            ),
                            hGap(10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.signIn,
                                style:
                                    MontserratStyles.montserratMediumTextStyle(
                                      size: 14,
                                      color: AppColor().darkCharcoalBlueColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        vGap(30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/

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
                      const Text(
                        'Contact Sales Form',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2D4A),
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
                                style: MontserratStyles.montserratRegularTextStyle(
                                  size: 15,
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
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.amber),
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
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2D4A),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            hintText: hint ?? label,
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
