part of 'subscription_screen_route_imple.dart';

class SubscriptionDesktop extends StatelessWidget {
  final List<GetSubscriptionPlanData> plans;
  final int crossAxisCount;
  final double childAspectRatio;
  final String type;

  const SubscriptionDesktop({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
    required this.plans, required this.type,
  });

  @override
  Widget build(BuildContext context) {
    const defaultPadding = 20.0;
print("type---$type");
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
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
                Expanded(
                  child: GridView.builder(
                    itemCount: plans.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: defaultPadding / 2,
                      mainAxisSpacing: defaultPadding / 2,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemBuilder: (context, index) =>
                        SubscriptionCard(plan: plans ,index: index),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
