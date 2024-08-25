import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/models/consultancy_model.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/extensions.dart';

class ConsultancyService extends GetView<HomeExtensionController> {
  const ConsultancyService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const BulletPoint(text: 'Be a Pakistani citizen.'),
            const BulletPoint(text: 'Be at least 25 years old.'),
            const BulletPoint(
              text: 'Have a valid CNIC (both temporary and permanent '
                  'addresses be of Sindh).',
            ),
            const BulletPoint(
              text: 'Not be considered unsuitable by the local police.',
            ),
            const BulletPoint(
              text: 'Not be a proscribed person or member of a proscribed '
                  'organization.',
            ),
            const BulletPoint(
              text:
                  'Not be suspected of involvement in any anti-state activity.',
            ),
            const BulletPoint(
              text: 'Not be physically, mentally, or psychologically infirm '
                  'to carry a weapon.',
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
            const Text(
              'Note:',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 10),
            const BulletPoint(
                text:
                    'Please note that if your application is rejected by the authorities due any reason including misrepresentation, incomplete information, and or falsification, it constitutes a crime, and you will NOT be eligible for any refund.'),
            const BulletPoint(
                text:
                    'We reserve the sole right to accept or decline any request at our discretion. '),
            10.height,
            const Text(
              'Payment Methods:',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 10),
            const BulletPoint(text: 'Cash'),
            const BulletPoint(text: 'Easypaisa'),
            const BulletPoint(text: 'Bank Transfer'),
            30.height,
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
