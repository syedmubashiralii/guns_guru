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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorHelper.primaryColor,
              ColorHelper.primaryColor,
              ColorHelper.rustyOrange,
            ],
            begin: Alignment.topCenter, // adjust as needed
            end: Alignment.bottomCenter, // adjust as needed
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                    child: Image.asset(
                  "assets/images/guns-guru1.png",
                  height: 80,
                )),
                FadeInRight(
                    child: Image.asset(
                  "assets/images/guns-guru2.png",
                  height: 60,
                )),
                10.height,
                const Text(
                  "A license grants legal permission to possess and use firearms, requiring background checks, training, and adherence to local regulations. It emphasises responsible ownership and prioritises public safety.",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                FadeInRight(
                    child: Image.asset(
                  "assets/images/landing_page.png",
                  height: Get.height * .35,
                )),
                SizedBox(
                  height: Get.height * .1,
                ),
                FadeInLeft(
                  child: Center(
                    child: CustomButton(
                      icon: "assets/images/ic_google.png",
                      text: 'Sign in with Google',
                      onPressed: controller.signInWithGoogle,
                    ),
                  ),
                ),
                15.height,
                Visibility(
                  visible: Platform.isIOS,
                  child: Center(
                    child: FadeInRight(
                      child: CustomButton(
                        icon: "assets/images/ic-apple.png",
                        text: 'Sign in with Apple',
                        onPressed: controller.signInWithApple,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
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
          border: Border.all(color: ColorHelper.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(20),
          color: ColorHelper.primaryColor,
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(1), // Semi-transparent black shadow
              blurRadius: 5, // Higher blur to spread the shadow further
              offset: const Offset(5, 5), // Offset to place shadow at bottom right
            ),
          ],
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
