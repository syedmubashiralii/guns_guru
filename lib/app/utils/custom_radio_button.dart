
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton(
      {super.key,
      required this.firePin1,
      required this.onChanged,
      required this.title});
  final ValueChanged<bool?>? onChanged;
  final bool firePin1;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * .4,
      child: Row(
        children: [
          Checkbox(
            side: BorderSide(width: 1, color: Colors.grey),
            value: firePin1,
            onChanged: onChanged,
          ),
          5.width,
          Text(title)
        ],
      ),
    );
  }
}
