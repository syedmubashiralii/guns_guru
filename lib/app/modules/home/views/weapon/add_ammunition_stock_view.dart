import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';

import '../../controllers/home_controller.dart';

class AddAmmunitionStockView extends GetView<HomeExtensionController> {
  const AddAmmunitionStockView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.caliberController.text=controller.homeController.userModel.value
                .license![controller.homeController.selectedLicenseIndex.value].weaponDetails?.weaponCaliber??"";
     if (AppConstants.caliber.isEmpty ||
        AppConstants.make.isEmpty ||
        AppConstants.model.isEmpty || AppConstants.ammoBrand.isEmpty || AppConstants.typeofRounds.isEmpty) {
      controller.loadUtils();
    }            
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
                    "ADD AMMUNITION STOCK",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.purchaseDateController,
                    decoration: const InputDecoration(
                        labelText: 'Purchase Date',
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                        hintText: 'DD/MM/YYYY'),
                    keyboardType: TextInputType.datetime,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        controller.purchaseDateController.text =
                            "${pickedDate.day < 10 ? '0${pickedDate.day}' : pickedDate.day}/${pickedDate.month < 10 ? '0${pickedDate.month}' : pickedDate.month}/${pickedDate.year}";
                      }
                    },
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
                        hintText: 'Purchased From'),
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Purchased From is required';
                      }

                      return null;
                    },
                  ),
                  20.height,
                  
                  DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSearchBox:
                          true, // Enables the search box in the dropdown
                      searchFieldProps: const TextFieldProps(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Search Caliber',
                        ),
                      ),
                    ),
                    items: AppConstants.ammoBrand, // The list of caliber values
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Caliber',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    selectedItem: controller.ammoBrand.value,
                    onChanged: (newValue) {
                      controller.ammoBrand.value = newValue!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Ammo Brand is required';
                      }
                      return null;
                    },
                  ),
                   20.height,
                  
                  DropdownSearch<String>(
                    popupProps: const PopupProps.menu(
                      showSearchBox:
                          true, // Enables the search box in the dropdown
                      searchFieldProps: const TextFieldProps(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Type of Round',
                        ),
                      ),
                    ),
                    items: AppConstants.typeofRounds, // The list of caliber values
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Type of Round',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    selectedItem: controller.typeOfRound.value,
                    onChanged: (newValue) {
                      controller.typeOfRound.value = newValue!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Type of Round is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                   TextFormField(
                    controller: controller.caliberController,
                    readOnly: true,
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
                  10.height,
                  Text(
                      "Note: Your Remaining Quota is ${calculateRemainingQuota(controller.homeController.userModel.value.license![controller.homeController.selectedLicenseIndex.value].ammunitionDetail ?? [], int.parse(controller.homeController.userModel.value.license![controller.homeController.selectedLicenseIndex.value].licenseAmmunitionLimit ?? '0'))}"),
                  40.height,
                  DarkButton(
                    onTap: controller.addAmmunitionStock, text: "Add")
                ]))));
  }
}
