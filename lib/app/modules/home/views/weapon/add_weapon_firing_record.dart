import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/widgets/weapon_detail_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';

class AddWeaponFiringRecord extends GetView<HomeExtensionController> {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weapon Firing Record',
                style: TextStyle(fontWeight: FontWeight.w500)),
            10.height,
            WeaponDetailWidget(
              license: controller.homeController.userModel.value.license![
                  controller.homeController.selectedLicenseIndex.value],
              isButtonShown: false,
            ),
            20.height,
            BannerCard(
              title: 'FIRING RECORD',
              content: Form(
                key: controller.firingRecordKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onTap: controller
                              .homeController.fromFiringRecordDetail.isTrue
                          ? () {}
                          : () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                controller.firingDateController.text =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              }
                            },
                      readOnly: true,
                      controller: controller.firingDateController,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a date';
                        }
                        return null;
                      },
                    ),
                    20.height,
                    TextFormField(
                      readOnly: controller
                          .homeController.fromFiringRecordDetail.value,
                      controller: controller.firingLocationController,
                      decoration: const InputDecoration(
                        labelText: 'Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a location';
                        }
                        return null;
                      },
                    ),
                    20.height,
                    TextFormField(
                      readOnly: controller
                          .homeController.fromFiringRecordDetail.value,
                      controller: controller.firingShotsFiredController,
                      decoration: const InputDecoration(
                        labelText: 'Shots Fired?',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter shots fired';
                        }
                        return null;
                      },
                    ),
                    20.height,
                    TextFormField(
                      readOnly: controller
                          .homeController.fromFiringRecordDetail.value,
                      controller: controller.firingNotesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes (optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    10.height,
                    Text(
                      "Note: Your Remaining Firing Stock is  ${calculateAmmunitionStock(controller
                                          .homeController
                                          .userModel
                                          .value
                                          .license![controller.homeController
                                              .selectedLicenseIndex.value]
                                          .ammunitionDetail ??
                                      []) -
                                  calculateShotsFired(controller
                                          .homeController
                                          .userModel
                                          .value
                                          .license![controller.homeController
                                              .selectedLicenseIndex.value]
                                          .weaponFiringRecord ??
                                      [])}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 13,
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    20.height,
                    Visibility(
                      visible: controller
                          .homeController.fromFiringRecordDetail.isFalse,
                      child: DarkButton(
                          onTap: controller.addWeaponFiringRecord,
                          text: 'Add Record'),
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
