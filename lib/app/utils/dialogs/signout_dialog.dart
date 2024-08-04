import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';

void showSignOutDialog() {
  Get.dialog(
    AlertDialog(
      title: Text('Confirm Sign Out'),
      content: Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Get.find<HomeController>().signOut(); // Call the sign-out method
            Get.back(); // Close the dialog
          },
          child: Text('Sign Out'),
        ),
      ],
    ),
    barrierDismissible: false, // Prevent closing dialog by tapping outside
  );
}
