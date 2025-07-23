part of "reports_screen_route_imple.dart";

class ReportsScreen extends StatelessWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const ReportsScreen({super.key, required this.isBacked, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportsScreenBloc>(
      create: (context) => ReportsScreenBloc(),
      child: ReportsScreenView(isBacked: isBacked, onBack: onBack),
    );
  }
}

class ReportsScreenView extends StatefulWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const ReportsScreenView({super.key, required this.isBacked, required this.onBack});

  @override
  State<ReportsScreenView> createState() => _ReportsScreenViewState();
}

class _ReportsScreenViewState extends State<ReportsScreenView> {
  int perUnitQuantity = 1;

  String getFlexiblePackPrice() {
    double unitPrice = 1.99;
    double total = perUnitQuantity * unitPrice;
    return "${total.toStringAsFixed(2)} € / Unit";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            onBackPressed: widget.onBack,
            isBacked: widget.isBacked,
            backgroundColor: AppColor().backgroundColor,
            title: "My Subscription",
          ),
          Expanded(child: _subscriptionView(context))
        ],
      ),
    );
  }

  _subscriptionView(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return CustomContainer(
      height: screenSize.height * 0.02,
      width: double.infinity,
      backgroundColor: AppColor().backgroundColor,
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.verified, color: Colors.orange, size: 24),
                SizedBox(width: 8),
                Text(
                  "Auto Proof Membership",
                  style: MontserratStyles.montserratMediumTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            _buildSubscriptionCard(
              title: "Starter Pack",
              price: "0€",
              highlightFeature: [
                "3 Inspection Units Free for\nNew Accounts",
                "Units Expire in 1 Year"
              ],
              features: [
                "Free Account",
                "1 Check-In/ Check-Out",
                "No Commitment",
                "Try Before You Buy",
                "1 Year History Saving"
              ],
              buttonTitle: "Get Started Free",
              onTap: () {},
            ),
            SizedBox(height: 16),

            _buildSubscriptionCard(
              title: "Flexible Pack",
              price: getFlexiblePackPrice(),
              highlightFeature: [
                "Buy As Needed",
                "Units Expire in 1 Year"
              ],
              features: [
                "Free Account",
                "Scalable On Demand",
                "Pay Only for What You Use",
                "1 Year History Saving",
              ],
              isPerUnit: true,
              buttonTitle: "Start Now",
              onTap: () {},
            ),
            SizedBox(height: 16),

            _buildSubscriptionCard(
              title: "Growth Pack ",
              price: "338.30 € Total",
              highlightFeature: [
                "15% Off Regular Price",
                "Units Expire in 1 Year"
              ],
              features: [
                "Free Account",
                "Prepaid 200 Units",
                "Great for Small Teams",
                "1 Year History Saving"
              ],
              buttonTitle: "Buy 200 Units",
              onTap: () {},
              hasDiscount: true,
            ),
            SizedBox(height: 16),

            _buildSubscriptionCard(
              title: "Pro Pack ",
              price: "746.25 € Total",
              highlightFeature: [
                "25% Off Regular Price",
                "Units Expire in 1 Year"
              ],
              features: [
                "Free Account",
                "Prepaid 500 Units",
                "Best Price per Unit",
                "1 Year History Saving"
              ],
              buttonTitle: "Buy 500 Units",
              onTap: () {},
            ),
            SizedBox(height: 16),

            _buildCustomSubscriptionCard(
              title: "On-Demand",
              highlightFeature: [
                "Get flexible, high-volume usage billed dynamically based on real-time demand or integration usage.",
              ],
              customPlanTitle: "Custom Plan",
              customPlanFeatures: [
                "Tailored to usage & volume – perfect for APIs, automation, and enterprise integrations.",
                "Valid for 1 Year",
              ],
              features: [
                "Real-time unit allocation",
                "Custom SLAs & volume pricing",
                "API-first design",
                "No limits – scale as needed",
              ],
              buttonTitle: "Contact Sales",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String price,
    required List<String> highlightFeature,
    required List<String> features,
    required String buttonTitle,
    required VoidCallback onTap,
    bool isPerUnit = false,
    bool hasDiscount = false,
    String? discountText,
  }) {
    return CustomContainer(
      width: double.infinity,
      backgroundColor: AppColor().darkCharcoalBlueColor,
      padding: EdgeInsets.all(22),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: MontserratStyles.montserratMediumTextStyle(color: Colors.white, size: 24),
                    ),
                    SizedBox(height: 4),
                    Text(
                      price,
                      style: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().darkYellowColor, size: 20),
                    ),
                    vGap(25),
                    ...highlightFeature.map((f) => Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.fiber_manual_record, size: 8, color: Colors.white),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(f, style: MontserratStyles.montserratMediumTextStyle(color: Colors.white, size: 18)),
                          ),
                        ],
                      ),
                    )),
                    vGap(10),
                    ...features.map((feature) => Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(Icons.fiber_manual_record, size: 6, color: AppColor().darkYellowColor),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(feature, style: MontserratStyles.montserratNormalTextStyle(color: AppColor().darkYellowColor, size: 14)),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              if (isPerUnit || (hasDiscount && discountText != null)) ...[
                Column(
                  children: [
                    if (isPerUnit) vGap(8),
                    if (isPerUnit) _buildQuantitySelector(),
                    if (hasDiscount && discountText != null) ...[
                      vGap(8),
                      Text(
                        discountText!,
                        style: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().darkYellowColor, size: 12),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
          vGap(20),
          CustomButton(
            height: 70,
            width: double.infinity,
            onPressed: onTap,
            text: buttonTitle,
            borderRadius: 18,
            textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor, size: 20),
            backgroundColor: AppColor().darkYellowColor,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomSubscriptionCard({
    required String title,
    required List<String> highlightFeature,
    required List<String> features,
    required String buttonTitle,
    required VoidCallback onTap,
    bool isPerUnit = false,
    bool hasDiscount = false,
    String? discountText,
    String? customPlanTitle,
    List<String>? customPlanFeatures,
  }) {
    return CustomContainer(
      width: double.infinity,
      backgroundColor: AppColor().darkCharcoalBlueColor,
      padding: EdgeInsets.all(22),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: MontserratStyles.montserratMediumTextStyle(color: Colors.white, size: 24)),
          vGap(20),
          ...highlightFeature.map((feature) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Icon(Icons.fiber_manual_record, size: 6, color: Colors.white),
                ),
                SizedBox(width: 12),
                Expanded(child: Text(feature, style: MontserratStyles.montserratMediumTextStyle(color: Colors.white, size: 16))),
              ],
            ),
          )),
          vGap(10),
          if (customPlanTitle != null) ...[
            Text(customPlanTitle, style: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().darkYellowColor, size: 20)),
            vGap(15),
            if (customPlanFeatures != null)
              ...customPlanFeatures.map((feature) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 6),
                      child: Icon(Icons.fiber_manual_record, size: 4, color: AppColor().darkYellowColor),
                    ),
                    SizedBox(width: 12),
                    Expanded(child: Text(feature, style: MontserratStyles.montserratMediumTextStyle(color: Colors.white, size: 14))),
                  ],
                ),
              )),
          ],
          ...features.map((feature) => Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Icon(Icons.fiber_manual_record, size: 4, color: AppColor().darkYellowColor),
                ),
                SizedBox(width: 12),
                Expanded(child: Text(feature, style: MontserratStyles.montserratNormalTextStyle(color: AppColor().darkYellowColor, size: 14))),
              ],
            ),
          )),
          vGap(25),
          CustomButton(
            height: 70,
            width: double.infinity,
            onPressed: onTap,
            text: buttonTitle,
            borderRadius: 18,
            textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor, size: 18),
            backgroundColor: AppColor().darkYellowColor,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor().darkYellowColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (perUnitQuantity > 1) {
                setState(() {
                  perUnitQuantity--;
                });
              }
            },
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              child: Icon(Icons.remove, color: AppColor().darkYellowColor, size: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              perUnitQuantity.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                perUnitQuantity++;
              });
            },
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              child: Icon(Icons.add, color: AppColor().darkYellowColor, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
