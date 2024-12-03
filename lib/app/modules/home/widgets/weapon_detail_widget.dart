import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/weapon/weapon_detail_screen.dart';
import 'package:guns_guru/app/modules/home/views/weapon/weapon_logbook_view.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';

class WeaponDetailWidget extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onTapWeaponDetail;
  final License license;
  final bool isButtonShown;

  WeaponDetailWidget({
    Key? key,
    required this.license,
    required this.isButtonShown,
    required this.onTap,
    this.onTapWeaponDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeaponController weaponController = Get.find();
    print("uid${license.weaponUid}");
    // Fetch weapon details when this widget is built
    if (license.weaponUid != null&&license.weaponUid!="") {
      log("enter");
      weaponController.fetchWeaponDetailsById(license.weaponUid ?? "");
    } else {
      weaponController.weaponDetails = Rx<WeaponDetails?>(null);
    }

    return BannerCard(
      title: 'WEAPON DETAIL',
      content: Obx(() {
        final weapon = weaponController.weaponDetails.value;
        if (weapon == null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "No weapon added for this license",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(.7)),
              ),
              15.height,
              DarkButton(
                  buttonColor: Colors.black.withOpacity(.7),
                  fontSize: 10,
                  onTap: onTap,
                  text: 'Add Weapon'),
            ],
          );
        } else {
          return Column(
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
                          weapon.weaponMake ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          weapon.weaponModel ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const CustomLabelText(text: 'Model'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(weapon.weaponCaliber ?? "",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const CustomLabelText(text: 'Caliber'),
                      ],
                    ),
                  )
                ],
              ),
              5.height,
              const Divider(),
              5.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weapon.weaponNo ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          weapon.weaponType ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
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
                          style: TextStyle(
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
              Visibility(
                visible: isButtonShown,
                child: Column(
                  children: [
                    5.height,
                    const Divider(),
                    15.height,
                    DarkButton(
                        buttonColor: Colors.black.withOpacity(.7),
                        fontSize: 10,
                        onTap: onTapWeaponDetail ??
                            () {
                              // Get.to(WeaponLogBookView());
                              Get.to(WeaponDetailScreen(
                                weapon: weapon,
                              ));
                            },
                        text: 'Weapon Detail / Add Ammo')
                  ],
                ),
              )
            ],
          );
        }
      }),
    );
  }
}
