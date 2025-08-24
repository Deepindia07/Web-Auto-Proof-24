import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/presentation/screens/home/screens/home_screen_route_imple.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:flutter/material.dart';
import '../../../../utilities/custom_textstyle.dart';

class MyVehicleDetailsScreen extends StatefulWidget {
  final void Function(ScreenType type,) onScreenChange;
  const MyVehicleDetailsScreen({super.key, required this.onScreenChange});

  @override
  State<MyVehicleDetailsScreen> createState() => _MyVehicleDetailsScreenState();
}

class _MyVehicleDetailsScreenState extends State<MyVehicleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Dynamic padding and font scaling
    double horizontalPadding = screenWidth * 0.05;
    double titleFontSize = screenWidth * 0.02;
    double labelFontSize = screenWidth * 0.014;
    double valueFontSize = screenWidth * 0.014;

    return Scaffold(
      backgroundColor:  AppColor().backgroundColor,
      body: Center(
        child: Container(
          width: screenWidth > 900 ? 600 : screenWidth * 0.9,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding / 2,
            vertical: 20,
          ),
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Text(
                  "My Vehicle",
                  style: MontserratStyles.montserratBoldTextStyle(
                    size: 30,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(profileImageCopy),
                ),
                SizedBox(height: 10),
                Text(
                  'Dodege RAM',
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                    size: 20,
                  ),
                ),

                SizedBox(height: 20),
                buildRow(
                  "Number Plate",
                  "HR637352",
                  labelFontSize,
                  valueFontSize,
                ),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Brand", "i10", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Model", "2022", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Mileage", "00-000-00", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Gas Type:", "Diesel", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Gas Level", "1/2", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow(
                  "Tyre condition",
                  "Good",
                  labelFontSize,
                  valueFontSize,
                ),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Km/day Level", "60", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Extra Km", "23€", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Km/day Level", "1/2", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomButtonWeb(
                        text: "Previous",
                        onPressed: () {
                          widget.onScreenChange(ScreenType.myVehicle);

                        },
                        color: AppColor().darkCharcoalBlueColor,
                        textColor: AppColor().yellowWarmColor,
                        borderRadius: 7,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(
    String label,
    String value,
    double labelSize,
    double valueSize,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 16,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: MontserratStyles.montserratRegularTextStyle(
                size: 16,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
