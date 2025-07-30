import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? subTitle;
  final VoidCallback? onBackPressed;
  final double height;
  final Color? backgroundColor;
  final Color circleColor;
  final Color titleColor;
  final Color iconColor;
  final TextStyle? textStyle;
  final bool? isBacked;
  final Widget? largeWidget;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.subTitle,
    this.onBackPressed,
    this.height = 100,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.circleColor = const Color(0xFF3A4B5C),
    this.titleColor = const Color(0xFF3A4B5C),
    this.iconColor = Colors.white,
    this.textStyle,
    this.isBacked,
    this.largeWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: height,
              width: double.infinity,
              color: backgroundColor ?? AppColor().backgroundColor,
            ),
            Positioned(
              left: -50,
              top: -60,
              bottom: 0,
              child: GestureDetector(
                onTap: onBackPressed ?? () {
                  if (isBacked != false) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: circleColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 25,
              left: 20,
              child: Image.asset(arrowBackIcon, height: 20, width: 20),
            ),
            Positioned(
              top: (largeWidget != null) ? 20 : 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end, // This ensures right alignment
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.end, // Added for extra right alignment
                    style: MontserratStyles.montserratMediumTextStyle(
                      color: AppColor().darkCharcoalBlueColor,
                      size: 20,
                    ) ??
                        TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                  ),
                  if (subTitle != null) ...[
                    vGap(5),
                    Text(
                      subTitle!,
                      textAlign: TextAlign.end, // Added for extra right alignment
                      style: MontserratStyles.montserratRegularTextStyle(
                        color: AppColor().darkCharcoalBlueColor,
                        size: 10,
                      ) ??
                          TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: titleColor,
                          ),
                    ),
                  ],
                  if (largeWidget != null) ...[
                    vGap(12),
                    largeWidget!
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}