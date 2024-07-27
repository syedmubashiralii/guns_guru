

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/utils/app_colors.dart';

class DarkButton extends StatelessWidget {
   DarkButton({
    super.key,
    required this.onTap,
    required this.text,
    this.buttonColor,
    this.fontSize
  });

  final HomeController controller=Get.find();
  VoidCallback onTap;
  Color? buttonColor;
  double? fontSize;
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
          color:buttonColor?? ColorHelper.primaryColor,
        ),
        alignment: Alignment.center,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child:
            Text(text, style:  TextStyle(color: Colors.white,fontSize:fontSize?? 15)),
      ),
    );
  }
}
