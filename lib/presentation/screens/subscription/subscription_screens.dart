part of 'subscription_screen_route_imple.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  static const List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      title: "Flexible Pack",
      price: "1.99 € / Unit",
      features: [
        "Free Account",
        "Scalable On Demand",
        "Pay Only for What You Use",
        "1 Year History Saving",
      ],
      mainFeatures: ["Buy As Needed", "Units Expire in 1 Year"],
      buttonText: "Start Now",
      showQuantitySelector: true,
    ),
    SubscriptionPlan(
      title: "Growth Pack",
      price: "338.30 € Total",
      features: [
        "Free Account",
        "Prepaid 200 Units",
        "Great for Small Teams",
        "1 Year History Saving",
      ],
      buttonText: "Buy 200 Units",
      mainFeatures: ["15% Off Regular Price", "Units Expire in 1 Year"],
    ),
    SubscriptionPlan(
      title: "Pro Pack",
      price: "746.25 € Total",
      features: [
        "Free Account",
        "Prepaid 500 Units",
        "Best Price per Unit",
        "1 Year History Saving",
      ],
      buttonText: "Buy 500 Units",
      mainFeatures: ["25% Off Regular Price", "Units Expire in 1 Year"],
    ),
  ];

  double getAspectRatioForLargeTablet(
      double containerWidth,
      double containerHeight, {
        double spacing = 20,
      }) {
    final int cols = 2;
    final totalSpacing = spacing * (cols - 1);
    final cardWidth = (math.max(300.0, containerWidth) - totalSpacing) / cols;

    // ✅ Now using actual container height, not screen height
    final desiredHeight = (containerHeight * 0.42).clamp(240.0, 460.0);

    double ratio = cardWidth / desiredHeight;
    return ratio.clamp(0.6, 1.5);
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Responsive(
      mobile: SubscriptionMobile(plans: plans),
      desktop: SubscriptionDesktop(
        plans: plans,
        childAspectRatio: 1,
        type: 'desktop',
      ),
      tab: SubscriptionDesktop(
        plans: plans,
        childAspectRatio: 1.2,
        crossAxisCount: 2,
        type: 'tab',
      ),
      largeTablet: SubscriptionDesktop(
        plans: plans,
        crossAxisCount: 2,
        childAspectRatio: getAspectRatioForLargeTablet(
          screenWidth,
          screenHeight,
        ),
        type: 'larger',
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionPlan plan;

  const SubscriptionCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C3E50),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 8),
          ...plan.mainFeatures.map((f) => _buildFeature(f, false)),
          const SizedBox(height: 4),
          ...plan.features.map((f) => _buildFeature(f, true)),
        Responsive.isTablet(context) ?vGap(10) :  vGap(15),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plan.title,
              style: MontserratStyles.montserratSemiBoldTextStyle(size: 16),
            ),
            const SizedBox(height: 4),
            Text(
              plan.price,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 14,
                color: AppColor().yellowWarmColor,
              ),
            ),
          ],
        ),
        if (plan.showQuantitySelector) _buildQuantitySelector(),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: AppColor().yellowWarmColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            _circleButton(Icons.remove),
            const SizedBox(width: 8),
            Text(
              "1",
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 14,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
            const SizedBox(width: 8),
            _circleButton(Icons.add),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String feature, bool isHighlight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        "• $feature",
        style: isHighlight
            ? MontserratStyles.montserratNormalTextStyle(
                size: 13,
                color: AppColor().yellowWarmColor,
              )
            : MontserratStyles.montserratMediumTextStyle(size: 13),
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFFC107),
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text(plan.buttonText),
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColor().darkCharcoalBlueColor,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColor().yellowWarmColor, size: 14),
    );
  }
}

class SubscriptionPlan {
  final String title;
  final String price;
  final List<String> features;
  final List<String> mainFeatures;
  final String buttonText;
  final bool showQuantitySelector;

  const SubscriptionPlan({
    required this.title,
    required this.price,
    required this.features,
    required this.mainFeatures,
    required this.buttonText,
    this.showQuantitySelector = false,
  });
}
