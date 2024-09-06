import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/license/add_license_view.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';

class LicenseDetailWidget extends StatelessWidget {
  LicenseDetailWidget({
    super.key,
    required this.license,
  });

  final License license;

  final LicenseController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return BannerCard(
      title: 'LICENSE DETAIL',
      isAddRecord: true,
      buttonText: "Edit",
      onTap: () async {
        controller.fillAllDetailsWithSpecificLicense(license);
        Get.dialog(LoadingDialog());
        controller.licensePictures.clear();
        int length = license.licensePicture?.length ?? 0;
        for (int i = 0; i < length; i++) {
          var path = license.licensePicture?[i];
          controller.licensePictures.add(await urlToFile(path ?? ""));
        }

        closeDialog();
        Get.to(AddLicenseView(
          fromEditing: true,
          uid: license.uid
        ));
      },
      buttonIcon: Icons.edit,
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
                      license.licenseNumber == ''
                          ? "N/A"
                          : license.licenseNumber ?? "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                      license.licenseTrackingNumber == ''
                          ? "N/A"
                          : license.licenseTrackingNumber ?? "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                      NetworkImage(license.licensePicture?[0] ?? ""),
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
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                      '${license.licenseweaponType}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                      license.licenseAmmunitionLimit == ''
                          ? "N/A"
                          : license.licenseAmmunitionLimit ?? "N/A",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                          color: Colors.black, fontWeight: FontWeight.bold),
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
