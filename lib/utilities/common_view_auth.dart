import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';

import '../constants/const_image.dart';

class CommonViewAuth extends StatelessWidget {
  const CommonViewAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          topRight: Radius.circular(20),
        ),

        color: AppColor().newBgColor,
      ),

      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(loginAutoLogoImage, height: 280, width: 300),
            const SizedBox(height: 40),

            Text(
              AppLocalizations.of(context)!.createAccountNow,
              style: MontserratStyles.montserratBoldTextStyle(
                size: 28,
                color: AppColor().darkCharcoalBlueColor,
              ),
              textAlign: TextAlign.center,
            ),
            vGap(10),
            Text(
              AppLocalizations.of(context)!.staticTitle,

              style: MontserratStyles.montserratBoldTextStyle(
                size: 20,
                color: AppColor().darkCharcoalBlueColor,
              ),
              textAlign: TextAlign.center,
            ),

            vGap(15),
            Text(
              "${AppLocalizations.of(context)!.subTitleText1} \n ${AppLocalizations.of(context)!.subTitleText2}",
              style: MontserratStyles.montserratRegularTextStyle(
                size: 12,
                color: AppColor().darkCharcoalBlueColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
