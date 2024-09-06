import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/license/add_license_view.dart';
import 'package:guns_guru/app/modules/home/views/weapon/add_weapon_view.dart';
import 'package:guns_guru/app/modules/home/views/weapon/weapon_detail_screen.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import '../../controllers/weapon_controller.dart';

class WeaponListView extends GetView<WeaponController> {
  WeaponListView({super.key});

  @override
  final HomeController homeController = Get.put(HomeController());
  final WeaponController weaponController = Get.put(WeaponController());

  @override
  Widget build(BuildContext context) {
    if(controller.weaponList.isEmpty){
     controller.loadWeapons();
     }
    return Scaffold(
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
        child: Obx(() {
          if (weaponController.weaponList.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('No weapons found'),
                10.height,
                DarkButton(
                  onTap: () {
                    controller.clearAllControllers();
                    Get.to(AddWeaponView());
                  },
                  text: "Add Weapon",
                ),
              ],
            ));
          }

          return ListView(
            children: [
              15.height,
              _buildWeaponList(weaponController.weaponList),
              30.height,
              DarkButton(
                onTap: () {
                  controller.clearAllControllers();
                  Get.to(AddWeaponView());
                },
                text: "Add Weapon",
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildWeaponList(List<WeaponDetails> weapons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "ALL Weapons",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 17),
        ),
        10.height,
        ...weapons.map((weapon) {
          return _buildWeaponItem(weapon,);
        }).toList(),
      ],
    );
  }

  Widget _buildWeaponItem(WeaponDetails weapon) {
    return BannerCard(
      title: "${weapon.weaponNo??""}",
      content: Column(
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
          Column(
            children: [
              5.height,
              const Divider(),
              15.height,
              DarkButton(
                  buttonColor: Colors.black.withOpacity(.7),
                  fontSize: 10,
                  onTap: () {
                    controller.weaponDetails.value=weapon;
                    // Get.to(WeaponLogBookView());
                    Get.to(WeaponDetailScreen(
                      weapon: weapon,
                    ));
                  },
                  text: 'Weapon Detail / Add Ammo')
            ],
          )
        ],
      ),
    );
  }
}






// IconButton(
//             icon: const Icon(Icons.edit, color: ColorHelper.primaryColor),
//             onPressed: () {
//               controller.fillAllDetailsWithSpecificWeapon(weapon);

//               Get.to(() => AddWeaponDetail(isEditMode: true));
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete, color: Colors.red),
//             onPressed: () {
//               weaponController.deleteWeapon(
//                 userId: homeController.userModel.value.uid ?? '',
//                 weaponId: weapon.weaponNo ?? '', // Use the correct ID here
//               );
//             },
//           ),