import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';

import '../../controllers/home_controller.dart';

class AddWeaponDetail extends GetView<HomeController> {
  const AddWeaponDetail({super.key});

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
                key: controller.weaponFormKey,
                child: ListView(children: [
                  10.height,
                  const Text(
                    "WEAPON DETAIL",
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  20.height,
                  DropdownButtonFormField<String>(
                    value: controller.weaponCaliber.value,
                    decoration: const InputDecoration(
                      labelText: 'Caliber',
                      border: OutlineInputBorder(),
                    ),
                    items: AppConstants.caliber.map((String value) {
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
                      controller.weaponCaliber.value = newValue!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Weapon caliber is required';
                      }
                      return null;
                    },
                  ),
                  20.height,
                  TextFormField(
                    controller: controller.weaponTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Type is required';
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
                  DropdownButtonFormField<String>(
                    value: controller.weaponMake.value,
                    decoration: const InputDecoration(
                      labelText: 'Make',
                      border: OutlineInputBorder(),
                    ),
                    items: AppConstants.make.map((String value) {
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
                  DropdownButtonFormField<String>(
                    value: controller.weaponModel.value,
                    decoration: const InputDecoration(
                      labelText: 'Model',
                      border: OutlineInputBorder(),
                    ),
                    items: AppConstants.model.map((String value) {
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
                      controller.weaponModel.value = newValue!;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Weapon model is required';
                      }
                      return null;
                    },
                  ),
                  40.height,
                  DarkButton(onTap: controller.saveWeaponDetail, text: "Add")
                ]))));
  }
}
