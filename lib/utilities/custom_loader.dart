import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:flutter/material.dart';

import '../constants/const_color.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      borderRadius: BorderRadius.circular(8),
      padding: EdgeInsets.all(16),
      backgroundColor: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }

  static void showPopupLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: CustomContainer(
            borderRadius: BorderRadius.circular(12),
            padding: EdgeInsets.all(20),
            backgroundColor: Colors.white.withOpacity(0.9),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColor().darkYellowColor),
                    strokeWidth: 3,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.pleaseWait,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Static method to hide popup loader
  static void hidePopupLoader(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}