import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/weapon/add_ammunition_stock_view.dart';

void showAddAmmoDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents the dialog from being dismissed by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: const Text(
          'Ammunition Stock Missing',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        content: const Text(
          'You didn\'t add any ammo stock yet. Do you want to add it now? Adding ammo will allow you to add a shooter service log.',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
               Navigator.of(context).pop(); 
              Get.to(const AddAmmunitionStockView()); // Navigate to ammo adding screen
            },
            child: Text(
              'Add Ammo',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.pop(context); // Navigate back
            },
            child: const Text(
              'Cancel',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
