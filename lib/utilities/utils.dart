import 'package:auto_proof/constants/const_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils{
  static error(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      "",
      message,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 4),
      backgroundColor: AppColor().darkCharcoalBlueColor,
      borderRadius: 10,
      snackPosition: SnackPosition.BOTTOM,
      colorText: AppColor().darkYellowColor,
      titleText: const Text(
        "",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 2,
        ),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 17,
            height: 1.4),
      ),
    );
  }


}