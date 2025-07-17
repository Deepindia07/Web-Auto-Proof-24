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
    this.isBacked
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              top: -40,
              bottom: 0,
              child: Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 20,
              child: GestureDetector(
                onTap: onBackPressed ?? () =>(isBacked)??Navigator.pop(context),
                child: Image.asset(arrowBackIcon,height: 30,width: 30,)
              ),
            ),
            Positioned(
              top: 45,
              right: 20,
              child: Column(
                children: [
                  Text(
                    title,
                    style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 20)??TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: titleColor,
                    ),
                  ),
                  if(subTitle !=null)
                  Column(
                    children: [
                      vGap(5),
                      Text(
                        subTitle!,
                        style: MontserratStyles.montserratRegularTextStyle(color: AppColor().darkCharcoalBlueColor,size: 10)??TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
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
    );
  }
}