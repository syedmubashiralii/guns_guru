import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/views/consultancy/consultancy_view.dart';
import 'package:guns_guru/app/modules/home/views/license/license_list_view.dart';
import 'package:guns_guru/app/modules/home/views/shooter_logbook/shooter_logbook_view.dart';
import 'package:guns_guru/app/modules/home/views/weapon/weapon_list_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/dialogs/app_exit_dialog.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/app_drawer.dart';

import '../../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
                10.height,
                Text(
                  "This application is only for the license holders issued by the competent authority. Please select one of the options to proceed further:\n"
                  "A. Add your ${AppConstants.isPakistani ? "arms license" : "Weapon"}\n"
                  "B. Shooter Log Book (License Is need to use this feature)\n"
                  "C. Service Record (License Is need to use this feature)\n"
                  "D. Consultancy (Issuance of new license, renewal etc.).",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black),
                ),
                30.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCard(AppConstants.isPakistani ? 'Add License' : 'Add Weapon', () {
                      if (AppConstants.isPakistani) {
                        Get.to(() => LicenseListView());
                      } else {
                        Get.to(() => WeaponListView());
                      }
                    }),
                    controller.userModel.value.license == null ||
                            controller.userModel.value.license!.isEmpty
                        ? const SizedBox()
                        : _buildCard('Shooter Log Book', () async {
                            Get.to(ShooterLogbookView());
                          })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    controller.userModel.value.license == null ||
                            controller.userModel.value.license!.isEmpty
                        ? const SizedBox()
                        : _buildCard('Weapon Service Record', () {}),
                    _buildCard('Consultancy Service', () {
                      Get.to(ConsultancyView());
                    })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, VoidCallback onTap) {
    return Expanded(
      child: Card(
        color: ColorHelper.primaryColor.withOpacity(.9),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 150,
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
