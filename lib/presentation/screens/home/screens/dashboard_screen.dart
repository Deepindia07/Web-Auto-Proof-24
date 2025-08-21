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
                        SubscriptionCard(),
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
}
