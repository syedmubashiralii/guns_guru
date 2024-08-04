import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/utils/app_colors.dart';

class DarkButton extends StatelessWidget {
  const DarkButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.buttonColor,
    this.fontSize,
  }) : super(key: key);

  final VoidCallback onTap;
  final Color? buttonColor;
  final double? fontSize;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        splashFactory: InkRipple.splashFactory,
        overlayColor: Colors.white.withOpacity(0.2),
        backgroundColor: ColorHelper.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.normal),
      ),
    );
  }
}
