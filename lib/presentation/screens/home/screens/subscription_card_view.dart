part of "home_screen_route_imple.dart";

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor().darkCharcoalBlueColor,
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Subscription',
                  style: MontserratStyles.montserratSemiBoldTextStyle(size: 20),
                ),
                SizedBox(height: 8),
                Text(
                  '29,99€ / month',
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 25,
                    color: AppColor().yellowWarmColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '•  Free Account',
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 14,
                    color: AppColor().yellowWarmColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '•  20 Check-In/ Check-Out',
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 14,
                    color: AppColor().yellowWarmColor,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '•  Valable 31/12/2026',
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 14,
                    color: AppColor().yellowWarmColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor().yellowWarmColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: Text(
                    'Renew Now',
                    style: MontserratStyles.montserratMediumTextStyle(
                      size: 18,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
