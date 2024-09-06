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
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/app_drawer.dart';

import '../../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  LicenseController licenseController = Get.find();
  WeaponController weaponController = Get.find();

  @override
  Widget build(BuildContext context) {
    AppConstants.isPakistani =
        controller.userModel.value.countrycode == "PK" ? true : false;

    return WillPopScope(
      onWillPop: () {
        showExitDialog();
        return Future.value(true);
      },
      child: Scaffold(
        drawer: const AppDrawer(),
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome, ${controller.userModel.value.firstname ?? ""} ${controller.userModel.value.lastname ?? ""}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(.7)),
                ),
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
                Spacer(),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCard(
                          AppConstants.isPakistani
                              ? 'Licenses'
                              : 'Weapons', () {
                        if (AppConstants.isPakistani) {
                          Get.to(() => LicenseListView());
                        } else {
                          Get.to(() => WeaponListView());
                        }
                      },ColorHelper.primaryColor.withOpacity(.9),null),
                      _buildCard("Shooter's LogBook", () async {
                         if (weaponController.weaponList.isEmpty) {
                          DefaultSnackbar.show("Error",
                              "Please add weapon then you can use this feature");
                              return;
                        }
                        Get.to(ShooterLogbookView());
                      },ColorHelper.rustyOrange,null)
                    ],
                  ),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCard('Service LogBook', () {
                        if (weaponController.weaponList.isEmpty) {
                          DefaultSnackbar.show("Error",
                              "Please add weapon then you can use this feature");
                              return;
                        }
                        Get.to(ServiceRecordView());
                      },ColorHelper.rustyOrange,null),
                      _buildCard('Consultancy Service', () {
                        Get.to(ConsultancyView());
                      },ColorHelper.primaryColor.withOpacity(.9),"e.g. License Renewal, License Issuance etc")
                    ],
                  ),
                  Spacer()
              ],
            ),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () {
            controller.firstNameController.text =
                controller.userModel.value.firstname ?? "";
            controller.lastNameController.text =
                controller.userModel.value.lastname ?? "";
            controller.cnicController.text =
                controller.userModel.value.cnic ?? "";
            controller.dobController.text =
                controller.userModel.value.dob ?? "";
            controller.phoneNoTextEditingController.text =
                controller.userModel.value.phoneno ?? "";
            controller.addressController.text =
                controller.userModel.value.address ?? "";
            controller.cityController.text =
                controller.userModel.value.city ?? "";
            controller.selectedCountryCode.value =
                controller.userModel.value.countrycode ?? "";
            controller.selectedGender.value =
                controller.userModel.value.gender ?? "";
            controller.emailController.text =
                controller.userModel.value.email ?? "";
            controller.documentExpiryDate.text =
                controller.userModel.value.documentExpiryDate ?? "";
            controller.documentIssuanceDate.text =
                controller.userModel.value.documentIssuanceDate ?? "";
            controller.selectedState.value =
                controller.userModel.value.state ?? "";
            Get.to(AddUserProfileView());
          },
          child: Container(
            color: ColorHelper.primaryColor,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Click here to Edit Profile",
                  style: TextStyle(color: Colors.white),
                ),
                10.width,
                const Icon(
                  Icons.edit,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, VoidCallback onTap,Color color,String? subtitle) {
    return Expanded(
      child: Card(
        color: color,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 150,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if(subtitle!=null)
                 Padding(
                   padding: const EdgeInsets.only(top:8.0),
                   child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.normal
                    ),
                                   ),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
