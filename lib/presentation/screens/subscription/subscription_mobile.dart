part of 'subscription_screen_route_imple.dart';

class SubscriptionMobile extends StatelessWidget {
  final List<SubscriptionPlan> plans;

  const SubscriptionMobile({super.key, required this.plans});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plans.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return SubscriptionCard(plan: plans[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}