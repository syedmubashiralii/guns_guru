import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/consultancy_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/models/consultancy_model.dart';
import 'package:guns_guru/app/modules/home/views/auth/add_user_profile_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/dialogs/complete_profile_dialog.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ConsultancyServiceDetail extends GetView<ConsultancyController> {
  const ConsultancyServiceDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    Consultancy consultancy =
        controller.consultancyList[controller.selectedConsultancyIndex.value];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(consultancy.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Requirements to avail consultancy:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const BulletPoint(
                text: 'Be a Pakistani citizen, with a valid CNIC. '),
            const BulletPoint(
                text:
                    'Be at least 25 years old (or as approved by your local authorities).'),
            const BulletPoint(
              text:
                  'Not be considered unsuitable by the local police, any law enforcement authority or by the court.',
            ),
            const BulletPoint(
              text:
                  'Not be a proscribed person or member of a proscribed organization. ',
            ),
            const BulletPoint(
              text:
                  'Not be suspected of involvement in any anti-state activity, or held guilty for murder, dacoity, robbery, theft, moral turpitude, cruelty/violence, or any other offence prescribed in this regard by the Home Department or any local or federal law enforcement agency from time to time.',
            ),
            const BulletPoint(
              text:
                  '• Not be physically, mentally, or psychologically infirm to carry a weapon.',
            ),
            const BulletPoint(
              text:
                  'Note: Subject to change from time to time by the authorities.',
            ),
            Text(
              consultancy.description,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorHelper.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: ${consultancy.price}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Documents Required:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            ...consultancy.documentationRequired
                .map(
                  (doc) => Text(
                    doc,
                    style: const TextStyle(fontSize: 16),
                  ),
                )
                .toList(),
            10.height,
            Visibility(
              visible: consultancy.information != '' ||
                  consultancy.information.isNotEmpty,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Information:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  10.width,
                  Text(
                    consultancy.information,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  10.height,
                ],
              ),
            ),
            DarkButton(
                onTap: () {
                  if (homeController.userModel.value.phoneno == null ||
                      homeController.userModel.value.phoneno == '') {
                    showUserDetailsDialog(context, () {
                      Get.to(() => AddUserProfileView(
                            isReadOnly: false,
                          ));
                    });
                  } else {
                    final userData = homeController.userModel.value.toJson();
                    final DateFormat formatter = DateFormat('yyyy-MM-dd');

                    final nonNullDetails = userData.entries
                        .where((entry) =>
                                entry.value != null &&
                                entry.value.toString().isNotEmpty &&
                                entry.key != 'uid' 
                            )
                        .map((entry) {
                      String formattedValue;
                      try {
                        final date = DateTime.parse(entry.value.toString());
                        formattedValue = formatter.format(date);
                      } catch (e) {
                        formattedValue = entry.value
                            .toString();
                      }
                      return '${entry.key}: $formattedValue';
                    }).join('\n');

                    final message =
                        'Service Name: ${consultancy.name}\nUser Record:\n$nonNullDetails';
                    print(message.toString());
                    redirectToWhatsApp("+923316662709", message: message);
                  }
                },
                text: "Avail Service"),
            20.height,
            const Text(
              'Note:',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 10),
            const BulletPoint(
                text:
                    "Please be advised that if your application or request is rejected by the regulatory authorities for any reason—including, but not limited to, misrepresentation, incomplete information, or falsification—it will be considered a criminal offense, and you will not be eligible for any refund."
                    "GunsGuru is not liable for any delays caused by the regulators or issuing authorities. In such cases, refunds will not be provided."),
            const BulletPoint(
                text:
                    'We reserve the sole right to accept or decline any request at our discretion.'),
            10.height,
            const Text('Payment Methods:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 10),
            const BulletPoint(text: 'Bank to Bank (All Local Banks)'),
            const BulletPoint(text: 'Debit Cards (All Local Banks)'),
            const BulletPoint(text: 'Credit Cards (Local and International)'),
            const BulletPoint(text: 'Raast (State Bank of Pakistan)'),
            const BulletPoint(
                text:
                    'Wallets (JazzCash, EasyPaisa, Omni, NayaPay, SadaPay, HBL Connect, Zindagi)'),
            30.height
          ],
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
