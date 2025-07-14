part of "history_screen_route_imple.dart";

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HistoryScreenView();
  }
}

class HistoryScreenView extends StatefulWidget {
  const HistoryScreenView({super.key});

  @override
  State<HistoryScreenView> createState() => _HistoryScreenViewState();
}

class _HistoryScreenViewState extends State<HistoryScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
              title: "Payment History")
        ],
      ),
    );
  }
}
