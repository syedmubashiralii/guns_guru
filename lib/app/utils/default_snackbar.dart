import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultSnackbar {
  static void show(String title, String message,
      {Duration duration = const Duration(seconds: 6)}) {
    // Get.snackbar(title, message, duration: duration, backgroundColor: Colors.white, snackPosition: SnackPosition.TOP,
    //   colorText: Colors.black,
    //   margin: const EdgeInsets.all(10),
    //   borderRadius: 10,
    //   isDismissible: true,
    //   forwardAnimationCurve: Curves.easeOutBack,
    //   reverseAnimationCurve: Curves.easeInBack,
    //   animationDuration: const Duration(milliseconds: 500),
    //   icon: const Icon(Icons.info_outline, color: Colors.black,),
    //   shouldIconPulse: true,
    // );

      DelightToastBar(
              builder: (context) =>  ToastCard(
                leading: const Icon(
                  Icons.flutter_dash,
                  size: 28,
                ),
                title: Text(
                  message,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
              autoDismiss: true
            ).show(navigator!.context);
  }
}
