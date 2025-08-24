part of 'subscription_screen_route_imple.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});
  /*
  static const List< List<GetSubscriptionPlanData>? plans = [
    SubscriptionPlan(
      title: "Flexible Pack",
      price: "1.99 ",
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
      price: "338.30",
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
      price: "746.25",
      features: [
        "Free Account",
        "Prepaid 500 Units",
        "Best Price per Unit",
        "1 Year History Saving",
      ],
      buttonText: "Buy 500 Units",
      mainFeatures: ["25% Off Regular Price", "Units Expire in 1 Year"],
    ),
  ];*/

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  GetSubscriptionPlanModel? getSubscriptionPlanModel;
  List<GetSubscriptionPlanData>? getSubscriptionPlanModelData;
  double getAspectRatioForLargeTablet(
    double containerWidth,
    double containerHeight, {
    double spacing = 20,
  }) {
    final int cols = 2;
    final totalSpacing = spacing * (cols - 1);
    final cardWidth = (math.max(300.0, containerWidth) - totalSpacing) / cols;

    final desiredHeight = (containerHeight * 0.42).clamp(240.0, 460.0);
    double ratio = cardWidth / desiredHeight;
    return ratio.clamp(0.6, 1.5);
  }

  @override
  void initState() {
    context.read<GetSubscriptionBloc>().add(GetSubscriptionApiEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<GetSubscriptionBloc, GetSubscriptionState>(
      listener: (context, state) {
        if (state is GetSubscriptionSuccess) {
          getSubscriptionPlanModel = state.getSubscriptionPlanModel;
          getSubscriptionPlanModelData = getSubscriptionPlanModel?.data;
        }
      },
      builder: (context, state) {
        return Responsive(
          mobile: SubscriptionMobile(plans: getSubscriptionPlanModelData ?? []),
          desktop: SubscriptionDesktop(
            plans: getSubscriptionPlanModelData ?? [],
            childAspectRatio: 1,
            type: 'desktop',
          ),
          tab: SubscriptionDesktop(
            plans: getSubscriptionPlanModelData ?? [],
            childAspectRatio: 1.2,
            crossAxisCount: 2,
            type: 'tab',
          ),
          largeTablet: SubscriptionDesktop(
            plans: getSubscriptionPlanModelData ?? [],
            crossAxisCount: 2,
            childAspectRatio: getAspectRatioForLargeTablet(
              screenWidth,
              screenHeight,
            ),
            type: 'larger',
          ),
        );
      },
    );
  }
}

class SubscriptionCard extends StatefulWidget {
  final List<GetSubscriptionPlanData> plan;
  final int index;

  const SubscriptionCard({super.key, required this.plan, required this.index});

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  final TextEditingController _qtyController = TextEditingController(text: "3");
  int _quantity = 3;
  void _updateQuantity() {
    final int? qty = int.tryParse(_qtyController.text);
    setState(() {
      _quantity = (qty != null && qty > 0) ? qty : 1;
    });
  }

  double get totalPrice {
    // Assuming price in plan.price is like "₹100" or "$99"
    final String? numeric = widget.plan[widget.index].planPrice?.replaceAll(
      RegExp(r'[^0-9.]'),
      "",
    );
    final double basePrice = double.tryParse(numeric ?? "") ?? 0;
    return basePrice * _quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2C3E50),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child:
          Responsive.isTablet(context) ||
              Responsive.isLargeTablet(context) ||
              Responsive.isDesktop(context)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Responsive.isDesktop(context)
                    ? const SizedBox(height: 20)
                    : const SizedBox(height: 0),

                _buildHeader(),
                const SizedBox(height: 8),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.plan[widget.index].planDescription!
                            .split(".") // split by "."
                            .where((line) => line.trim().isNotEmpty)
                            .map(
                              (line) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  "• ${line.trim()}",
                                  style:
                                      MontserratStyles.montserratMediumTextStyle(
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      vGap(10),

                      widget.plan[widget.index].features?.freeAccount == true
                          ? Text(
                              "• Free Account ",
                              style: MontserratStyles.montserratMediumTextStyle(
                                size: 16,
                                color: AppColor().yellowWarmColor,
                              ),
                            )
                          : SizedBox.shrink(),

                      Text(
                        "• ${(widget.plan[widget.index].features?.prepaidUnits != null) ?
                        "Prepaid ${widget.plan[widget.index].features?.prepaidUnits ?? 0} Units" : "Scalable On Demand"}  ",
                        style: MontserratStyles.montserratMediumTextStyle(
                          size: 16,
                          color: AppColor().yellowWarmColor,
                        ),
                      ),
                      Text(
                        "• ${(widget.index == 0) ? "Pay Only for What You Use" : (widget.index == 1) ? "Great for Small Teams" : "Best Price per Unit"}  ",
                        style: MontserratStyles.montserratMediumTextStyle(
                          size: 16,
                          color: AppColor().yellowWarmColor,
                        ),
                      ),
                    (  widget.plan[widget.index].features?.historySaving == null  || widget.plan[widget.index].features?.historySaving == ""    ) ?SizedBox.shrink()
                        :  Text(
                        "• ${widget.plan[widget.index].features?.historySaving} History Saving",
                        style: MontserratStyles.montserratMediumTextStyle(
                          size: 16,
                          color: AppColor().yellowWarmColor,
                        ),
                      ),

                      /*   ...widget.plan[widget.index].features?.map((f) => _buildFeature(f, false)),*/
                      const Spacer(),
                    ],
                  ),
                ),
                _buildActionButton(),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.plan[widget.index].planDescription!
                      .split(".") // split by "."
                      .where((line) => line.trim().isNotEmpty)
                      .map(
                        (line) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            "• ${line.trim()}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 4),
                // 👇 Spacer pushes button to the bottom
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
              widget.plan[widget.index].planTitle ?? "",
              style: MontserratStyles.montserratSemiBoldTextStyle(size: 20),
            ),
            const SizedBox(height: 4),
            Text(
              (widget.plan[widget.index].planTitle == "Flexible Pack")
                  ? ("$totalPrice € / Unit ")
                  : "${(widget.plan[widget.index].planPrice ?? "")} € Total",
              /* "$totalPrice ${(widget.plan[widget.index].planPrice.toString()) ? "€ (${widget.plan[widget.index].planPrice} € /Unit)": "€ Total"}",*/ style:
                  MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: AppColor().yellowWarmColor,
                  ),
            ),
          ],
        ),
        if (widget.plan[widget.index].planTitle == "Flexible Pack")
          _buildQuantitySelector(),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),

            // 👇 Looks like textfield, fixed size
            SizedBox(
              width: 40,
              height: 28,
              child: TextFormField(
                onChanged: (v) {
                  _updateQuantity();
                },

                textAlign: TextAlign.center,
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 14,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                ),
                controller: _qtyController,
              ),
            ),

            const SizedBox(width: 8),
          ],
        ),
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
        child: Text(
          "${(widget.plan[widget.index].planTitle == "Flexible Pack ") ? "Start Now" : "Buy ${widget.plan[widget.index].planUnits} Units"} ",
          style: MontserratStyles.montserratMediumTextStyle(
            size: 15,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),
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
