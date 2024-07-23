import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/add_ammunition_controller.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/home_controller.dart';

class AddAmmunitionStockView extends GetView<AddAmmunitionController> {
  const AddAmmunitionStockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Image.asset(
            "assets/images/guns-guru.png",
            height: 40,
          ),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: ColorHelper.primaryColor,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: controller.ammunitionStockFormKey,
                child: ListView(children: [
                  10.height,
                  const Text(
                    "WEAPON DETAIL",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.purchaseDateController,
                    decoration: const InputDecoration(
                        labelText: 'Purchase Date',
                        border: OutlineInputBorder(),
                        hintText: 'DD/MM/YYYY'),
                        keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Purchase Date is required';
                      }
                      RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                      if (!dateRegex.hasMatch(value)) {
                        return 'Please enter a valid date format: DD/MM/YYYY';
                      }
                      List<String> parts = value.split('/');
                      if (parts.length != 3 ||
                          parts.any((part) => !isNumeric(part))) {
                        return 'Date must be in numeric format: DD/MM/YYYY';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.purchasedFromController,
                    decoration: const InputDecoration(
                        labelText: 'Purchased From',
                        border: OutlineInputBorder(),
                        hintText: 'DD/MM/YYYY'),
                         keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Purchased From is required';
                      }

                      RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                      if (!dateRegex.hasMatch(value)) {
                        return 'Please enter a valid date format: DD/MM/YYYY';
                      }
                      List<String> parts = value.split('/');
                      if (parts.length != 3 ||
                          parts.any((part) => !isNumeric(part))) {
                        return 'Date must be in numeric format: DD/MM/YYYY';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.brandController,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Brand is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.caliberController,
                    decoration: const InputDecoration(
                      labelText: 'Caliber',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Caliber is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.quantityPurchasedController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity Purchased',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Quantity Purchased is required';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Quantity Purchased must be a number';
                      }
                      return null;
                    },
                  ),
                  40.height,
                  DarkButton(onTap: controller.addAmmunitionStock, text: "Add")
                ]))));
  }
}
