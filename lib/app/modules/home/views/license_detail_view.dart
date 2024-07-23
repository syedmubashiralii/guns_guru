import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/add_ammunition_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/views/add_ammunition_stock_view.dart';
import 'package:guns_guru/app/modules/home/views/add_weapon_detail.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/custom_container.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:nb_utils/nb_utils.dart';

class LicenseDetailView extends GetView<HomeController> {
  const LicenseDetailView({
    Key? key,
  }) : super(key: key);

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
        child: SingleChildScrollView(
          child: Obx(() {
            var license = controller.userModel!.value[AppConstants.license]
                [controller.selectedLicenseIndex.value];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "LICENSE DETAILS",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                10.height,
                CustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'License Number: ${license[AppConstants.licenseNumber]}'),
                      Text(
                          'Weapon No: ${license[AppConstants.licenseTrackingNumber]}'),
                      Text('Type: ${license[AppConstants.licenseCalibre]}'),
                      Text(
                          'Ammunition Limit: ${license[AppConstants.licenseAmmunitionLimit]}'),
                      Text(
                          'Issuance Date: ${license[AppConstants.licenseDateOfIssuance]}'),
                      Text(
                          'Valid Till: ${license[AppConstants.licenseValidTill]}'),
                      Text(
                          'Issuing Authority: ${license[AppConstants.licenseIssuingAuthority]}'),
                      Text(
                          'Jurisdiction: ${license[AppConstants.licenseJurisdiction]}'),
                      Image.network(
                        license[AppConstants.licensePicture],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                20.height,
                const Text(
                  "WEAPON DETAIL",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                10.height,
                CustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      license.containsKey(AppConstants.weaponDetails)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Weapon No: ${license[AppConstants.weaponDetails][AppConstants.weaponNo]}'),
                                Text(
                                    'Weapon Type: ${license[AppConstants.weaponDetails][AppConstants.weaponType]}'),
                                15.height,
                                Container(
                                  width: Get.width * .54,
                                  child: DarkButton(
                                    onTap: () {},
                                    text: 'Manage Weapon logbook',
                                  ),
                                ),
                                // Add more weapon details here
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No weapon added for this license",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(.7)),
                                ),
                                15.height,
                                Container(
                                  width: Get.width * .35,
                                  child: DarkButton(
                                    onTap: () {
                                      Get.to(const AddWeaponDetail());
                                    },
                                    text: 'Add Weapon',
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                20.height,
                const Text(
                  "AMMUNITION DETAIL",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                10.height,
                CustomContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.height,
                      license.containsKey(AppConstants.weaponDetails) &&
                              license.containsKey(AppConstants.ammunitionDetail)
                          ? Column(
                              children: [
                                for (var record in license[
                                    AppConstants.ammunitionDetail]) ...[
                                  Container(
                                    margin: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: ListTile(
                                      title: Text(record[AppConstants
                                          .ammunitionQuantityPurchased]),
                                      subtitle: Text(record[
                                          AppConstants.ammunitionPurchaseDate]),
                                    ),
                                  ),
                                ],
                              ],
                            )
                          : Text(
                              "No ammunition record found!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  color: Colors.black.withOpacity(.7)),
                            ),
                      10.height,
                      license.containsKey(AppConstants.weaponDetails)
                          ? Container(
                              width: Get.width * .3,
                              child: DarkButton(
                                onTap: () {
                                  Get.put(AddAmmunitionController());
                                  Get.to(AddAmmunitionStockView());
                                },
                                text: 'Add Stock',
                              ),
                            )
                          : Text(
                              "Please add the weapon to add ammunition record.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  color: Colors.black.withOpacity(.7)),
                            ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
