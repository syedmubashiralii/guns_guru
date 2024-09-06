import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/shooter_logbook/add_shooter_log.dart';
import 'package:guns_guru/app/modules/home/views/weapon/weapon_logbook_view.dart';
import 'package:guns_guru/app/modules/home/widgets/build_firing_record.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';

class ShooterLogbookView extends GetView<ShootingLogController> {
  ShooterLogbookView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getShooterLogs();
    Get.find<WeaponController>().loadAmmos();
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
       
        BannerCard(
          title: 'SHOOTER LOGS',
          isAddRecord: false,
          onTap: () {
            controller.homeController.fromFiringRecordDetail.value = false;
            Get.to(AddShooterLog());
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
                        Get.to(AddShooterLog());
                      },
                      child: BuildFiringRecord(
                        date: record.date ?? "",
                        time: record.time ?? "",
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
              Get.to(AddShooterLog());
            },
            text: "Add Record",
          ),
        ),
      ],
    );
  }
}
