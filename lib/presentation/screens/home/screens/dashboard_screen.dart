part of "home_screen_route_imple.dart";

class DashboardScreen extends StatelessWidget {
  final VoidCallback? onTap;
  const DashboardScreen({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;

          bool isMobile = maxWidth < 800;
          bool isTablet = maxWidth >= 800 && maxWidth < 1200;
          bool isDesktop = maxWidth >= 1200;

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSubscriptionSection(context),
                        /*SubscriptionCard(),*/
                        SizedBox(height: 16),
                        CreateInspectionButton(onTap: onTap),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildSubscriptionSection(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.only(top: 22),
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1,
            color: AppColor().darkYellowColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.autoProofTitle,
                            style: MontserratStyles.montserratSemiBoldTextStyle(
                              color: AppColor().darkYellowColor,
                              size: 16,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.freeAccount,
                            style: MontserratStyles.montserratBoldTextStyle(
                              color: AppColor().backgroundColor,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Units",
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        color: AppColor().backgroundColor,
                        size: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    RichText(text: TextSpan(children: [
                      TextSpan(text: "3  ", style: MontserratStyles.montserratRegularTextStyle(color: AppColor().darkYellowColor, size: 10,),),
                      TextSpan(text:"Left", style: MontserratStyles.montserratRegularTextStyle(color: AppColor().backgroundColor, size: 10,),
                      )]),)],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Valid Until",
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        color: AppColor().backgroundColor,
                        size: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text("20th Aug 2026",
                      style: MontserratStyles.montserratRegularTextStyle(
                        color: AppColor().backgroundColor,
                        size: 10,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Status",
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        color: AppColor().backgroundColor,
                        size: 12,
                      ),
                    ),
                    const SizedBox(height: 7),
                    // Text("Active",
                    //   style: MontserratStyles.montserratRegularTextStyle(
                    //     color: AppColor().backgroundColor,
                    //     size: 10,
                    //   ),
                    // ),
                    /// upcoming plan button
                    Container(
                      height: 20,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColor().darkYellowColor
                      ),
                      child: Text("Upgrade Plan", style: TextStyle(
                        fontSize: 8, fontWeight: FontWeight.w600,
                      ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
