import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/weapon/add_weapon_detail.dart';
import 'package:guns_guru/app/modules/home/views/weapon/weapon_logbook_view.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';

class WeaponDetailWidget extends StatelessWidget {
  const WeaponDetailWidget(
      {super.key, required this.license, required this.isButtonShown});

  final License license;
  final bool isButtonShown;

  @override
  Widget build(BuildContext context) {
    return BannerCard(
      title: 'WEAPON DETAIL',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          license.weaponDetails != null
              ? Column(
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
                                '${license.weaponDetails?.weaponMake ?? ""}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const CustomLabelText(
                                text: 'Make',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${license.weaponDetails?.weaponModel ?? ""}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const CustomLabelText(
                                text: 'Model',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  license.weaponDetails?.weaponCaliber ?? "",
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                                      const CustomLabelText(
                                text: 'Caliber',
                              ),
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
                                '${license.weaponDetails?.weaponNo ?? ""}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const CustomLabelText(
                                text: 'Weapon No',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${license.weaponDetails?.weaponType ?? ""}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const CustomLabelText(
                                text: 'Weapon Type',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                calculateShotsFired(
                                        license.weaponFiringRecord ?? [])
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              const CustomLabelText(
                                text: 'Shots Fired',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isButtonShown == true,
                      child: Column(
                        children: [
                          5.height,
                          const Divider(),
                          15.height,
                          DarkButton(
                              buttonColor: Colors.black.withOpacity(.7),
                              fontSize: 10,
                              onTap: () {
                                Get.to(WeaponLogBookView());
                              },
                              text: 'Manage Weapon logbook')
                        ],
                      ),
                    )
                  ],
                )
              : Column(
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
                        onTap: () {
                          Get.to(const AddWeaponDetail());
                        },
                        text: 'Add Weapon'),
                  ],
                ),
        ],
      ),
    );
  }
}
