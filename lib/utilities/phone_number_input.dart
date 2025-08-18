import 'dart:developer';

import 'package:auto_proof/constants/const_color.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'custom_textstyle.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVerified;
  final VoidCallback onVerify;
  final double? borderRadius;
  final bool? visible;
  final ValueChanged<CountryCode>? onChanged;
  final Color? color;
  final BorderRadiusGeometry? borderRadiusGeometry;

  /// 👇 Add this
  final String? initialCountryCode;

  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.isVerified,
    required this.onVerify,
    this.borderRadius,
    this.visible,
    this.onChanged,
    this.color,
    this.borderRadiusGeometry,
    this.initialCountryCode, // 👈 Added
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 30),
        border: Border.all(color: AppColor().darkCharcoalBlueColor, width: 1),
        color: color ?? Colors.white,
      ),
      child: Row(
        children: [
          // Country Code Picker Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: color,
              border: Border(
                right: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              borderRadius: borderRadiusGeometry ??
                  const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
            ),
            child: CountryCodePicker(
              padding: EdgeInsets.zero,
              onChanged: onChanged,
              initialSelection: initialCountryCode ?? 'IN', // 👈 use dynamic value
              favorite: const ["+91", "IN"], // 👈 optional
              showCountryOnly: false,
              alignLeft: false,
              flagWidth: 20,
              textStyle: const TextStyle(fontSize: 14, color: Colors.black),
              searchDecoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchCountry,
                border: const OutlineInputBorder(),
              ),
            ),
          ),

          // Phone Number Input
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                border: InputBorder.none,
                hintStyle: MontserratStyles.montserratRegularTextStyle(
                  size: 13,
                  color: AppColor().silverShadeGrayColor,
                ),
                hintText: AppLocalizations.of(context)!.phoneNumber,
              ),
            ),
          ),

          // Verify Button
          Visibility(
            visible: visible ?? false,
            child: TextButton(
              onPressed: onVerify,
              child: Text(
                isVerified
                    ? AppLocalizations.of(context)!.verified
                    : AppLocalizations.of(context)!.verify,
                style: MontserratStyles.montserratMediumTextStyle(
                  color: isVerified
                      ? Colors.green
                      : AppColor().darkYellowColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

