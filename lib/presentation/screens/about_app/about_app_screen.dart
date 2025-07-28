part of 'about_app_screen_route_imple.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => AboutAppBloc()..add(LoadAppInfo()),
      child: Scaffold(
        backgroundColor: AppColor().backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColor().backgroundColor,
          title: Text(
            local.aboutApp,
            style: MontserratStyles.montserratMediumTextStyle(
              size: 20,
              color: AppColor().darkCharcoalBlueColor,
            ),
          ),
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
                        local.autoProofTitle,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // About App Section
                    _buildInfoCard(
                      context,
                      icon: Icons.info_outline,
                      title: local.aboutTheAppTitle,
                      content: local.aboutTheAppDescription,
                    ),

                    const SizedBox(height: 16),

                    _buildInfoCard(
                      context,
                      icon: Icons.flag_outlined,
                      title: local.ourGoalTitle,
                      content: local.ourGoalDescription,
                    ),

                    const SizedBox(height: 16),

                    _buildInfoCard(
                      context,
                      icon: Icons.check_circle_outline,
                      title: local.whatYouCanDoTitle,
                      content: local.whatYouCanDoDescription,
                    ),

                    const SizedBox(height: 16),

                    _buildInfoCard(
                      context,
                      icon: Icons.document_scanner_outlined,
                      title: local.digitalReportsTitle,
                      content: local.digitalReportsDescription,
                    ),

                    const SizedBox(height: 16),

                    _buildInfoCard(
                      context,
                      icon: Icons.directions_car_filled_outlined,
                      title: local.whoItsForTitle,
                      content: local.whoItsForDescription,
                    ),

                    const SizedBox(height: 24),

                    // App Version
                    Center(
                      child: Text(
                        local.appVersion(state.version),
                        style: MontserratStyles.montserratMediumTextStyle(
                          size: 14,
                          color: AppColor().silverShadeGrayColor,
                        ),
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
              padding: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
              backgroundColor: AppColor().darkYellowColor.withOpacity(0.1),
              child: Icon(icon, color: AppColor().darkYellowColor),
            ),
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
