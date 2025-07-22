part of "reports_screen_route_imple.dart";

class ReportsScreen extends StatelessWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const ReportsScreen({super.key, required this.isBacked, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReportsScreenBloc>(
      create: (context) => ReportsScreenBloc(),
      child: ReportsScreenView(isBacked: isBacked,onBack: onBack,),
    );
  }
}

class ReportsScreenView extends StatefulWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const ReportsScreenView({super.key,required this.isBacked, required this.onBack});

  @override
  State<ReportsScreenView> createState() => _ReportsScreenViewState();
}

class _ReportsScreenViewState extends State<ReportsScreenView> {
  int perUnitQuantity = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
              onBackPressed: widget.onBack,
              isBacked:widget.isBacked,
              backgroundColor: AppColor().backgroundColor,
              title: "My Subscription"

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
            // Auto Proof Membership Header
            Row(
              children: [
                Icon(
                  Icons.verified,
                  color: Colors.orange,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  "Auto Proof Membership",
                  style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 18)
                ),
              ],
            ),
            SizedBox(height: 20),

            // Per Unit Plan
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
                " Try Before You Buy",
                "1 Year History Saving"
              ],
              buttonTitle: "Get Started Free",
              onTap: () {  },
              // isPerUnit: true,
            ),
            SizedBox(height: 16),

            // Monthly Plan
            _buildSubscriptionCard(
              title: "Monthly",
              price: "26,99€ / month",
              highlightFeature: [
                "3 Inspection Units Free for\nNew Accounts",
                "Units Expire in 1 Year"
              ],
              features: [
                "Free Account",
                "3 Team Members",
                "20 Check-In/ Check-Out",
              ],
              isPerUnit: true,
              buttonTitle: "Start Now",
              onTap: () {  },
            ),
            SizedBox(height: 16),

            // Yearly Plan
            _buildSubscriptionCard(
              title: "Yearly",
              price: "290,99€ / month",
              highlightFeature: [
                "3 Inspection Units Free for\nNew Accounts",
                "Units Expire in 1 Year"
              ],
              features: [
                "Free Account",
                "3 Team Members",
                "20 Check-In/ Check-Out",
              ],
              buttonTitle: "Start Now",
              onTap: () {  },
              hasDiscount: true,
              // discountText: "10% OFF",
            ),
            SizedBox(height: 16),

            // Enterprise Pack
            _buildSubscriptionCard(
              title: "Enterprise Pack",
              price: "290,99€ / month",
              highlightFeature: [
                "3 Inspection Units Free for\nNew Accounts",
                "Units Expire in 1 Year"
              ],
              features: [
                "Free Account",
                "5 Team Members",
                "Unlimited Check-In/ Check-Out",
              ],
              buttonTitle: "Start Now",
              onTap: () {  },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String price,
    required List<String>highlightFeature,
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: MontserratStyles.montserratMediumTextStyle(color: Colors.white,size: 24)
                      ),
                      SizedBox(height: 4),
                      Text(
                        price,
                        style: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().darkYellowColor,size: 20)
                      ),
                    ],
                  ),
                  vGap(25),
                  ...highlightFeature.map((f) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.fiber_manual_record,
                          size: 8,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          f,
                          style: MontserratStyles.montserratMediumTextStyle(color: Colors.white,size: 18),
                        ),
                      ],
                    ),
                  )).toList(),
                  vGap(10),
                  ...features.map((feature) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.fiber_manual_record,
                          size: 6,
                          color: AppColor().darkYellowColor,
                        ),
                        SizedBox(width: 8),
                        Text(
                          feature,
                          style: MontserratStyles.montserratNormalTextStyle(color: AppColor().darkYellowColor,size: 14),
                        ),
                      ],
                    ),
                  )).toList()
                ],
              ),
              Column(
                children: [
                  if (isPerUnit) ...[
                    vGap(8),
                    _buildQuantitySelector(),
                  ],
                  if (hasDiscount && discountText != null) ...[
                    vGap(8),
                    Text(
                      discountText,
                      style:MontserratStyles.montserratSemiBoldTextStyle(
                          color: AppColor().darkYellowColor,size: 12
                      ),
                    ),
                    // SizedBox(width: 8),
                  ],
                ],
              ),
            ],
          ),
          vGap(20),
          CustomButton(
            height: 70,
            onPressed: onTap,/*(){
              context.push(AppRoute.paymentScreen);
            },*/
            text: buttonTitle,
            borderRadius: 18,
            textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 20),
            backgroundColor: AppColor().darkYellowColor,
            textColor: Colors.white,
            // fontSize: 14,
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2,vertical: 2),
      decoration: BoxDecoration(
        color: AppColor().darkYellowColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white,width: 3)
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
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.remove,
                color: AppColor().darkCharcoalBlueColor,
                size: 16,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              perUnitQuantity.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:AppColor().darkCharcoalBlueColor,
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
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: AppColor().darkCharcoalBlueColor,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}