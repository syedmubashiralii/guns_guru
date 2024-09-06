import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/source_selection_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddAmmunitionStockView extends GetView<WeaponController> {
  const AddAmmunitionStockView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeaponController weaponController = Get.find();
    if (AppConstants.isPakistani) {
      // final license = licenseController
      //     .licenseList?[licenseController.selectedLicenseIndex.value];
    }


    if (AppConstants.caliber.isEmpty ||
        AppConstants.make.isEmpty ||
        AppConstants.model.isEmpty ||
        AppConstants.ammoBrand.isEmpty ||
        AppConstants.typeofRounds.isEmpty) {
      controller.loadUtils();
    }
    if (weaponController.weaponDetails.value != null) {
      controller.ammoCaliber.value =
          controller.weaponDetails.value?.weaponCaliber ?? "";
      controller.weaponNo.value =
          controller.weaponDetails.value?.weaponNo ?? "";
      controller.weaponuid.value = controller.weaponDetails.value?.uid ?? "";
      controller.retailerNameController.text =
          controller.weaponDetails.value?.weaponauthorizedealername ?? "";
      controller.retailerPhoneNo.text =
          controller.weaponDetails.value?.weaponauthorizedealerphonenumber ??
              "";
    } else {
      controller.ammoCaliber.value =
          controller.weaponList[0].weaponCaliber ?? "";
      controller.weaponNo.value = controller.weaponList[0].weaponNo ?? "";
      controller.weaponuid.value = controller.weaponList[0].uid ?? "";
      controller.retailerNameController.text =
          controller.weaponList[0].weaponauthorizedealername ?? "";
      controller.retailerPhoneNo.text =
          controller.weaponList[0].weaponauthorizedealerphonenumber ?? "";
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset("assets/images/guns-guru.png", height: 40),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorHelper.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.ammunitionStockFormKey,
          child: ListView(
            children: [
              _buildHeader(),
              Obx(
                 () {
                  return _buildDropdown(
                    label: 'Weapon No',
                    items: weaponController.weaponList.value
                            .map((weapon) => weapon.weaponNo ?? "")
                            .toList() ??
                        [],
                    selectedItem: controller.weaponNo.value,
                    onChanged: (value) {
                      controller.weaponNo.value = value ?? "";
                      final selectedWeapon = weaponController.weaponList.value
                          .firstWhere((weapon) => weapon.weaponNo == value,
                              orElse: () => WeaponDetails());
                      controller.ammoCaliber.value =
                          selectedWeapon.weaponCaliber ?? "";
                      controller.weaponuid.value = selectedWeapon.uid ?? "";
                    },
                    validatorMessage: 'Weapon No is required',
                  );
                }
              ),
              _buildDateField(),
              _buildRetailerNameField(),
              20.height,
              IntlPhoneField(
                invalidNumberMessage: "Retailer Phone number is not valid".tr,
                initialValue: controller.retailerPhoneNo.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
                  border: const OutlineInputBorder(),
                  hintText: "Retailer Phone Number".tr,
                  counterText: "",
                ),
                onChanged: (phone) {
                  controller.retailerPhoneNo.text = phone.completeNumber;
                  try {} catch (e) {}
                },
                onCountryChanged: (country) {
                  if (kDebugMode) {
                    print('Country changed to: ${country.name}');
                  }
                },
              ),
              20.height,
              Obx(() {
                return TextFormField(
                  initialValue: controller.ammoCaliber.value,
                  decoration: const InputDecoration(
                    labelText: 'Ammo Calliber',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                );
              }),
              _buildDropdown(
                label: 'Type of Round',
                items: AppConstants.typeofRounds,
                selectedItem: controller.typeOfRound.value,
                onChanged: (value) => controller.typeOfRound.value = value!,
                validatorMessage: 'Type of Round is required',
              ),
              _buildDropdown(
                label: 'Ammo Brand',
                items: AppConstants.ammoBrand,
                selectedItem: controller.ammoBrand.value,
                onChanged: (value) => controller.ammoBrand.value = value!,
                validatorMessage: 'Ammo Brand is required',
              ),
              _buildTextField(
                controller: controller.quantityPurchasedController,
                label: 'Quantity Purchased',
                keyboardType: TextInputType.number,
                validatorMessage:
                    'Quantity Purchased is required and must be a number',
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
                        controller.ammoPurchaseReceipt.value = File(path);
                      }
                    }
                  },
                  child: controller.ammoPurchaseReceipt.value == null
                      ? Container(
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text("Add Weapon Purchase Receipt (optional)"),
                            ],
                          ),
                        )
                      : Image.file(
                          controller.ammoPurchaseReceipt.value!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                );
              }),
              const SizedBox(height: 40),
              DarkButton(
                onTap: controller.addAmmunition,
                text: "Add Stock",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        "ADD AMMUNITION STOCK",
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: controller.purchaseDateController,
        decoration: const InputDecoration(
          labelText: 'Purchase Date',
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
          hintText: 'DD/MM/YYYY',
        ),
        keyboardType: TextInputType.datetime,
        readOnly: true,
        onTap: _selectDate,
        validator: _validateDate,
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      controller.purchaseDateController.text =
          "${pickedDate.day < 10 ? '0${pickedDate.day}' : pickedDate.day}/${pickedDate.month < 10 ? '0${pickedDate.month}' : pickedDate.month}/${pickedDate.year}";
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) return 'Purchase Date is required';
    RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateRegex.hasMatch(value)) {
      return 'Please enter a valid date format: DD/MM/YYYY';
    }
    List<String> parts = value.split('/');
    if (parts.length != 3 || parts.any((part) => !isNumeric(part))) {
      return 'Date must be in numeric format: DD/MM/YYYY';
    }
    return null;
  }

  Widget _buildRetailerNameField() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: controller.retailerNameController,
        decoration: const InputDecoration(
          labelText: 'Retailer Name',
          border: OutlineInputBorder(),
          hintText: 'Retailer Name',
        ),
        keyboardType: TextInputType.name,
        inputFormatters: [UpperCaseTextFormatter()],
        validator: (value) =>
            value == null || value.isEmpty ? 'Retailer Name is required' : null,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> items,
    required String? selectedItem,
    required ValueChanged<String?> onChanged,
    required String validatorMessage,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Search $label',
            ),
          ),
        ),
        items: items,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
        ),
        selectedItem: selectedItem,
        onChanged: onChanged,
        validator: (value) => value == null ? validatorMessage : null,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool readOnly = false,
    TextInputType keyboardType = TextInputType.text,
    required String validatorMessage,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorMessage;
          }
          if (keyboardType == TextInputType.number &&
              !RegExp(r'^[0-9]+$').hasMatch(value)) {
            return validatorMessage;
          }
          return null;
        },
      ),
    );
  }
}
