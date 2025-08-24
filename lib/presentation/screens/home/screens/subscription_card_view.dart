part of "home_screen_route_imple.dart";

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor().darkCharcoalBlueColor,
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Responsive.isMobile(context)
            ?  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Starter Pack',
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 25,
                  ),
                ),
                hGap(15),
                Text(
                  '0€',
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 25,
                    color: AppColor().yellowWarmColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            Text(
              '• 3 Inspection Units Free for New Accounts',
              style: MontserratStyles.montserratMediumTextStyle(
                size: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 3),
            Text(
              '• Units Expire in 1 Year',
              style: MontserratStyles.montserratMediumTextStyle(
                size: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• Free Account',
                      style:
                      MontserratStyles.montserratRegularTextStyle(
                        size: 16,
                        color: AppColor().yellowWarmColor,
                      ),
                    ),
                    Text(
                      '• No Commitment',
                      style:
                      MontserratStyles.montserratRegularTextStyle(
                        size: 16,
                        color: AppColor().yellowWarmColor,
                      ),
                    ),
                  ],
                ),
                hGap(MediaQuery.of(context).size.width / 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '•  Try Before You Buy',
                      style:
                      MontserratStyles.montserratRegularTextStyle(
                        size: 16,
                        color: AppColor().yellowWarmColor,
                      ),
                    ),
                    Text(
                      '•  1 Year History Saving',
                      style:
                      MontserratStyles.montserratRegularTextStyle(
                        size: 16,
                        color: AppColor().yellowWarmColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Center(
              child: CustomButtonWeb(
                text: "Active Plan",
                onPressed: () {},
                color: AppColor().yellowWarmColor,
                textColor: AppColor().darkCharcoalBlueColor,
                borderRadius: 10,
              ),
            ),
          ],
        )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Starter Pack',
                            style: MontserratStyles.montserratMediumTextStyle(
                              size: 20,
                            ),
                          ),
                          hGap(15),
                          Text(
                            '0€',
                            style: MontserratStyles.montserratMediumTextStyle(
                              size: 20,
                              color: AppColor().yellowWarmColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Text(
                        '• 3 Inspection Units Free for New Accounts',
                        style: MontserratStyles.montserratMediumTextStyle(
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        '• Units Expire in 1 Year',
                        style: MontserratStyles.montserratMediumTextStyle(
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '• Free Account',
                                style:
                                    MontserratStyles.montserratRegularTextStyle(
                                      size: 10,
                                      color: AppColor().yellowWarmColor,
                                    ),
                              ),
                              Text(
                                '• No Commitment',
                                style:
                                    MontserratStyles.montserratRegularTextStyle(
                                      size: 10,
                                      color: AppColor().yellowWarmColor,
                                    ),
                              ),
                            ],
                          ),
                          hGap(MediaQuery.of(context).size.width / 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '•  Try Before You Buy',
                                style:
                                    MontserratStyles.montserratRegularTextStyle(
                                      size: 10,
                                      color: AppColor().yellowWarmColor,
                                    ),
                              ),
                              Text(
                                '•  1 Year History Saving',
                                style:
                                    MontserratStyles.montserratRegularTextStyle(
                                      size: 10,
                                      color: AppColor().yellowWarmColor,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                  Center(
                    child: CustomButtonWeb(
                      text: "Active Plan",
                      onPressed: () {},
                      color: AppColor().yellowWarmColor,
                      textColor: AppColor().darkCharcoalBlueColor,
                      borderRadius: 10,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
