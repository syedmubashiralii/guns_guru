import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/source_selection_dialog.dart';

class AddLicenseView extends GetView<HomeController> {
  AddLicenseView({this.fromEditing});
  bool? fromEditing;
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
        backgroundColor: ColorHelper.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Add License Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.licenseFormKey,
          child: ListView(
            children: [
              10.height,
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSearchBox: true, // Enables the search box in the dropdown
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search Issuing Authority',
                    ),
                  ),
                ),
                items: AppConstants
                    .issuingAuthorities, // The list of issuing authorities
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Issuing Authority',
                    border: OutlineInputBorder(),
                  ),
                ),
                selectedItem: controller.issuingAuthority.value,
                onChanged: (newValue) {
                  controller.issuingAuthority.value = newValue!;
                },
                dropdownBuilder: (context, selectedItem) => SizedBox(
                  width: Get.width * .6,
                  child: Text(
                    selectedItem ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Issuing Authority is required';
                  }
                  return null;
                },
              ),
              20.height,
              TextFormField(
                controller: controller.trackingNumberController,
                decoration: const InputDecoration(
                  labelText: 'Tracking Number',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tracking Number is required';
                  }
                  return null;
                },
              ),
              20.height,
              TextFormField(
                controller: controller.licenseNumberController,
                decoration: const InputDecoration(
                  labelText: 'License Number',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'License Number is required';
                  }
                  return null;
                },
              ),
              20.height,
              TextFormField(
                controller: controller.ammunitionLimitController,
                decoration: const InputDecoration(
                  labelText: 'Ammunition Limit',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ammunition Limit is required';
                  }
                  if (!isNumericInt(value)) {
                    return 'Ammunition Limit must numeric Value';
                  }
                  return null;
                },
              ),
              20.height,
              // DropdownButtonFormField<String>(
              //   value: controller.caliber.value,
              //   decoration: const InputDecoration(
              //     labelText: 'Caliber',
              //     border: OutlineInputBorder(),
              //   ),
              //   items: AppConstants.caliber.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value),
              //     );
              //   }).toList(),
              //   onChanged: (newValue) {
              //     controller.caliber.value = newValue!;
              //   },
              //   validator: (value) {
              //     if (value == null) {
              //       return 'Weapon Type is required';
              //     }
              //     return null;
              //   },
              // ),
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSearchBox: true, // Enables the search box in the dropdown
                  searchFieldProps: TextFieldProps(
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
                selectedItem: controller.licenseWeaponType.value,
                onChanged: (newValue) {
                  controller.licenseWeaponType.value = newValue!;
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
                controller: controller.dateOfIssuanceController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Date of Issuance',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.date_range),
                  hintText: 'DD/MM/YYYY',
                ),
                onTap: () async {
                  controller.dateOfIssuanceController.text =
                      await datePicker(lastDate: DateTime.now());
                },
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date of Issuance is required';
                  }
                  RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                  if (!dateRegex.hasMatch(value)) {
                    return 'Please enter a valid date format: DD/MM/YYYY';
                  }
                  return null;
                },
              ),
              20.height,
              TextFormField(
                readOnly: true,
                controller: controller.validTillController,
                decoration: const InputDecoration(
                  labelText: 'Valid Till',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.date_range),
                  hintText: 'DD/MM/YYYY',
                ),
                onTap: () async {
                  controller.validTillController.text = await datePicker();
                },
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Valid Till is required';
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
                  showSearchBox: true, // Enables the search box in the dropdown
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search Jurisdiction',
                    ),
                  ),
                ),
                items: AppConstants
                    .jurisdictions, // The list of jurisdictions to display
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Jurisdiction',
                    border: OutlineInputBorder(),
                  ),
                ),
                selectedItem: controller.jurisdiction.value,
                onChanged: (newValue) {
                  controller.jurisdiction.value = newValue!;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Jurisdiction is required';
                  }
                  return null;
                },
              ),
              20.height,
              DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSearchBox: true, // Enables the search box in the dropdown
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search Issuance Quota',
                    ),
                  ),
                ),
                items: AppConstants
                    .issuingQuota, // The list of issuance quotas to display
                dropdownDecoratorProps: const DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: 'Issuance Quota',
                    border: OutlineInputBorder(),
                  ),
                ),
                selectedItem: controller.issuaingQuota.value,
                onChanged: (newValue) {
                  controller.issuaingQuota.value = newValue!;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Issuance Quota is required';
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
                      String? path = await pickImage(controller.picker, source);
                      if (path != null && path.isNotEmpty) {
                        controller.licensePicture.value = File(path);
                      }
                    }
                  },
                  child: controller.licensePicture.value == null
                      ? Container(
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text("Add license Picture"),
                            ],
                          ),
                        )
                      : Image.file(
                          controller.licensePicture.value!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                );
              }),
              10.height,
              DarkButton(
                onTap: () => controller
                    .saveLicenseForm(fromEditing == true ? true : false),
                text: fromEditing == true ? "Edit" : "Submit",
              ),
              20.height
            ],
          ),
        ),  
      ),
    );
  }
}
