
import 'package:flutter/material.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/banner_card.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';

class LicenseDetailWidget extends StatelessWidget {
  const LicenseDetailWidget({
    super.key,
    required this.license,
  });

  final License license;

  @override
  Widget build(BuildContext context) {
    return BannerCard(
      title: 'LICENSE DETAIL',
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
                      '${license.licenseNumber}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const CustomLabelText(
                      text: 'License No',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${license.licenseTrackingNumber}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const CustomLabelText(
                      text: 'Tracking No',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(license.licensePicture ?? ""),
                ),
              ),
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
                      '${license.licenseDateOfIssuance}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const CustomLabelText(
                      text: 'Date of Issuance',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${license.licenseValidTill}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const CustomLabelText(
                      text: 'Valid Till',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${license.licenseIssuaingQuota}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const CustomLabelText(
                      text: 'Issuing Quota',
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
                      '${license.licenseCalibre}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const CustomLabelText(
                      text: 'Caliber',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${license.licenseAmmunitionLimit}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const CustomLabelText(
                      text: 'Ammunition Limit',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${license.licenseJurisdiction}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const CustomLabelText(
                      text: 'Jurestriction',
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


