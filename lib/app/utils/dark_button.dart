import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/utils/app_colors.dart';

class DarkButton extends StatelessWidget {
   DarkButton({
    super.key,
    required this.onTap,
    required this.text
  });

  final HomeController controller=Get.find();
  VoidCallback onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white.withOpacity(.3),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: ColorHelper.primaryColor,
        ),
        alignment: Alignment.center,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child:
            Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
