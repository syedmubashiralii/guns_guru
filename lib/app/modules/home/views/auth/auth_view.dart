import 'dart:ffi';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/extensions.dart';

class AuthView extends GetView<HomeController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorHelper.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInRight(
                child: Image.asset(
              "assets/images/guns-guru.png",
              height: 80,
            )),
            10.height,
            FadeInLeft(
              child: CustomButton(
                icon: "assets/images/ic_google.png",
                text: 'Sign in with Google',
                onPressed: controller.signInWithGoogle,
              ),
            ),
            15.height,
            Visibility(
              visible: Platform.isIOS,
              child: FadeInRight(
                child: CustomButton(
                  icon: "assets/images/ic-apple.png",
                  text: 'Sign in with Apple',
                  onPressed: controller.signInWithApple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onPressed;

  CustomButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.grey.withOpacity(.3),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8),
          color: Colors.transparent,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: icon != "",
              child: Image.asset(
                icon,
                height: 25,
              ),
            ),
            8.width,
            Text(text, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
