import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/views/add_weapon_firing_record.dart';
import 'package:guns_guru/app/modules/home/views/add_weapon_service_record.dart';
import 'package:guns_guru/app/modules/home/widgets/weapon_detail_container.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/banner_card.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:nb_utils/nb_utils.dart';

class WeaponLogBookView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var license = controller.userModel!.value[AppConstants.license]
        [controller.selectedLicenseIndex.value][AppConstants.weaponDetails];
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
            WeaponDetailContainer(license: license),
            20.height,
            BannerCard(
                title: 'FIRING RECORD',
                isAddRecord: true,
                onTap: () {
                  Get.to(AddWeaponFiringRecord());
                },
                content: Obx(
                  () {
                    return Column(
                      children: [
                        if (controller.userModel!.value[AppConstants.license]
                                    [controller.selectedLicenseIndex.value]
                                [AppConstants.weaponFiringRecord] !=
                            null)
                          for (var record
                              in controller.userModel!.value[AppConstants.license]
                                      [controller.selectedLicenseIndex.value]
                                  [AppConstants.weaponFiringRecord])
                            _buildFiringRecord(
                              record[AppConstants.weaponFiringDate],
                              record[AppConstants.weaponFiringLocation],
                              record[AppConstants.weaponFiringShotsFired],
                            ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: Get.width * .5,
                          child: DarkButton(
                              onTap: () {}, text: 'View Complete Details'),
                        ),
                      ],
                    );
                  }
                )),
            const SizedBox(height: 20),
            BannerCard(
              title: 'SERVICE RECORD',
              isAddRecord: true,
              onTap: () {
                Get.to(AddWeaponServiceRecord());
              },
              content:  Obx(
                  () {
                    return Column(
                      children: [
                        if (controller.userModel!.value[AppConstants.license]
                                    [controller.selectedLicenseIndex.value]
                                [AppConstants.weaponServiceRecord] !=
                            null)
                          for (var record
                              in controller.userModel!.value[AppConstants.license]
                                      [controller.selectedLicenseIndex.value]
                                  [AppConstants.weaponServiceRecord])
                            _buildServiceRecord(
                              record[AppConstants.weaponServiceDate],
                              record[AppConstants.weaponServiceDoneBy],
                              record[AppConstants.weaponServicePartsChanged].toString(),
                            ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: Get.width * .5,
                          child: DarkButton(
                              onTap: () {}, text: 'View Complete Details'),
                        ),
                      ],
                    );
                  }
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiringRecord(String date, String location, String shotsFired) {
    return ListTile(
      title: Text(date),
      subtitle: Text(location),
      trailing: Text(shotsFired),
    );
  }

  Widget _buildServiceRecord(
      String date, String serviceType, String partsChanged) {
    return ListTile(
      title: Text(date),
      subtitle: Text(serviceType),
      trailing: Text(partsChanged),
    );
  }
}
