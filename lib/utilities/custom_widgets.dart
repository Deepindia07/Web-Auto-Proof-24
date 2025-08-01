import "dart:io";

import "package:auto_proof/constants/const_color.dart";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

Widget vGap(double? height){
  return SizedBox(height: height,);
}

Widget hGap(double? width){
  return SizedBox(width: width);
}


/// Network status checker
class NetworkHelper {
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}


Future<void> redirectToWebPage(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2) return email;

  final username = parts[0];
  final domain = parts[1];

  String maskedUser;
  if (username.length <= 5) {
    maskedUser = username[0] + '*' * (username.length - 1);
  } else {
    maskedUser =
        username.substring(0, 5) +
            '*' * (username.length - 5) +
            username.substring(username.length - 2);
  }

  return '$maskedUser@$domain';
}

String maskPhoneNumber(String phone) {
  if (phone.length < 2) return phone;
  final visiblePart = phone.substring(phone.length - 2);
  final masked = '*' * (phone.length - 2);
  return '$masked$visiblePart';
}


Widget universalNull(){
  return Column(
    spacing: 10,
    children: [
      Image.asset("assets/icon/null_data.png",height: 40,width: 40,color: AppColor().silverShadeGrayColor,),
      Text("No data available!")
    ],
  );
}