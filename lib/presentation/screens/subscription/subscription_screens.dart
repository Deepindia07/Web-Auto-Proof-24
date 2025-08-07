part of 'subscription_screen_route_imple.dart';

/*import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: SubscriptionGridScreen()));
}

class SubscriptionGridScreen extends StatelessWidget {
  const SubscriptionGridScreen({super.key});

  final List<SubscriptionPlan> plans = const [
    SubscriptionPlan(
      title: "Flexible Pack",
      price: "1.99 € / Unit",
      features: [
        "Buy As Needed",
        "Units Expire in 1 Year",
        "Free Account",
        "Scalable On Demand",
        "Pay Only for What You Use",
        "1 Year History Saving",
      ],
      buttonText: "Start Now",
      showQuantitySelector: true,
    ),
    SubscriptionPlan(
      title: "Growth Pack",
      price: "338.30 € Total",
      features: [
        "15% Off Regular Price",
        "Units Expire in 1 Year",
        "Free Account",
        "Prepaid 200 Units",
        "Great for Small Teams",
        "1 Year History Saving",
      ],
      buttonText: "Buy 200 Units",
    ),
    SubscriptionPlan(
      title: "Pro Pack",
      price: "746.25 € Total",
      features: [
        "25% Off Regular Price",
        "Units Expire in 1 Year",
        "Free Account",
        "Prepaid 500 Units",
        "Best Price per Unit",
        "1 Year History Saving",
      ],
      buttonText: "Buy 500 Units",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 1;

    if (width > 1200) {
      crossAxisCount = 3;
    } else if (width > 800) {
      crossAxisCount = 2;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        title: const Text('My subscription'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.85,
          ),
          itemCount: plans.length,
          itemBuilder: (context, index) {
            return SubscriptionCard(plan: plans[index]);
          },
        ),
      ),
    );
  }
}*/
class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final List<SubscriptionPlan> plans = const [
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    double maxCrossAxisExtent = 400;
    if (width >= 1400) {
      maxCrossAxisExtent = 500;
    } else if (width >= 1000) {
      maxCrossAxisExtent = 450;
    }

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My subscription",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 16,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: plans.length,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: maxCrossAxisExtent,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        // height now depends on content!
                        mainAxisExtent: null,
                      ),
                      itemBuilder: (context, index) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(minHeight: 300),
                          child: SubscriptionCard(plan: plans[index]),
                        )
                        ;
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plan.title,
                      style: MontserratStyles.montserratSemiBoldTextStyle(size: 16)),
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
              if (plan.showQuantitySelector)
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor().yellowWarmColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        _circleButton(Icons.remove),
                        const SizedBox(width: 8),
                        Text("1",
                            style: MontserratStyles.montserratSemiBoldTextStyle(
                              size: 14,
                              color: AppColor().darkCharcoalBlueColor,
                            )),
                        const SizedBox(width: 8),
                        _circleButton(Icons.add),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ...plan.mainFeatures.map((feature) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text("• $feature",
                style: MontserratStyles.montserratMediumTextStyle(size: 13)),
          )),
          const SizedBox(height: 4),
          ...plan.features.map((feature) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Text("• $feature",
                style: MontserratStyles.montserratNormalTextStyle(
                    size: 13, color: AppColor().yellowWarmColor)),
          )),
        vGap(20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(plan.buttonText),
            ),
          ),
        ],
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
