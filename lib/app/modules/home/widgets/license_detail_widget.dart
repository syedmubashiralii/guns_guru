import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
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

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return BannerCard(
      title: 'LICENSE DETAIL',
      isAddRecord: true,
      buttonText: "Edit",
      onTap: () async {
        controller.issuingAuthority.value =
            license.licenseIssuingAuthority ?? "";
        controller.trackingNumberController.text =
            license.licenseTrackingNumber ?? "";
        controller.licenseNumberController.text = license.licenseNumber ?? "";
        controller.ammunitionLimitController.text =
            license.licenseAmmunitionLimit ?? "";
        controller.caliber.value = license.licenseCalibre ?? "";
        controller.dateOfIssuanceController.text =
            license.licenseDateOfIssuance ?? "";
        controller.validTillController.text = license.licenseValidTill ?? "";
        controller.jurisdiction.value = license.licenseJurisdiction ?? "";
        controller.issuaingQuota.value = license.licenseIssuaingQuota ?? "";
        Get.dialog(LoadingDialog());
        controller.licensePicture.value =
            await urlToFile(license.licensePicture ?? "");
        closeDialog();    
        Get.to(AddLicenseView(
          fromEditing: true,
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
                      '${license.licenseNumber}',
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
                      '${license.licenseTrackingNumber}',
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
                  backgroundImage: NetworkImage(license.licensePicture ?? ""),
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
                      '${license.licenseCalibre}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
