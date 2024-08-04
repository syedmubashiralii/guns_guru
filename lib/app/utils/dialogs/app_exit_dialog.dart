import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void showExitDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Confirm Exit'),
      content: Text('Are you sure you want to exit the app?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Close the app
            Get.back(); // Close the dialog
            Future.delayed(Duration(milliseconds: 100), () {
              exit(0); // Exit the app
            });
          },
          child: Text('Exit'),
        ),
      ],
    ),
    barrierDismissible: false, // Prevent closing dialog by tapping outside
  );
}
