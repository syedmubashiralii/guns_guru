import 'package:flutter/material.dart';
import 'package:guns_guru/app/utils/app_colors.dart';

void showUserDetailsDialog(BuildContext context,VoidCallback onProceed,{String? text}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Complete Your Profile"),
        content:  Text(text??"Please fill in your details to avail the services!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(ColorHelper.primaryColor),
              foregroundColor: WidgetStatePropertyAll(Colors.white)
              // shape: WidgetStatePropertyAll(rectange)

            ),
            onPressed: () {
              Navigator.of(context).pop();
              onProceed();
            },
            child: const Text("Proceed"),
          ),
        ],
      );
    },
  );
}
