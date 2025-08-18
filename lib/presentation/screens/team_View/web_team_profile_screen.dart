import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:flutter/material.dart';

class MyTeamDetailsScreen extends StatelessWidget {
  const MyTeamDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Dynamic padding and font scaling
    double horizontalPadding = screenWidth * 0.05;
    double labelFontSize = screenWidth * 0.014;
    double valueFontSize = screenWidth * 0.014;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Center(
        child: Container(
          width: screenWidth > 900 ? 600 : screenWidth * 0.9,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding / 2,
            vertical: 20,
          ),

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Text(
                  "Team Profile",
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
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF9CA3AF),
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(
                        text:
                        'Name: ',
                        style:
                        MontserratStyles.montserratSemiBoldTextStyle(
                          color: AppColor().darkCharcoalBlueColor,
                          size: 20,
                        ),
                      ),
                      TextSpan(
                        text: "James Paul",
                        style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().darkCharcoalBlueColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                buildRow(
                  "Gmail:",
                  "preet@gmail.com",
                  labelFontSize,
                  valueFontSize,
                ),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Phone Number", "638364839", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Inspection", "39", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Upcoming", "3", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Completed", "69", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),
                buildRow("Ongoing", "6", labelFontSize, valueFontSize),
                Divider(color: AppColor().silverShadeGrayColor),

                SizedBox(height: 20),
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
