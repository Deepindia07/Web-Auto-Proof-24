part of 'about_app_screen_route_imple.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AboutAppBloc()..add(LoadAppInfo()),
      child: Scaffold(
        backgroundColor: AppColor().backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor().backgroundColor,
          title:  Text('About App',style: MontserratStyles.montserratMediumTextStyle(
            size: 20,
            color: AppColor().darkCharcoalBlueColor,
          ),),
          centerTitle: true,
          elevation: 1,
        ),
        body: BlocBuilder<AboutAppBloc, AboutAppState>(
          builder: (context, state) {
            if (state is AboutAppLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AboutAppError) {
              return Center(child: Text(state.message));
            } else if (state is AboutAppLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App title
                    Center(
                      child: Text(
                        'Auto Proof 24',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Card Section for App Description
                    _buildInfoCard(
                      context,
                      icon: Icons.info_outline,
                      title: 'About the App',
                      content:
                      'Auto Proof 24 is a simple, easy-to-use digital car inspection app designed to make vehicle check-ins and check-outs faster, clearer, and more reliable. Whether you’re running a car rental service, managing a dealership, or just want to keep a personal record of your vehicle’s condition, this app is built for you.',
                    ),

                    const SizedBox(height: 16),

                    _buildInfoCard(
                      context,
                      icon: Icons.flag_outlined,
                      title: 'Our Goal',
                      content:
                      'Our goal is to take the stress out of car inspections by making the process digital, efficient, and completely paper-free.',
                    ),

                    const SizedBox(height: 16),

                    _buildInfoCard(
                      context,
                      icon: Icons.check_circle_outline,
                      title: 'What You Can Do',
                      content:
                      'Create an account, carry out detailed inspections, and receive a professional report instantly by email. The app walks you through each step — take photos, add notes, log mileage, fuel levels, tire conditions, and any existing damage.',
                    ),

                    const SizedBox(height: 16),

                    _buildInfoCard(
                      context,
                      icon: Icons.document_scanner_outlined,
                      title: 'Digital Reports',
                      content:
                      'Every inspection generates a time-stamped digital report that’s automatically shared with both the vehicle owner and the customer, creating a clear and trustworthy record.',
                    ),

                    const SizedBox(height: 16),

                    _buildInfoCard(
                      context,
                      icon: Icons.directions_car_filled_outlined,
                      title: 'Who It’s For',
                      content:
                      'Whether you’re handling a fleet or just one vehicle, Auto Proof 24 gives you a smart and reliable way to document your car’s condition — anytime, anywhere.',
                    ),

                    const SizedBox(height: 24),

                    // App Version
                    Center(
                      child: Text(
                        'App Version: ${state.version}',
                        style: MontserratStyles.montserratMediumTextStyle(size: 14,color: AppColor().silverShadeGrayColor)
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  // Helper widget to style content into nice sections
  Widget _buildInfoCard(BuildContext context,
      {required IconData icon, required String title, required String content}) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContainer(
              padding: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                backgroundColor: AppColor().darkYellowColor.withOpacity(0.1),
                child: Icon(icon, color: AppColor().darkYellowColor)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    content,
                    style: MontserratStyles.montserratRegularTextStyle(
                      size: 15,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
