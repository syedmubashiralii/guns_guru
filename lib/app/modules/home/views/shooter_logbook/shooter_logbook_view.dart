import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/weapon/add_weapon_firing_record.dart';
import 'package:guns_guru/app/modules/home/views/weapon/weapon_logbook_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';

class ShooterLogbookView extends GetView<ShootingLogController> {
  ShooterLogbookView({super.key});
  final ShootingLogController controller = Get.put(ShootingLogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          "assets/images/guns-guru.png",
          height: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildShooterLogSection(controller),
      ),
    );
  }

  Widget _buildShooterLogSection(ShootingLogController shootingLogController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ALL SHOOTER LOGS",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 17),
        ),
        const SizedBox(height: 10),
        BannerCard(
          title: 'SHOOTER LOGS',
          isAddRecord: false,
          onTap: () {
            controller.homeController.fromFiringRecordDetail.value = false;
            Get.to(AddWeaponFiringRecord());
          },
          content: Obx(() {
            return Column(
              children: [
                if (shootingLogController.shooterLogList.value.isEmpty)
                  const Text("No record found"),
                if (shootingLogController.shooterLogList.value.isNotEmpty)
                  for (WeaponFiringRecord record
                      in shootingLogController.shooterLogList.value)
                    InkWell(
                      onTap: () {
                        controller.homeController.fromFiringRecordDetail.value =
                            true;
                        shootingLogController.populateFieldsForEditing(record);
                        Get.to(AddWeaponFiringRecord());
                      },
                      child: BuildFiringRecord(
                        date: record.date ?? "",
                        location: record.rangeNameLocation ?? "",
                        shotsFired: record.roundsFired ?? "",
                      ),
                    ),
              ],
            );
          }),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: Get.width,
          child: DarkButton(
            onTap: () async {
              
              controller.homeController.fromFiringRecordDetail.value = false;
              shootingLogController.clearAllFields();
              Get.to(AddWeaponFiringRecord());
            },
            text: "Add Record",
          ),
        ),
      ],
    );
  }
}
