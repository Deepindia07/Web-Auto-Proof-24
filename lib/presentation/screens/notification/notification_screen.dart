part of "notification_screen_route_imple.dart";

class NotificationScreen extends StatelessWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const NotificationScreen({super.key,required this.isBacked, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationScreenBloc>(
      create: (context) => NotificationScreenBloc(),
      child: NotificationScreenView(isBacked: isBacked,onBack: onBack),
    );
  }
}

class NotificationScreenView extends StatefulWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const NotificationScreenView({super.key,required this.isBacked, required this.onBack});

  @override
  State<NotificationScreenView> createState() => _NotificationScreenViewState();
}

class _NotificationScreenViewState extends State<NotificationScreenView> {
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
              title: "Notification",
          ),
          Expanded(child: _mainContainerWidget(context))
        ],
      ),
    );
  }

  _mainContainerWidget(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          _buildNotificationItem(
            context,
            icon: Icons.star,
            iconColor: Colors.amber,
            title: "Subscription Expire Soon",
            description: "You may be asked to accept travel again",
            timestamp: "17/10/205 at 8:00PM",
            isHighlighted: true,
          ),
          SizedBox(height: 12),
          _buildNotificationItem(
            context,
            icon: Icons.directions_car,
            iconColor: Colors.amber,
            title: "Check-In now",
            description: "You may be asked to accept travel again",
            timestamp: "17/10/205 at 7:00PM",
            isHighlighted: false,
          ),
          SizedBox(height: 12),
          _buildNotificationItem(
            context,
            icon: Icons.info,
            iconColor: Colors.blue,
            title: "New Update Available",
            description: "You may be asked to accept travel again",
            timestamp: "17/10/205 at 5:35PM",
            isHighlighted: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
      BuildContext context, {
        required IconData icon,
        required Color iconColor,
        required String title,
        required String description,
        required String timestamp,
        required bool isHighlighted,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.white : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighlighted ? Colors.grey[300]! : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: isHighlighted
            ? [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon container
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MontserratStyles.montserratMediumTextStyle(size: 14,color: AppColor().darkCharcoalBlueColor)
                ),
                SizedBox(height: 4),
                Text(
                  description,
                    style: MontserratStyles.montserratSemiBoldTextStyle(size: 12,color: AppColor().silverShadeGrayColor)

                ),
                SizedBox(height: 8),
                Text(
                  timestamp,
                  style: MontserratStyles.montserratSemiBoldTextStyle(size: 12,color: AppColor().silverShadeGrayColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}