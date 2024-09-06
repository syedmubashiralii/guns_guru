import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/service_record_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/service_record/add_weapon_service_record.dart';
import 'package:guns_guru/app/modules/home/widgets/service_record_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';

class ServiceRecordView extends GetView<ServiceRecordController> {
  ServiceRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllServiceRecords();
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

  Widget _buildShooterLogSection(
      ServiceRecordController serviceRecordController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BannerCard(
            title: 'SERVICE RECORD',
            isAddRecord: true,
            onTap: () {
              controller.homeController.fromServiceDetail.value = false;
              Get.to(AddWeaponServiceRecord());
            },
            content: Obx(() {
              return Column(
                children: [
                  if (controller.serviceRecordList.isEmpty)
                    Text("No record found"),
                  if (controller.serviceRecordList.isNotEmpty)
                    for (ServiceRecord record
                        in controller.serviceRecordList.value ?? [])
                      InkWell(
                        onTap: () {
                          controller.homeController.fromServiceDetail.value =
                              true;
                          controller.populateData(record);
                          Get.to(AddWeaponServiceRecord());
                        },
                        child: buildServiceRecord(
                          record.serviceDate ?? "",
                          record.selfOrArmorService ?? "",
                          record.weaponno??"",
                        ),
                      ),
                  // const SizedBox(height: 10),
                  // DarkButton(
                  //     buttonColor: Colors.black.withOpacity(.7),
                  //     fontSize: 10,
                  //     onTap: () {},
                  //     text: 'View Complete Details'),
                ],
              );
            })),
        const SizedBox(height: 10),
        SizedBox(
          width: Get.width,
          child: DarkButton(
            onTap: () async {
              controller.homeController.fromServiceDetail.value = false;
              Get.to(AddWeaponServiceRecord());
            },
            text: "Add Record",
          ),
        ),
      ],
    );
  }
}
