import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/models/consultancy_model.dart';
import 'package:guns_guru/app/modules/home/views/license/add_license_view.dart';
import 'package:guns_guru/app/modules/home/views/license/license_detail_view.dart';
import 'package:guns_guru/app/modules/home/widgets/renewal_button_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/dialogs/app_exit_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/app_drawer.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';

import '../../controllers/home_controller.dart';

class LicenseListView extends GetView<HomeController> {
  const LicenseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        showExitDialog();
        return Future.value(true);
      },
      child: Scaffold(
        drawer: const AppDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: IconButton(onPressed: (){},icon: const Icon(Icons.menu)),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, ${controller.userModel.value.firstname ?? ""} ${controller.userModel.value.lastname ?? ""}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(.7)),
              ),
              Visibility(
                  visible: isAnyLicenseValidionExpire(
                      controller.userModel.value.license ?? []),
                  child: Column(
                    children: [
                      15.height,
                      const RenewalButtonWidget(),
                    ],
                  )),
              10.height,
              const Text(
                "LICENSE DETAILS",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              ),
              10.height,
              Expanded(
                flex: 1,
                child: ListView(
                  children: [
                    if (controller.userModel.value.license == null ||
                        controller.userModel.value.license!.isEmpty)
                      const Center(child: Text("No License Found"))
                    else
                      ...controller.userModel.value.license!.map((license) {
                        int index = controller.userModel.value.license!
                            .indexOf(license);
                        String weaponNo = license.weaponDetails != null &&
                                license.weaponDetails!.weaponNo != null
                            ? license.weaponDetails!.weaponNo ?? "N/A"
                            : 'N/A';

                        return Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1)),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    controller.selectedLicenseIndex.value =
                                        index;
                                    Get.to(const LicenseDetailView());
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        license.licenseValidated == true
                                            ? 'assets/images/verified.png'
                                            : 'assets/images/not-verified.png',
                                        height: 40,
                                      ),
                                      15.width,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${license.licenseNumber ?? ""}',
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
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                weaponNo,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: weaponNo == "N/A"
                                                        ? Colors.red
                                                        : Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                license.licenseCalibre ?? "",
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                      ),
                                      15.width,
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            ColorHelper.primaryColor,
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: checkLicenseValidation(license),
                              child: Row(
                                children: [
                                  5.width,
                                  const Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    30.height,
                    DarkButton(
                      onTap: () {
                        controller.licenseNumberController.clear();
                        controller.licensePicture.value = null;
                        controller.ammunitionLimitController.clear();
                        controller.trackingNumberController.clear();
                        controller.dateOfIssuanceController.clear();
                        controller.validTillController.clear();
                        Get.to(AddLicenseView());
                      },
                      text: "Add Another License",
                    ),
                  ],
                ),
              ),
              10.height,
              Expanded(
                  flex: controller.userModel.value.license == null ||
                          controller.userModel.value.license!.isEmpty ||
                          controller.userModel.value.license!.length < 2
                      ? 2
                      : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "CONSULTANCY",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      20.height,
                      Expanded(
                        child: FutureBuilder<List<Consultancy>>(
                          future: Get.find<HomeExtensionController>()
                              .fetchConsultancyData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('No consultancy data available'));
                            }

                            final consultancyList = snapshot.data!;

                            return ListView.builder(
                              itemCount: consultancyList.length,
                              itemBuilder: (context, index) {
                                final consultancy = consultancyList[index];
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.2)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(0, 1)),
                                    ],
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Text((index + 1).toString() + "."),
                                    title: Text(consultancy.name),
                                    subtitle: Text(consultancy.description),
                                    trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.arrow_forward)),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
