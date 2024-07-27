import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';

class AddLicenseView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
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
              DropdownButtonFormField<String>(
                value: controller.issuingAuthority.value,
                decoration: const InputDecoration(
                  labelText: 'Issuing Authority',
                  border: OutlineInputBorder(),
                ),
                items: AppConstants.issuingAuthorities.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: SizedBox(
                        width: Get.width * .6,
                        child: Text(
                          value,
                          overflow: TextOverflow.ellipsis,
                        )),
                  );
                }).toList(),
                onChanged: (newValue) {
                  controller.issuingAuthority.value = newValue!;
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
                controller: controller.trackingNumberController,
                decoration: const InputDecoration(
                  labelText: 'Tracking Number',
                  border: OutlineInputBorder(),
                ),
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
              DropdownButtonFormField<String>(
                value: controller.caliber.value,
                decoration: const InputDecoration(
                  labelText: 'Caliber',
                  border: OutlineInputBorder(),
                ),
                items: AppConstants.caliber.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  controller.caliber.value = newValue!;
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
                  controller.dateOfIssuanceController.text = await datePicker();
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
              DropdownButtonFormField<String>(
                value: controller.jurisdiction.value,
                decoration: const InputDecoration(
                  labelText: 'Jurisdiction',
                  border: OutlineInputBorder(),
                ),
                items: AppConstants.jurisdictions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
              DropdownButtonFormField<String>(
                value: controller.issuaingQuota.value,
                decoration: const InputDecoration(
                  labelText: 'Issuance Quota',
                  border: OutlineInputBorder(),
                ),
                items: AppConstants.issuingQuota.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
                return controller.licensePicture.value == null
                    ? DarkButton(
                        onTap: () async {
                          String? path = await pickImage(controller.picker);
                          if (path != null && path.isNotEmpty) {
                            controller.licensePicture.value = File(path);
                          }
                        },
                        text: "Upload License Picture",
                      )
                    : Image.file(
                        controller.licensePicture.value!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      );
              }),
              10.height,
              DarkButton(
                onTap: controller.saveLicenseForm,
                text: "Submit",
              ),
              20.height
            ],
          ),
        ),
      ),
    );
  }
}
