import "dart:io";

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
