import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/presentation/custom_widget/loading_widget.dart';

class Util {
  static void showSnackBar(
    String content, {
    String title = 'Notification',
    Widget? icon,
    Color? textColor,
    Duration? duration,
    SnackPosition? position,
    Color? backgroundColor,
  }) {
    Get.snackbar(
      title,
      content,
      colorText: textColor,
      duration: duration ?? const Duration(seconds: 3),
      snackPosition: position,
      icon: icon,
      backgroundColor: backgroundColor,
    );
  }

  static void showLoading() {
    Get.dialog(
      const Center(child: LoadingWidget()),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    Get.back();
  }
}
