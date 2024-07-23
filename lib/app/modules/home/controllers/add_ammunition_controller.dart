import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';

class AddAmmunitionController extends GetxController
{
  HomeController homeController=Get.find();
  final ammunitionStockFormKey = GlobalKey<FormState>();
  TextEditingController purchaseDateController=TextEditingController();
  TextEditingController purchasedFromController=TextEditingController();
  TextEditingController brandController=TextEditingController();
  TextEditingController caliberController=TextEditingController();
  TextEditingController quantityPurchasedController=TextEditingController();

   Future<void> addAmmunitionStock() async {
    if (ammunitionStockFormKey.currentState?.validate() ?? false) {
      Get.back();
      Get.dialog(const LoadingDialog());
      Map<String, dynamic> ammoDetailValue = {
        AppConstants.ammunitionPurchaseDate: purchaseDateController.text,
        AppConstants.ammunitionPurchasedFrom: purchasedFromController.text,
        AppConstants.ammunitionBrand: brandController.text,
        AppConstants.ammunitionCaliber: caliberController.text,
        AppConstants.ammunitionQuantityPurchased: quantityPurchasedController.text,
      };
      var licenses =homeController.userModel![AppConstants.license];
      if (licenses != null &&
         homeController.selectedLicenseIndex.value >= 0 &&
         homeController.selectedLicenseIndex.value < licenses.length) {
          if (licenses[homeController.selectedLicenseIndex.value][AppConstants.ammunitionDetail] == null) {
          licenses[homeController.selectedLicenseIndex.value][AppConstants.ammunitionDetail] = [];
          }
        licenses[homeController.selectedLicenseIndex.value][AppConstants.ammunitionDetail].add(ammoDetailValue);
        log(licenses[homeController.selectedLicenseIndex.value][AppConstants.ammunitionDetail].toString());
        await homeController.updateUserSpecificData(homeController.firebaseAuth.currentUser!.uid, {
          AppConstants.license: licenses,
        });
        await homeController.loadUserData(homeController.firebaseAuth.currentUser!.uid);
       homeController.userModel!.refresh();
        if (Get.isDialogOpen!) {
          Get.back();
        }
      } else {
        log("Invalid license index or licenses are null");
      }
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      log("Form validation failed");
    }
  }
}