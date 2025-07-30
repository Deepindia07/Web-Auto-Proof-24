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

  String get flexiblePackPrice => "${(perUnitQuantity * 1.99).toStringAsFixed(2)} € / Unit";

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
          Expanded(child: _subscriptionView()),
        ],
      ),
    );
  }

  Widget _subscriptionView() {
    return CustomContainer(
      height: MediaQuery.of(context).size.height * 0.02,
      width: double.infinity,
      backgroundColor: AppColor().backgroundColor,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.verified, color: Colors.orange, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Auto Proof Membership",
                  style: MontserratStyles.montserratMediumTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            ..._buildSubscriptionCards(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSubscriptionCards() {
    final cards = [
      _SubscriptionData(
        title: "Starter Pack",
        price: "0€",
        highlights: ["3 Inspection Units Free for\nNew Accounts", "Units Expire in 1 Year"],
        features: ["Free Account", "1 Check-In/ Check-Out", "No Commitment", "Try Before You Buy", "1 Year History Saving"],
        buttonTitle: "Get Started Free",
      ),
      _SubscriptionData(
        title: "Flexible Pack",
        price: flexiblePackPrice,
        highlights: ["Buy As Needed", "Units Expire in 1 Year"],
        features: ["Free Account", "Scalable On Demand", "Pay Only for What You Use", "1 Year History Saving"],
        buttonTitle: "Start Now",
        isPerUnit: true,
      ),
      _SubscriptionData(
        title: "Growth Pack",
        price: "338.30 € Total",
        highlights: ["15% Off Regular Price", "Units Expire in 1 Year"],
        features: ["Free Account", "Prepaid 200 Units", "Great for Small Teams", "1 Year History Saving"],
        buttonTitle: "Buy 200 Units",
        hasDiscount: true,
      ),
      _SubscriptionData(
        title: "Pro Pack",
        price: "746.25 € Total",
        highlights: ["25% Off Regular Price", "Units Expire in 1 Year"],
        features: ["Free Account", "Prepaid 500 Units", "Best Price per Unit", "1 Year History Saving"],
        buttonTitle: "Buy 500 Units",
      ),
    ];

    return cards.expand((card) => [
      _buildSubscriptionCard(card),
      const SizedBox(height: 16),
    ]).toList();
  }

  Widget _buildSubscriptionCard(_SubscriptionData data) {
    return CustomContainer(
      width: double.infinity,
      backgroundColor: AppColor().darkCharcoalBlueColor,
      padding: const EdgeInsets.all(22),
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
                    Text(data.title, style: MontserratStyles.montserratMediumTextStyle(color: Colors.white, size: 24)),
                    const SizedBox(height: 4),
                    Text(data.price, style: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().darkYellowColor, size: 20)),
                    const SizedBox(height: 25),
                    ..._buildFeatureList(data.highlights, Colors.white, 16, 8),
                    const SizedBox(height: 10),
                    ..._buildFeatureList(data.features, AppColor().darkYellowColor, 14, 6),
                  ],
                ),
              ),
              if (data.isPerUnit) _buildQuantitySelector(),
            ],
          ),
          const SizedBox(height: 20),
          CustomButton(
            height: 50,
            width: double.infinity,
            onPressed: () {},
            text: data.buttonTitle,
            side: const BorderSide(width: 2, color: Colors.white),
            borderRadius: 12,
            textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor, size: 18),
            backgroundColor: AppColor().darkYellowColor,
            textColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 12),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFeatureList(List<String> features, Color color, double fontSize, double iconSize) {
    return features.map((feature) => Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(Icons.fiber_manual_record, size: iconSize, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              feature,
              style: MontserratStyles.montserratMediumTextStyle(color: color, size: fontSize),
            ),
          ),
        ],
      ),
    )).toList();
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor().darkYellowColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(Icons.remove, () {
            if (perUnitQuantity > 1) setState(() => perUnitQuantity--);
          }),
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
          _buildQuantityButton(Icons.add, () => setState(() => perUnitQuantity++)),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
        child: Icon(icon, color: AppColor().darkYellowColor, size: 20),
      ),
    );
  }
}

class _SubscriptionData {
  final String title;
  final String price;
  final List<String> highlights;
  final List<String> features;
  final String buttonTitle;
  final bool isPerUnit;
  final bool hasDiscount;

  _SubscriptionData({
    required this.title,
    required this.price,
    required this.highlights,
    required this.features,
    required this.buttonTitle,
    this.isPerUnit = false,
    this.hasDiscount = false,
  });
}