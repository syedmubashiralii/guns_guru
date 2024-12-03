import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/home/home_view.dart';
import 'package:guns_guru/app/modules/home/views/shooter_logbook/shooter_logbook_view.dart';
import 'package:guns_guru/app/modules/home/views/weapon/add_ammunition_stock_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/membership_dialog.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';

class WeaponDetailScreen extends GetView<WeaponController> {
  final WeaponDetails weapon;

  WeaponDetailScreen({Key? key, required this.weapon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.ammunitionList.isEmpty) {
      controller
          .getAllAmmunition(FirebaseAuth.instance.currentUser?.uid ?? "")
          .then((value) {
        controller.ammunitionList.value = value;
      });
    }

    return Scaffold(
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
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerCard(
              title: 'Weapon Detail',
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weapon.weaponMake ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const CustomLabelText(text: 'Make'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weapon.weaponModel ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const CustomLabelText(text: 'Model'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weapon.weaponCaliber ?? "N/A",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const CustomLabelText(text: 'Caliber'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weapon.weaponNo ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const CustomLabelText(text: 'Weapon No'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weapon.weaponType ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const CustomLabelText(text: 'Weapon Type'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weapon.weaponauthorizedealername ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const CustomLabelText(text: 'Authorized Dealer'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         weapon.weaponpurchaserecipt ?? "N/A",
                        //         overflow: TextOverflow.ellipsis,
                        //         style: TextStyle(
                        //           color: Colors.black,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       const CustomLabelText(text: 'Purchase Receipt'),
                        //     ],
                        //   ),
                        // ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weapon.weaponpurchasedate ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const CustomLabelText(text: 'Purchase Date'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            10.height,
            AmmunitionStockWidget(),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DarkButton(
                  buttonColor: Colors.black.withOpacity(.7),
                  fontSize: 16,
                  onTap: () {
                    Get.offAll(HomeView());
                  },
                  text: 'Go To Home',
                ),
                const SizedBox(width: 10),
                DarkButton(
                  buttonColor: Colors.black.withOpacity(.7),
                  fontSize: 16,
                  onTap: () {
                    if (controller.homeController.userModel.value.memberShip ==
                            null ||
                        controller.homeController.userModel.value.memberShip ==
                            '') {
                      DefaultSnackbar.show(
                          "Error", "Please Select MemberShip first");
                      showMembershipDialog(context);
                      return;
                    }
                    if (controller.weaponList.isEmpty) {
                      DefaultSnackbar.show("Error",
                          "Please add weapon then you can use this feature");
                      return;
                    }
                    Get.to(ShooterLogbookView());
                  },
                  text: 'Go to Shooters Log',
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AmmunitionStockWidget extends StatelessWidget {
  final WeaponController weaponController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ammunitionList = weaponController.ammunitionList
          .where((ammunition) =>
              ammunition.weaponUid ==
              weaponController.weaponDetails?.value?.uid)
          .toList();

      // final ammunitionList = weaponController.ammunitionList.value;

      return BannerCard(
        title: 'AMMUNITION',
        isAddRecord: true,
        buttonText: "Add Stock",
        onTap: () {
          Get.to(const AddAmmunitionStockView());
        },
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (ammunitionList.isNotEmpty) ...[
                  // Calculate total ammunition and shots fired
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           // Text(
                  //           //   calculateAmmunitionStock(ammunitionList).toString(),
                  //           //   overflow: TextOverflow.ellipsis,
                  //           //   style: const TextStyle(
                  //           //     color: Colors.black,
                  //           //     fontWeight: FontWeight.bold,
                  //           //   ),
                  //           // ),
                  //           // const CustomLabelText(text: 'Total Ammos'),
                  //           // Text(
                  //           //   "-${calculateShotsFired(weaponController.weaponFiringRecord ?? [])}",
                  //           //   overflow: TextOverflow.ellipsis,
                  //           //   style: const TextStyle(
                  //           //     color: Colors.red,
                  //           //     fontWeight: FontWeight.bold,
                  //           //   ),
                  //           // ),
                  //           const CustomLabelText(text: 'Shots Fired'),
                  //           Text(
                  //             (calculateAmmunitionStock(ammunitionList) - calculateShotsFired(weaponController.weaponFiringRecord ?? [])).toString(),
                  //             overflow: TextOverflow.ellipsis,
                  //             style: const TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           const CustomLabelText(text: 'Remaining Firing Stock'),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             calculateRemainingQuota(ammunitionList, weaponController.licenseAmmunitionLimit).toString(),
                  //             overflow: TextOverflow.ellipsis,
                  //             style: const TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           const CustomLabelText(text: 'Remaining Quota'),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Text(
                  //         weaponController.licenseCalibre ?? "",
                  //         style: const TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(height: 5),
                  // const Divider(thickness: 3),
                  // SizedBox(height: 5),
                  // const Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     "Ammunition Stock:",
                  //     overflow: TextOverflow.ellipsis,
                  //     style: TextStyle(
                  //       decoration: TextDecoration.underline,
                  //       color: Colors.black,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  ...ammunitionList.map((record) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      record.ammunitionBrand ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const CustomLabelText(text: 'Brand'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      record.ammunitionQuantityPurchased ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const CustomLabelText(text: 'Stock'),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      record.ammunitionPurchaseDate ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const CustomLabelText(
                                        text: 'Purchase Date'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Divider(),
                          const SizedBox(height: 5),
                        ],
                      )),
                ] else ...[
                  const Text(
                    "No ammunition record available.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                DarkButton(
                  buttonColor: Colors.black.withOpacity(.7),
                  fontSize: 16,
                  onTap: () {
                    Get.to(const AddAmmunitionStockView());
                  },
                  text: 'Add Stock',
                )
              ],
            ),
          ],
        ),
      );
    });
  }

  // int calculateAmmunitionStock(List<AmmunitionDetail> ammunitionList) {
  //   return ammunitionList.fold(0, (total, record) => total + int.tryParse(record.ammunitionQuantityPurchased ?? "0") ?? 0);
  // }

  // int calculateShotsFired(List<dynamic> firingRecord) {
  //   return firingRecord.length;
  // }

  // int calculateRemainingQuota(List<AmmunitionDetail> ammunitionList, int ammunitionLimit) {
  //   final totalAmmunitionStock = calculateAmmunitionStock(ammunitionList);
  //   final totalShotsFired = calculateShotsFired(weaponController.weaponFiringRecord ?? []);
  //   return ammunitionLimit - (totalAmmunitionStock - totalShotsFired);
  // }
}
