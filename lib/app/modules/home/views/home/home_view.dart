import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/modules/home/views/auth/add_user_profile_view.dart';
import 'package:guns_guru/app/modules/home/views/consultancy/consultancy_view.dart';
import 'package:guns_guru/app/modules/home/views/license/license_list_view.dart';
import 'package:guns_guru/app/modules/home/views/service_record/service_record_view.dart';
import 'package:guns_guru/app/modules/home/views/shooter_logbook/shooter_logbook_view.dart';
import 'package:guns_guru/app/modules/home/views/weapon/weapon_list_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/app_exit_dialog.dart';
import 'package:guns_guru/app/utils/dialogs/complete_profile_dialog.dart';
import 'package:guns_guru/app/utils/dialogs/membership_dialog.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/app_drawer.dart';

import '../../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  LicenseController licenseController = Get.find();
  WeaponController weaponController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (weaponController.weaponList.isEmpty) {
      weaponController.loadWeapons();
    }
    if (Get.find<HomeController>().userModel.value.uid == null ||
        Get.find<HomeController>().userModel.value.uid == '') {
      Get.find<HomeController>().userModel.value.uid =
          FirebaseAuth.instance.currentUser?.uid ?? "";
    }
    return Obx(() {
      AppConstants.isPakistani =
          controller.userModel.value.countrycode == "PK" ||
                  controller.userModel.value.countrycode == "" ||
                  controller.userModel.value.countrycode == null
              ? true
              : false;
      return WillPopScope(
        onWillPop: () {
          showExitDialog();
          return Future.value(true);
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorHelper.primaryColor,
                ColorHelper.primaryColor,
                ColorHelper.rustyOrange,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Scaffold(
            drawer: const AppDrawer(),
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: ColorHelper.rustyOrange,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: const Text(
                  'Select Category',
                  style: TextStyle(color: Colors.white),
                )),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Obx(() {
                  //   return Text(
                  //     "Welcome, ${controller.userModel.value.firstname == null ? 'User' : "${controller.userModel.value.firstname} ${controller.userModel.value.lastname}"}",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w600,
                  //         color: Colors.black.withOpacity(.7)),
                  //   );
                  // }),

                  // 10.height,
                  // Text(
                  //   "This application is only for the license holders issued by the competent authority. Please select one of the options to proceed further:\n"
                  //   "A. Add your ${AppConstants.isPakistani ? "arms license" : "Weapon"}\n"
                  //   "B. Shooter Log Book (Weapon is needed to use this feature)\n"
                  //   "C. Service Record (Weapon is needed to use this feature)\n"
                  //   "D. Consultancy (Issuance of new license, renewal etc.).",
                  //   style: const TextStyle(
                  //       fontWeight: FontWeight.w400,
                  //       fontSize: 14,
                  //       color: Colors.black),
                  // ),

                  Obx(() {
                    return controller.userModel.value.phoneno == null ||
                            controller.userModel.value.phoneno == ''
                        ? RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  "Please complete your profile before proceeding to any feature. ",
                              style: const TextStyle(color: Colors.white),
                              children: [
                                TextSpan(
                                  text: "Complete Profile",
                                  style: const TextStyle(
                                    color: ColorHelper.rustyOrange,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    height: 1.5
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => AddUserProfileView(
                                            isReadOnly: false,
                                          ));
                                    },
                                ),
                              ],
                            ),
                          )
                        : const SizedBox();
                  }),
                  15.height,
                  _buildCard(AppConstants.isPakistani ? 'Licenses' : 'Weapons',
                      () {
                    if (controller.userModel.value.phoneno == null ||
                        controller.userModel.value.phoneno == '') {
                      showUserDetailsDialog(context, () {
                        Get.to(() => AddUserProfileView(
                              isReadOnly: false,
                            ));
                      },
                          text:
                              "Please complete your profile before proceeding to this feature.");
                      return;
                    }

                    if (AppConstants.isPakistani) {
                      Get.to(() => LicenseListView());
                    } else {
                      Get.to(() => WeaponListView());
                    }
                  },
                      ColorHelper.primaryColor.withOpacity(.9),
                      "assets/images/license.png",
                      AppConstants.isPakistani
                          ? "Add Licence /View License"
                          : "Add Weapon /View Weapon"),
                  _buildCard("Shooter's LogBook", () async {
                    if (controller.userModel.value.phoneno == null ||
                        controller.userModel.value.phoneno == '') {
                      showUserDetailsDialog(context, () {
                        Get.to(() => AddUserProfileView(
                              isReadOnly: false,
                            ));
                      },
                          text:
                              "Please complete your profile before proceeding to this feature.");
                      return;
                    }
                    if (controller.userModel.value.memberShip == null ||
                        controller.userModel.value.memberShip == '') {
                      DefaultSnackbar.show(
                          "Error", "Please Select MemberShip first");
                      showMembershipDialog(context);
                      return;
                    }
                    if (weaponController.weaponList.isEmpty) {
                      DefaultSnackbar.show("Error",
                          "Please add weapon then you can use this feature");
                      return;
                    }

                    Get.to(ShooterLogbookView());
                  }, ColorHelper.rustyOrange, "assets/images/shooter.png",
                      null),
                  _buildCard('Service LogBook', () {
                    if (controller.userModel.value.phoneno == null ||
                        controller.userModel.value.phoneno == '') {
                      showUserDetailsDialog(context, () {
                        Get.to(() => AddUserProfileView(
                              isReadOnly: false,
                            ));
                      },
                          text:
                              "Please complete your profile before proceeding to this feature.");
                      return;
                    }
                    if (controller.userModel.value.memberShip == null ||
                        controller.userModel.value.memberShip == '') {
                      DefaultSnackbar.show(
                          "Error", "Please Select MemberShip first");
                      showMembershipDialog(context);
                      return;
                    }
                    if (weaponController.weaponList.isEmpty) {
                      DefaultSnackbar.show("Error",
                          "Please add weapon then you can use this feature");
                      return;
                    }
                    Get.to(ServiceRecordView());
                  }, ColorHelper.rustyOrange, "assets/images/service.png",
                      null),
                  _buildCard('Consultancy Service', () {
                    Get.to(ConsultancyView());
                  },
                      ColorHelper.primaryColor.withOpacity(.9),
                      "assets/images/consultancy.png",
                      "e.g. License Renewal, License Issuance etc"),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'This App is for Arm Licensed Holders & Legitimate Firearm users only. You may Click on Consultancy for Guidance.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCard(
    String title,
    VoidCallback onTap,
    Color color,
    String icon,
    String? subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      // height: 110,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          // Top shadow (white)
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: const Offset(-2, -2), // Negative offset for top shadow
            blurRadius: 6,
          ),
          // Bottom shadow (black)
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(2, 2), // Positive offset for bottom shadow
            blurRadius: 6,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (subtitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(icon),
            )
          ],
        ),
      ),
    );
  }
}
