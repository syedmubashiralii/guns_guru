import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultSnackbar{
  static void show(String title, String message, {Duration duration = const Duration(seconds: 6)}){
    Get.snackbar(title, message.replaceAll("Striga", "Crypto").replaceAll("Plaid", "Open Banking"), duration: duration, backgroundColor: Colors.white, snackPosition: SnackPosition.TOP,
      colorText: Colors.black,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      animationDuration: const Duration(milliseconds: 500),
      icon: const Icon(Icons.info_outline, color: Colors.black,),
      shouldIconPulse: true,
    );
  }
}