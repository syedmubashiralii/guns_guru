import 'package:flutter/material.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/banner_card.dart';
import 'package:guns_guru/app/utils/extensions.dart';

class WeaponDetailContainer extends StatelessWidget {
  const WeaponDetailContainer({
    super.key,
    required this.weaponDetails,
  });

  final WeaponDetails weaponDetails;

  @override
  Widget build(BuildContext context) {
    return BannerCard(
      title: 'WEAPON DETAILS',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(weaponDetails.weaponMake??"",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Make',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                ],
              ),
              Column(
                children: [
                  Text(weaponDetails.weaponModel??"",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Model',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                ],
              ),
              Text(weaponDetails.weaponCaliber??"",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          5.height,
          Divider(),
          5.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(weaponDetails.weaponNo??"",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('Weapon No',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.normal)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
