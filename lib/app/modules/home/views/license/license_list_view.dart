import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/views/license/add_license_view.dart';
import 'package:guns_guru/app/modules/home/views/license/license_detail_view.dart';
import 'package:guns_guru/app/modules/home/widgets/renewal_button_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';

class LicenseListView extends GetView<LicenseController> {
  LicenseListView({super.key});

  final ShootingLogController shootingLogController =
      Get.put(ShootingLogController());

  @override
  Widget build(BuildContext context) {
    if (controller.licenseList.isEmpty) {
      controller
          .getAllLicenses(FirebaseAuth.instance.currentUser?.uid ?? "")
          .then((value) {
        controller.licenseList.value = value;
      });
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          "assets/images/guns-guru.png",
          height: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
           () {
            return ListView(
              children: [
                if (isAnyLicenseValidionExpire(controller.licenseList.value ?? []))
                  const RenewalButtonWidget(),
                15.height,
                _buildLicenseDetails(controller, shootingLogController),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildLicenseDetails(LicenseController controller,
      ShootingLogController shootingLogController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ALL LICENSE",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 17),
        ),
        10.height,
        if (controller.licenseList.isEmpty)
          const Center(child: Text("No License Found"))
        else
          ...controller.licenseList.value.map((license) {
            int index = controller.licenseList.value.indexOf(license);
            String weaponNo = license.weaponNo ?? "N/A";

            return Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1)),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        controller.selectedLicenseIndex.value = index;
                        var selectedLicenseNumber = controller
                            .licenseList
                            .value[controller.selectedLicenseIndex.value]
                            .licenseNumber;

                        var filteredLogs = shootingLogController.shooterLogList
                            .where((log) =>
                                log.weaponNumber == selectedLicenseNumber)
                            .toList();
                        controller
                            .licenseList
                            .value[controller.selectedLicenseIndex.value]
                            .weaponFiringRecord = filteredLogs;

                        Get.to(const LicenseDetailView());
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            license.licenseValidated == true
                                ? 'assets/images/verified.png'
                                : 'assets/images/not-verified.png',
                            height: 40,
                          ),
                          15.width,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  license.licenseNumber == ""
                                      ? "N/A"
                                      : license.licenseNumber ?? "N/A",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'License No',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    weaponNo,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: weaponNo == "N/A"
                                            ? Colors.red
                                            : Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Weapon No',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    license.licenseweaponType ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Weapon Type',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          15.width,
                          const CircleAvatar(
                            radius: 10,
                            backgroundColor: ColorHelper.primaryColor,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: checkLicenseValidation(license),
                  child: Row(
                    children: [
                      5.width,
                      const Icon(
                        Icons.warning,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        30.height,
        Container(
          width: Get.width,
          child: DarkButton(
            onTap: () {
              controller.clearAllControllers();
              Get.to(AddLicenseView());
            },
            text: "Add License",
          ),
        ),
      ],
    );
  }
}
