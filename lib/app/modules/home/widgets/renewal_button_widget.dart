import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/license/add_license_view.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';

class RenewalButtonWidget extends StatelessWidget {
  const RenewalButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.warning,
                color: Colors.red,
              ),
              10.width,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your License renewal is coming soon.",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  5.height,
                  const Text(
                    "Please get your license renewed to avoid any inconvenience",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                  15.height,
                  DarkButton(
                    fontSize: 11,
                    buttonColor: Colors.black.withOpacity(.7),
                    onTap: () {
                      // Get.dialog(LoadingDialog());
                      redirectToWhatsApp("+923316662709",
                    message:
                        "I want my License to be renewed");
                    },
                    text: "Renew my License",
                  ),
                  15.height,
                ],
              )),
            ],
          ),
        ));
  }
}