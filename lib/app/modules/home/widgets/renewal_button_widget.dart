import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/license/add_license_view.dart';
import 'package:guns_guru/app/utils/extensions.dart';
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
              Icon(
                Icons.warning,
                color: Colors.red,
              ),
              10.width,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your License renewal is coming soon.",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  5.height,
                  Text(
                    "Please get your license renewed to avoid any inconvenience",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                  15.height,
                  SizedBox(
                    width: Get.width * .35,
                    child: DarkButton(
                      fontSize: 11,
                      buttonColor: Colors.black.withOpacity(.7),
                      onTap: () {
                       
                      },
                      text: "Renew my License",
                    ),
                  ),
                  15.height,
                ],
              )),
            ],
          ),
        ));
  }
}