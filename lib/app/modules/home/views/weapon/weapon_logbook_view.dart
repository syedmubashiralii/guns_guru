import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/weapon/add_weapon_firing_record.dart';
import 'package:guns_guru/app/modules/home/views/weapon/add_weapon_service_record.dart';
import 'package:guns_guru/app/modules/home/widgets/weapon_detail_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';

class WeaponLogBookView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
   HomeExtensionController homeExtensionController=Get.find();
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
          children: [
            Obx(
              () {
                return WeaponDetailWidget(
                  license: controller.userModel.value
                      .license![controller.selectedLicenseIndex.value],
                  isButtonShown: false,
                );
              }
            ),
            20.height,
            BannerCard(
                title: 'FIRING RECORD',
                isAddRecord: true,
                onTap: () {
                  controller.fromFiringRecordDetail.value = false;
                  // homeExtensionController.firingLocationController
                  //     .text = "";
                  // homeExtensionController.firingDateController.text =
                  //     "";
                  // homeExtensionController.firingNotesController.text = "";
                  // homeExtensionController.firingShotsFiredController
                      // .text = "";
                  Get.to(AddWeaponFiringRecord());
                },
                content: Obx(() {
                  return Column(
                    children: [
                        if (controller
                              .userModel
                              .value
                              .license![controller.selectedLicenseIndex.value]
                              .weaponFiringRecord ==
                          null)
                       Text("No record found"),
                      if (controller
                              .userModel
                              .value
                              .license![controller.selectedLicenseIndex.value]
                              .weaponFiringRecord !=
                          null)
                        for (WeaponFiringRecord record in controller
                                .userModel
                                .value
                                .license![controller.selectedLicenseIndex.value]
                                .weaponFiringRecord ??
                            [])
                          InkWell(
                            onTap: () {
                              controller.fromFiringRecordDetail.value = true;
                              Get.find<ShootingLogController>().populateFieldsForEditing(record);
                              Get.to(AddWeaponFiringRecord());
                            },
                            child: BuildFiringRecord(date: 
                              record.date ?? "",location: 
                              record.rangeNameLocation ?? "",shotsFired: 
                              record.roundsFired ?? "",
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
            const SizedBox(height: 20),
            BannerCard(
                title: 'SERVICE RECORD',
                isAddRecord: true,
                onTap: () {
                  controller.fromServiceDetail.value = false;
                  homeExtensionController.serviceDateController.text = "";
                  homeExtensionController.serviceDoneByController
                      .text = "";
                  homeExtensionController.serviceNotesController.text = "";
                  homeExtensionController.servicePartsChangedList
                      .value = [];
                  Get.to(AddWeaponServiceRecord());
                },
                content: Obx(() {
                  return Column(
                    children: [
                      if (controller
                              .userModel
                              .value
                              .license![controller.selectedLicenseIndex.value]
                              .weaponServiceRecord ==
                          null)
                          Text("No record found"),
                      if (controller
                              .userModel
                              .value
                              .license![controller.selectedLicenseIndex.value]
                              .weaponServiceRecord !=
                          null)
                        for (WeaponServiceRecord record in controller
                                .userModel
                                .value
                                .license![controller.selectedLicenseIndex.value]
                                .weaponServiceRecord ??
                            [])
                          InkWell(
                            onTap: () {
                              controller.fromServiceDetail.value = true;
                              homeExtensionController
                                  .serviceDateController
                                  .text = record.weaponServiceDate ?? "";
                              homeExtensionController
                                  .serviceDoneByController
                                  .text = record.weaponServiceDoneBy ?? "";
                              homeExtensionController
                                  .serviceNotesController
                                  .text = record.weaponServiceNotes ?? "";
                              homeExtensionController
                                      .servicePartsChangedList.value =
                                  record.weaponServicePartsChanged ?? [];
                              Get.to(AddWeaponServiceRecord());
                            },
                            child: _buildServiceRecord(
                              record.weaponServiceDate ?? "",
                              record.weaponServiceDoneBy ?? "",
                              record.weaponServicePartsChanged!.isNotEmpty
                                  ? "Yes"
                                  : "No",
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
          ],
        ),
      ),
    );
  }



  Widget _buildServiceRecord(
      String date, String serviceType, String partsChanged) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Date',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceType,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Service Type',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    partsChanged.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Parts Changed',
                  ),
                ],
              ),
            ),
            5.width,
            CircleAvatar(
                radius: 10,
                backgroundColor: Colors.black.withOpacity(.7),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 12,
                )),
            5.width,
          ],
        ),
        5.height,
        const Divider(),
        5.height,
      ],
    );
  }
}





  class BuildFiringRecord extends StatelessWidget {
   BuildFiringRecord({super.key,required this.date,required this.location,required this.shotsFired});
  String date; String location; String shotsFired;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Date',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Location',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shotsFired,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Shots Fired',
                  ),
                ],
              ),
            ),
            5.width,
            CircleAvatar(
                radius: 10,
                backgroundColor: Colors.black.withOpacity(.7),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 12,
                )),
            5.width,
          ],
        ),
        5.height,
        const Divider(),
        5.height,
      ],
    );
  }
}