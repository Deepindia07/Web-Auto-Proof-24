part of "notification_screen_route_imple.dart";

class NotificationScreen extends StatelessWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const NotificationScreen({
    super.key,
    required this.isBacked,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationScreenView(isBacked: isBacked, onBack: onBack);
  }
}

class NotificationScreenView extends StatefulWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const NotificationScreenView({
    super.key,
    required this.isBacked,
    required this.onBack,
  });

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
          vGap(5),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Notification",
              style: MontserratStyles.montserratBoldTextStyle(
                size: 14,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),
          vGap(10),
          /*  CustomAppBar(
            onBackPressed: widget.onBack,
            isBacked:widget.isBacked,
            backgroundColor: AppColor().backgroundColor,
              title: "Notification",
          ),*/
          Expanded(child: _mainContainerWidget(context)),
        ],
      ),
    );
  }

  _mainContainerWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildNotificationItem(
            context,
            icon: Icons.star,
            iconColor: Colors.amber,
            title: "Subscription Expire Soon",
            description: "You may be asked to accept travel again",
            timestamp: "17/10/205 at 8:00PM",
            isHighlighted: true,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10);
        },
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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor().silverShadeGrayColor, width: 1),
   /*     boxShadow: isHighlighted
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ]
            : null,*/
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon container
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MontserratStyles.montserratBoldTextStyle(
                    size: 14,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 12,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),

              ],
            ),
          ), SizedBox(width: 8),
          Text(
            timestamp,
            style: MontserratStyles.montserratRegularTextStyle(
              size: 12,
              color: AppColor().silverShadeGrayColor,
            ),
          ),
        ],
      ),
    );
  }
}
