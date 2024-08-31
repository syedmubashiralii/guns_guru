import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/models/model_make_model.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/source_selection_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controllers/home_controller.dart';

class AddWeaponDetail extends GetView<HomeController> {
  const AddWeaponDetail({super.key});

  @override
  Widget build(BuildContext context) {
    if (AppConstants.caliber.isEmpty ||
        AppConstants.make.isEmpty ||
        AppConstants.model.isEmpty || AppConstants.ammoBrand.isEmpty || AppConstants.typeofRounds.isEmpty) {
      Get.find<HomeExtensionController>().loadUtils();
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
                key: controller.weaponFormKey,
                child: ListView(children: [
                  10.height,
                  const Text(
                    "WEAPON DETAIL",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  20.height,
                  20.height,
                  TextFormField(
                    readOnly: true,
                    controller: controller.weaponPurchaseDate,
                    decoration: const InputDecoration(
                      labelText: 'Weapon Purchase Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.date_range),
                      hintText: 'DD/MM/YYYY',
                    ),
                    onTap: () async {
                      controller.weaponPurchaseDate.text =
                          await datePicker(lastDate: DateTime.now());
                    },
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Weapon purchase date is required';
                      }
                      RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                      if (!dateRegex.hasMatch(value)) {
                        return 'Please enter a valid date format: DD/MM/YYYY';
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
                    items: AppConstants.caliberList, // The list of caliber values
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Caliber',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    selectedItem: controller.weaponCaliber.value,
                    onChanged: (newValue) {
                      controller.weaponCaliber.value = newValue!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Weapon Caliber is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.authorizeDealerName,
                    decoration: const InputDecoration(
                      labelText: 'Authorize Dealer Name',
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Authorize dealer name is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.authorizeDealerAddress,
                    decoration: const InputDecoration(
                      labelText: 'Authorize Dealer Address',
                      border: OutlineInputBorder(),
                    ),
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Authorize dealer address is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  IntlPhoneField(
                    invalidNumberMessage: "Dealer Phone number is not valid".tr,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 14.0),
                      border: const OutlineInputBorder(),
                      hintText: "Authorize Dealer Phone Number".tr,
                      counterText: "",
                    ),
                    onChanged: (phone) {
                      controller.authorizeDealerPhoneNo.text =
                          phone.completeNumber;
                      try {
                        controller.isPhoneNumberValid.value =
                            phone.isValidNumber();
                      } catch (e) {
                        controller.isPhoneNumberValid.value = false;
                      }
                    },
                    onCountryChanged: (country) {
                      if (kDebugMode) {
                        print('Country changed to: ${country.name}');
                      }
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
                          labelText: 'Search Weapon Type',
                        ),
                      ),
                    ),
                    items: AppConstants
                        .weaponTypeList, // The list of weapon types to display
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Weapon Type',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    selectedItem: controller.weaponType.value,
                    onChanged: (newValue) {
                      controller.weaponType.value = newValue!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Weapon Type is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.weaponNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Weapon No',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Weapon No is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox:
                          true, // Enables the search box in the dropdown
                      searchFieldProps: const TextFieldProps(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Search Make',
                        ),
                      ),
                      itemBuilder: (context, item, isSelected) {
                        return ListTile(
                          title: SizedBox(
                            width: Get.width * .6,
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                    ),
                    items: AppConstants.make, // The list of makes to display
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Make',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    selectedItem: controller.weaponMake.value,
                    onChanged: (newValue) {
                      controller.weaponMake.value = newValue!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Weapon maker is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox:
                          true, // Enables the search box in the dropdown
                      searchFieldProps: const TextFieldProps(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Search Model',
                        ),
                      ),
                      itemBuilder: (context, item, isSelected) {
                        return ListTile(
                          title: SizedBox(
                            width: Get.width * .6,
                            child: Text(
                              item,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                    ),
                    items: AppConstants.model
                        .map((model) => model.model)
                        .toList(), // Extracting the model names
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: 'Model',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    selectedItem: controller.weaponModel.value,
                    onChanged: (newValue) {
                      controller.weaponModel.value = newValue!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Weapon model is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  Obx(() {
                    return InkWell(
                      onTap: () async {
                        String source = '';
                        await showChoiceDialog(onCameraTap: () {
                          source = "Camera";
                          Get.back();
                        }, onGalleryTap: () {
                          source = "Gallery";
                          Get.back();
                        });
                        if (source != '') {
                          String? path =
                              await pickImage(controller.picker, source);
                          if (path != null && path.isNotEmpty) {
                            controller.weaponPurchaseReceipt.value = File(path);
                          }
                        }
                      },
                      child: controller.weaponPurchaseReceipt.value == null
                          ? Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.add),
                                  Text(
                                      "Add Weapon Purchase Receipt (optional)"),
                                ],
                              ),
                            )
                          : Image.file(
                              controller.weaponPurchaseReceipt.value!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                    );
                  }),
                  40.height,
                  DarkButton(onTap: controller.saveWeaponDetail, text: "Add")
                ]))));
  }
}
