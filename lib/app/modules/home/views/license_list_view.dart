import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/add_license_view.dart';
import 'package:guns_guru/app/modules/home/views/license_detail_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';

import '../controllers/home_controller.dart';

class LicenseListView extends GetView<HomeController> {
  const LicenseListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.home),
        backgroundColor: ColorHelper.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset(
          "assets/images/guns-guru.png",
          height: 40,
        ),
        actions: [
          IconButton(
              onPressed: controller.signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome ${controller.userModel.value.fullname??""}",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(.7)),
            ),
            const Text(
              "LICENSE DETAILS",
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            ),
            10.height,
            Expanded(
              child: controller.userModel.value.license == null ||
                      controller.userModel.value.license!.isEmpty
                  ? const Center(
                      child: Text("No License Found"),
                    )
                  : ListView.builder(
                      itemCount: controller
                          .userModel.value.license!.length,
                      itemBuilder: (context, index) {
                        final license = controller
                            .userModel.value.license![index];
                        String weaponNo = license
                                    .weaponDetails!=null &&
                                license.weaponDetails!
                                    .weaponNo!=null
                            ? license.weaponDetails!.weaponNo ?? "N/A"
                            : 'N/A';
                        return Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2)),
                              // borderRadius: BorderRadius.circular(10),÷\
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                controller.selectedLicenseIndex.value = index;
                                Get.to(const LicenseDetailView());
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        license.licensePicture??""),
                                  ),
                                  15.width,
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${license.licenseNumber??""}',
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
                                    child: Column(
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
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          license.licenseCalibre??"",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text(
                                          'Caliber',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  15.width,
                                  CircleAvatar(
                                      radius: 10,
                                      backgroundColor: ColorHelper.primaryColor,
                                      child: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 12,
                                      )),
                                ],
                              ),
                            ));
                      },
                    ),
            ),
            DarkButton(
                onTap: () {
                  Get.to(AddLicenseView());
                },
                text: "Add Another License"),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
