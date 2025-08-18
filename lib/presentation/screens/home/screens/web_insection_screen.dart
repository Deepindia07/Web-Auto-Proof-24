part of "home_screen_route_imple.dart";

class WebInspectionScreen extends StatefulWidget {
  const WebInspectionScreen({super.key});

  @override
  State<WebInspectionScreen> createState() => _WebInspectionScreenState();
}

class _WebInspectionScreenState extends State<WebInspectionScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.05;
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) { return Align(alignment: Alignment.topCenter,
        child: Container(
          width:  screenWidth ,

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: AppColor().silverShadeGrayColor,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "Lets Start First Inspection",
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 20,color: Colors.black
                      ),
                    ),
                    vGap(5),
                    Text(
                      "and written signature.This signature may be used by\n me (or my authorized representative) on t",
                      textAlign: TextAlign.center,
                      style: MontserratStyles.montserratMediumTextStyle(
                          size: 10,color: Colors.black
                      ),
                    ),

                    vGap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(onTap: (){

                          launchUrl(
                            Uri.parse(
                              'https://apps.apple.com/app/idXXXXXXXXX',
                            ),
                          );setState(() {

                          });
                        },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black,
                            ),
                            child: Row(
                              children: [
                               Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      appleLogoIcon,
                                      width: 25,
                                      height: 30,
                                    ),
                                  ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Télécharger dans",
                                      style:
                                      MontserratStyles.montserratRegularTextStyle(
                                        size: 10,
                                      ),
                                    ),
                                    Text(
                                      "I'App Store",
                                      style:
                                      MontserratStyles.montserratSemiBoldTextStyle(
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(onTap: (){
                          launchUrl(
                            Uri.parse(
                              'https://play.google.com/store/apps/details?id=com.example.app',
                            ),
                          );setState(() {

                          });
                        },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,

                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black,
                            ),
                            child: Row(
                              children: [
                               Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      playStoreIcon,
                                      width: 25,
                                      height: 30,
                                    ),

                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "DISPONIBLE SUR",
                                      style:
                                      MontserratStyles.montserratRegularTextStyle(
                                        size: 10,
                                      ),
                                    ),
                                    Text(
                                      "Google Play",
                                      style:
                                      MontserratStyles.montserratSemiBoldTextStyle(
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ) ;},

      ),
    );
  }
}
