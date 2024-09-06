import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/service_record_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/widgets/shooter_record_widgets.dart';
import 'package:guns_guru/app/modules/home/widgets/weapon_detail_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/custom_radio_button.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddWeaponServiceRecord extends GetView<ServiceRecordController> {
  // LicenseController licenseController = Get.find();
  WeaponController weaponController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (controller.homeController.fromServiceDetail.isFalse) {
      if (weaponController.weaponList.isEmpty) {
        controller.weaponNo.value =
            weaponController.weaponList[0].weaponNo ?? "";
        controller.weaponuid.value = weaponController.weaponList[0].uid ?? "";
      }
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerCard(
              title: 'SERVICE RECORD',
              content: Form(
                key: controller.serviceRecordKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return CustomDropdownField(
                        label: 'Weapon No',
                        selectedValue: controller.weaponNo.value,
                        items: weaponController.weaponList.value
                                .map((weapon) => weapon.weaponNo ?? "")
                                .toList() ??
                            [],
                        onChanged: (String? value) {
                          controller.weaponNo.value = value ?? "";
                          final selectedWeapon = weaponController
                              .weaponList.value
                              .firstWhere((weapon) => weapon.weaponNo == value,
                                  orElse: () => WeaponDetails());
                          controller.weaponuid.value = selectedWeapon.uid ?? "";
                        },
                        isMandatory: true,
                        isEnabled:
                            !controller.homeController.fromServiceDetail.value,
                      );
                    }),
                    20.height,
                    TextFormField(
                      onTap: controller.homeController.fromServiceDetail.isTrue
                          ? () {}
                          : () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                controller.serviceDateController.text =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              }
                            },
                      readOnly: true,
                      controller: controller.serviceDateController,
                      decoration: const InputDecoration(
                          labelText: 'Date',
                          suffixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a date';
                        }
                        return null;
                      },
                    ),

                    10.height,
                    // Radio buttons for service type
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Service Type",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomRadioButton(
                                  firePin1: controller.isBasicService.value,
                                  onChanged: (value) {
                                    controller.isBasicService.value = true;
                                  },
                                  title: 'Basic Service',
                                ),
                              ),
                              Expanded(
                                child: CustomRadioButton(
                                  firePin1: !controller.isBasicService.value,
                                  onChanged: (value) {
                                    controller.isBasicService.value = false;
                                  },
                                  title: 'Detailed Service',
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    10.height,
                    // Radio buttons for service provider
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Service Provider",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomRadioButton(
                                  firePin1: controller.isSelfService.value,
                                  onChanged: (value) {
                                    controller.isSelfService.value = true;
                                  },
                                  title: 'Self Service',
                                ),
                              ),
                              Expanded(
                                child: CustomRadioButton(
                                  firePin1: !controller.isSelfService.value,
                                  onChanged: (value) {
                                    controller.isSelfService.value = false;
                                  },
                                  title: 'Armor Service',
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: !controller.isSelfService.value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                20.height,
                                TextFormField(
                                  controller: controller.armorNameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Armor Name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter armor name';
                                    }
                                    return null;
                                  },
                                ),
                                20.height,
                                TextFormField(
                                  controller: controller.armorAddressController,
                                  decoration: const InputDecoration(
                                    labelText: 'Armor Address',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter armor address';
                                    }
                                    return null;
                                  },
                                ),

                                //armor phone number
                                20.height,
                                IntlPhoneField(
                                  initialCountryCode: "+92",
                                  
                                  invalidNumberMessage:
                                      "Dealer Phone number is not valid".tr,
                                  initialValue:
                                      controller.armorPhoneNoController.text,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14.0),
                                    border: const OutlineInputBorder(),
                                    hintText:
                                        "Armor Phone Number".tr,
                                    counterText: "",
                                  ),
                                  onChanged: (phone) {
                                    controller.armorPhoneNoController.text =
                                        phone.completeNumber;
                                  },
                                  onCountryChanged: (country) {
                                    if (kDebugMode) {
                                      print(
                                          'Country changed to: ${country.name}');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    20.height,
                    TextFormField(
                      readOnly:
                          controller.homeController.fromServiceDetail.value,
                      controller: controller.serviceNotesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes (optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    20.height,
                    PartsChangedSection(),
                    20.height,
                    Visibility(
                      visible:
                          controller.homeController.fromServiceDetail.isFalse,
                      child: DarkButton(
                        onTap: () {
                          if (controller.weaponNo.isEmpty) {
                            DefaultSnackbar.show(
                                "Error", "Please select weapon");
                            return;
                          }
                          controller.addServiceRecord();
                        },
                        text: 'Add Record',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartsChangedSection extends GetView<ServiceRecordController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Any Parts Changed?",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Wrap(
          children: AppConstants.weaponParts.map((part) {
            return Obx(() {
              return CustomRadioButton(
                firePin1:
                    controller.servicePartsChangedList.value.contains(part)
                        ? true
                        : false,
                onChanged: controller.homeController.fromServiceDetail.isTrue
                    ? (v) {}
                    : (v) {
                        if (v == true) {
                          controller.servicePartsChangedList.add(part);
                        } else {
                          controller.servicePartsChangedList.remove(part);
                        }
                      },
                title: part,
              );
            });
          }).toList(),
        ),
      ],
    );
  }
}
