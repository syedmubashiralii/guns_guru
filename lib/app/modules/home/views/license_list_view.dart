import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/add_license_view.dart';
import 'package:guns_guru/app/modules/home/views/license_detail_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:nb_utils/nb_utils.dart';

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
          IconButton(onPressed: controller.signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome ${controller.userModel!.value[AppConstants.Name]}",
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
              child: controller.userModel == null ||
                      !controller.userModel!.value.containsKey(AppConstants.license)
                  ? const Center(
                      child: Text("No License Found"),
                    )
                  : ListView.builder(
                      itemCount:
                          controller.userModel!.value[AppConstants.license].length,
                      itemBuilder: (context, index) {
                        final license =
                            controller.userModel!.value[AppConstants.license][index];
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
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
                          child: ListTile(
                            onTap: (){
                              controller.selectedLicenseIndex.value=index;
                              Get.to(const LicenseDetailView());
                            },
                            title: Text(
                                'License Number: ${license[AppConstants.licenseNumber]}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Tracking No: ${license[AppConstants.licenseTrackingNumber]}'),
                                Text(
                                    'Type: ${license[AppConstants.licenseCalibre]}'),
                              ],
                            ),
                            leading: Image.network(
                              license[AppConstants.licensePicture],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            trailing: CircleAvatar(
                                radius: 12,
                                backgroundColor: ColorHelper.primaryColor,
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 12,
                                )),
                          ),
                        );
                      },
                    ),
            ),
            20.height,
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
