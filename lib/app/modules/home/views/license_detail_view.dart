import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/add_ammunition_stock_view.dart';
import 'package:guns_guru/app/modules/home/views/add_weapon_detail.dart';
import 'package:guns_guru/app/modules/home/views/weapon_logbook_view.dart';
import 'package:guns_guru/app/modules/home/widgets/license_detail_widget.dart';
import 'package:guns_guru/app/modules/home/widgets/weapon_detail_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/banner_card.dart';
import 'package:guns_guru/app/utils/custom_container.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';

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
                10.height,
                LicenseDetailWidget(license: license),
                20.height,
                WeaponDetailWidget(
                  license: license,
                  isButtonShown: true,
                ),
                20.height,
                BannerCard(
                  title: 'AMMUNITION',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.height,
                      license.weaponDetails != null &&
                              license.ammunitionDetail != null
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            calculateAmmunitionStock(
                                                    license.ammunitionDetail ??
                                                        [])
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const CustomLabelText(
                                            text: 'InStock',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            calculateRemainingQuota(
                                                    license.ammunitionDetail ??
                                                        [],
                                                    int.parse(license
                                                            .licenseAmmunitionLimit ??
                                                        '0'))
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const CustomLabelText(
                                            text: 'Remaining Quota',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(license.licenseCalibre ?? "",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                                5.height,
                                const Divider(),
                                5.height,
                                for (AmmunitionDetail record
                                    in license.ammunitionDetail ?? []) ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              record.ammunitionBrand ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const CustomLabelText(
                                              text: 'Brand',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              record.ammunitionQuantityPurchased ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const CustomLabelText(
                                              text: 'In Stock',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              record.ammunitionPurchaseDate ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const CustomLabelText(
                                              text: 'Last Purchased',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  5.height,
                                  const Divider(),
                                  5.height,
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
                                  Get.to(const AddAmmunitionStockView());
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
