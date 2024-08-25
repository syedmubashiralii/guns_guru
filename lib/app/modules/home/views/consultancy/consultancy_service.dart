import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/models/consultancy_model.dart';

class ConsultancyService extends GetView<HomeController> {

  const ConsultancyService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultancy Requirements'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Requirements to avail consultancy:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            BulletPoint(text: 'Be a Pakistani citizen.'),
            BulletPoint(text: 'Be at least 25 years old.'),
            BulletPoint(
              text: 'Have a valid CNIC (both temporary and permanent '
                  'addresses be of Sindh).',
            ),
            BulletPoint(
              text: 'Not be considered unsuitable by the local police.',
            ),
            BulletPoint(
              text: 'Not be a proscribed person or member of a proscribed '
                  'organization.',
            ),
            BulletPoint(
              text: 'Not be suspected of involvement in any anti-state activity.',
            ),
            BulletPoint(
              text: 'Not be physically, mentally, or psychologically infirm '
                  'to carry a weapon.',
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
