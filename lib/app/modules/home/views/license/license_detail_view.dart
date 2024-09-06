import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/modules/home/views/weapon/add_weapon_view.dart';
import 'package:guns_guru/app/modules/home/widgets/license_detail_widget.dart';
import 'package:guns_guru/app/modules/home/widgets/weapon_detail_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';

class LicenseDetailView extends GetView<LicenseController> {
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
      body: Column(
        children: [
          Obx(() {
            var license =
                controller.licenseList[controller.selectedLicenseIndex.value];
            bool isAfter = checkIsAfterCurrentDate(license);
            return Visibility(
              visible: checkLicenseValidation(license),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                width: double.infinity,
                color: isAfter ? Colors.red : Colors.yellow,
                child: Text(
                  isAfter
                      ? 'Your license is expired'
                      : 'Your license is about to expire ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Obx(() {
                  var license = controller
                      .licenseList[controller.selectedLicenseIndex.value];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.height,
                      LicenseDetailWidget(license: license),
                      10.height,
                      Image.network(
                        license.licensePicture![0] ?? "",
                        width: Get.width,
                        fit: BoxFit.contain,
                      ),
                      10.height,
                      WeaponDetailWidget(
                        license: license,
                        isButtonShown: true,
                        onTap: () {
                          Get.find<WeaponController>().licenseNumber.value =
                              license.licenseNumber ?? "";
                               Get.find<WeaponController>().weaponType.value =
                              license.licenseweaponType ?? "";
                          Get.to(AddWeaponView(fromLicense: true,));
                        },
                      ),
                      20.height,
                      // BannerCard(
                      //   title: 'AMMUNITION',
                      //   content: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       10.height,
                      //       Column(
                      //         children: [
                      //           Row(
                      //             mainAxisAlignment:
                      //                 MainAxisAlignment.spaceBetween,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       calculateAmmunitionStock(
                      //                               license.ammunitionDetail ??
                      //                                   [])
                      //                           .toString(),
                      //                       overflow: TextOverflow.ellipsis,
                      //                       style: const TextStyle(
                      //                           color: Colors.black,
                      //                           fontWeight: FontWeight.bold),
                      //                     ),
                      //                     const CustomLabelText(
                      //                       text: 'Total Ammos',
                      //                     ),
                      //                     Text(
                      //                       "-${calculateShotsFired(license.weaponFiringRecord ?? [])}",
                      //                       overflow: TextOverflow.ellipsis,
                      //                       style: const TextStyle(
                      //                           color: Colors.red,
                      //                           fontWeight: FontWeight.bold),
                      //                     ),
                      //                     const CustomLabelText(
                      //                         text: 'Shots Fired'),
                      //                     const Padding(
                      //                       padding: EdgeInsets.only(right: 20),
                      //                       child: Divider(),
                      //                     ),
                      //                     Text(
                      //                         (calculateAmmunitionStock(license
                      //                                         .ammunitionDetail ??
                      //                                     []) -
                      //                                 calculateShotsFired(license
                      //                                         .weaponFiringRecord ??
                      //                                     []))
                      //                             .toString(),
                      //                         overflow: TextOverflow.ellipsis,
                      //                         style: const TextStyle(
                      //                             color: Colors.black,
                      //                             fontWeight: FontWeight.bold)),
                      //                     const CustomLabelText(
                      //                       text: 'Remainig Firing Stock',
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   children: [
                      //                     Text(
                      //                       calculateRemainingQuota(
                      //                               license.ammunitionDetail ??
                      //                                   [],
                      //                               int.parse(license
                      //                                           .licenseAmmunitionLimit ==
                      //                                       ""
                      //                                   ? "0"
                      //                                   : license
                      //                                           .licenseAmmunitionLimit ??
                      //                                       '0'))
                      //                           .toString(),
                      //                       overflow: TextOverflow.ellipsis,
                      //                       style: const TextStyle(
                      //                           color: Colors.black,
                      //                           fontWeight: FontWeight.bold),
                      //                     ),
                      //                     const CustomLabelText(
                      //                       text: 'Remaining Quota',
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Expanded(
                      //                 child: Text(license.licenseCalibre ?? "",
                      //                     style: const TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight: FontWeight.bold)),
                      //               )
                      //             ],
                      //           ),
                      //           5.height,
                      //           const Divider(
                      //             thickness: 3,
                      //           ),
                      //           5.height,
                      //           const Align(
                      //             alignment: Alignment.topLeft,
                      //             child: Text(
                      //               "Ammunition Stock: ",
                      //               overflow: TextOverflow.ellipsis,
                      //               style: TextStyle(
                      //                   decoration: TextDecoration.underline,
                      //                   color: Colors.black,
                      //                   fontSize: 20,
                      //                   fontWeight: FontWeight.bold),
                      //             ),
                      //           ),
                      //           10.height,
                      //           license.weaponDetails != null &&
                      //                   license.ammunitionDetail != null
                      //               ? Column(
                      //                   children: [
                      //                     for (AmmunitionDetail record
                      //                         in license.ammunitionDetail!) ...[
                      //                       Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment
                      //                                 .spaceBetween,
                      //                         children: [
                      //                           Expanded(
                      //                             child: Column(
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Text(
                      //                                   record.ammunitionBrand ??
                      //                                       "",
                      //                                   overflow: TextOverflow
                      //                                       .ellipsis,
                      //                                   style: const TextStyle(
                      //                                       color: Colors.black,
                      //                                       fontWeight:
                      //                                           FontWeight
                      //                                               .bold),
                      //                                 ),
                      //                                 const CustomLabelText(
                      //                                   text: 'Brand',
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                           Expanded(
                      //                             child: Column(
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Text(
                      //                                   record.ammunitionQuantityPurchased ??
                      //                                       "",
                      //                                   overflow: TextOverflow
                      //                                       .ellipsis,
                      //                                   style: const TextStyle(
                      //                                       color: Colors.black,
                      //                                       fontWeight:
                      //                                           FontWeight
                      //                                               .bold),
                      //                                 ),
                      //                                 const CustomLabelText(
                      //                                   text: 'In Stock',
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                           Expanded(
                      //                             child: Column(
                      //                               crossAxisAlignment:
                      //                                   CrossAxisAlignment
                      //                                       .start,
                      //                               children: [
                      //                                 Text(
                      //                                   record.ammunitionPurchaseDate ??
                      //                                       "",
                      //                                   overflow: TextOverflow
                      //                                       .ellipsis,
                      //                                   style: const TextStyle(
                      //                                       color: Colors.black,
                      //                                       fontWeight:
                      //                                           FontWeight
                      //                                               .bold),
                      //                                 ),
                      //                                 const CustomLabelText(
                      //                                   text: 'Last Purchased',
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       const SizedBox(height: 5),
                      //                       const Divider(),
                      //                       const SizedBox(height: 5),
                      //                     ]
                      //                   ],
                      //                 )
                      //               : const SizedBox()
                      //         ],
                      //       ),
                      //       10.height,
                      //       license.weaponUid != null
                      //           ? DarkButton(
                      //               buttonColor: Colors.black.withOpacity(.7),
                      //               fontSize: 10,
                      //               onTap: () {
                      //                 Get.to(const AddAmmunitionStockView());
                      //               },
                      //               text: 'Add Stock',
                      //             )
                      //           : Text(
                      //               "Please add the weapon to add ammunition record.",
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.w400,
                      //                   fontSize: 11,
                      //                   color: Colors.black.withOpacity(.7)),
                      //             ),
                      //     ],
                      //   ),
                      // ),
                    
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
