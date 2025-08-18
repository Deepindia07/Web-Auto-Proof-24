import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../constants/const_color.dart';
import 'custom_textstyle.dart';
import 'custom_widgets.dart';

class UpperContainerWidget extends StatelessWidget {
  final double height ;
  const UpperContainerWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return   Container(
      width: double.infinity,

      padding: const EdgeInsets.only(left: 30,right: 30,bottom: 20),
      decoration: BoxDecoration(
        color: AppColor().darkCharcoalBlueColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(48),
          bottomLeft: Radius.circular(48),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          const Text(
            '...',
            style: TextStyle(
              fontSize: 42,
              color: Color(0xFFF9C529), // Yellow color
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: false,
              applyHeightToLastDescent: false,
            ),
            text: TextSpan(
              children: [
                // TextSpan(
                //   text: AppLocalizations.of(context)!.lets,
                //   style:
                //   MontserratStyles.montserratSemiBoldTextStyle(
                //     color: AppColor().yellowWarmColor,
                //     size: 45,
                //   ).copyWith(
                //     height: 1.0,
                //     letterSpacing: -1.3,
                //   ),
                // ),
                TextSpan(
                  text: AppLocalizations.of(context)!.createYourAccount,
                  style:
                  MontserratStyles.montserratLitleBoldTextStyle(
                    color: AppColor().yellowWarmColor,
                    size: 35,
                  ).copyWith(
                    height: 1.0,
                    letterSpacing: -1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


