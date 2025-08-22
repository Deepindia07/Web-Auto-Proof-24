part of "home_screen_route_imple.dart";

class WelcomeCard extends StatelessWidget {
  final bool isVisible;
  final VoidCallback? onTap;
  const WelcomeCard({super.key, this.onTap, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor().silverShadeGrayColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       isVisible == false ? SizedBox.shrink():   Text('Welcome !', style: TextStyle(fontSize: 12)),
          GestureDetector(
              onTap: onTap,
              child: Image.asset(layerIcon, height: 30, width: 30)),
        ],
      ),
    );
  }
}