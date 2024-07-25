import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/add_ammunition_stock_view.dart';
import 'package:guns_guru/app/modules/home/views/add_weapon_detail.dart';
import 'package:guns_guru/app/modules/home/views/weapon_logbook_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/custom_container.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';

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
            var license = controller.userModel.value
                .license![controller.selectedLicenseIndex.value];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "LICENSE DETAILS",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.black),
                ),
                10.height,
                Builder(builder: (context) {
                  return CustomContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('License Number: ${license.licenseNumber}'),
                        Text('Weapon No: ${license.licenseTrackingNumber}'),
                        Text('Type: ${license.licenseCalibre}'),
                        Text(
                            'Ammunition Limit: ${license.licenseAmmunitionLimit}'),
                        Text('Issuance Date: ${license.licenseDateOfIssuance}'),
                        Text('Valid Till: ${license.licenseValidTill}'),
                        Text(
                            'Issuing Authority: ${license.licenseIssuingAuthority}'),
                        Text('Jurisdiction: ${license.licenseJurisdiction}'),
                        Image.network(
                          license.licensePicture ?? "",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  );
                }),
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
                      license.weaponDetails != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Weapon No: ${license.weaponDetails!.weaponNo}'),
                                Text(
                                    'Weapon Type: ${license.weaponDetails!.weaponType}'),
                                15.height,
                                Container(
                                  width: Get.width * .54,
                                  child: DarkButton(
                                    onTap: () {
                                      Get.to(WeaponLogBookView());
                                    },
                                    text: 'Manage Weapon logbook',
                                  ),
                                )
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
                                SizedBox(
                                    width: Get.width * .35,
                                    child: DarkButton(
                                      onTap: () {
                                        Get.to(const AddWeaponDetail());
                                      },
                                      text: 'Add Weapon',
                                    )),
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
                      license.weaponDetails != null &&
                              license.ammunitionDetail != null
                          ? Column(
                              children: [
                                for (AmmunitionDetail record
                                    in license.ammunitionDetail ?? []) ...[
                                  Container(
                                    margin: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: ListTile(
                                      title: Text(
                                          record.ammunitionQuantityPurchased ??
                                              ""),
                                      subtitle: Text(
                                          record.ammunitionPurchaseDate ?? ""),
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
                      license.weaponDetails != null
                          ? Container(
                              width: Get.width * .3,
                              child: DarkButton(
                                onTap: () {
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
