import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String title, String message, final backgroundColor) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor,
    colorText: Colors.white,
  );
}
