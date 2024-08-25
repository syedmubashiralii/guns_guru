import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/models/consultancy_model.dart';
import 'package:guns_guru/app/modules/home/models/model_make_model.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';

class HomeExtensionController extends GetxController {
  HomeController homeController = Get.find();
  var _firestore = FirebaseFirestore.instance;
  final ammunitionStockFormKey = GlobalKey<FormState>();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController purchasedFromController = TextEditingController();
  // TextEditingController brandController = TextEditingController();
  TextEditingController caliberController = TextEditingController();
  TextEditingController quantityPurchasedController = TextEditingController();

  ///
  final firingRecordKey = GlobalKey<FormState>();
  final firingDateController = TextEditingController();
  final firingLocationController = TextEditingController();
  final firingShotsFiredController = TextEditingController();
  final firingNotesController = TextEditingController();

  ////
  final serviceRecordKey = GlobalKey<FormState>();
  final serviceDateController = TextEditingController();
  final serviceDoneByController = TextEditingController();
  final serviceNotesController = TextEditingController();

  RxList servicePartsChangedList = [].obs;

  RxString ammoBrand="Federal Premium".obs;
  RxString typeOfRound="Full Metal Jacket (FMJ)".obs;

  Future<void> addAmmunitionStock() async {
    if (ammunitionStockFormKey.currentState?.validate() ?? false) {
      if (calculateRemainingQuota(
              homeController
                      .userModel
                      .value
                      .license![homeController.selectedLicenseIndex.value]
                      .ammunitionDetail ??
                  [],
              int.parse(homeController
                      .userModel
                      .value
                      .license![homeController.selectedLicenseIndex.value]
                      .licenseAmmunitionLimit ??
                  '0')) <
          int.parse(quantityPurchasedController.text)) {
        DefaultSnackbar.show('Error',
            "Please verify your remaining quota before entering the record.");

        return;
      }
      Get.back();
      Get.dialog(const LoadingDialog());
      Map<String, dynamic> ammoDetailValue = {
        AppConstants.ammunitionPurchaseDate: purchaseDateController.text,
        AppConstants.ammunitionPurchasedFrom: purchasedFromController.text,
        AppConstants.ammunitionBrand: ammoBrand.value,
        AppConstants.typeOfRound: typeOfRound.value,
        AppConstants.ammunitionCaliber: caliberController.text,
        AppConstants.ammunitionQuantityPurchased:
            quantityPurchasedController.text,
      };
      var licenses = homeController.userModel.value.license ?? [];
      if (homeController.selectedLicenseIndex.value >= 0 &&
          homeController.selectedLicenseIndex.value < licenses.length) {
        if (licenses[homeController.selectedLicenseIndex.value]
                .ammunitionDetail ==
            null) {
          licenses[homeController.selectedLicenseIndex.value].ammunitionDetail =
              [];
        }
        licenses[homeController.selectedLicenseIndex.value]
            .ammunitionDetail!
            .add(AmmunitionDetail.fromJson(ammoDetailValue));

        await homeController.updateUserSpecificData(
            homeController.firebaseAuth.currentUser!.uid, {
          AppConstants.license:
              licenses.map((license) => license.toMap()).toList()
        });
        await homeController
            .loadUserData(homeController.firebaseAuth.currentUser!.uid);
        homeController.userModel.refresh();
        closeDialog();
      } else {
        log("Invalid license index or licenses are null");
      }
    } else {
      closeDialog();
      log("Form validation failed");
    }
  }

  Future<void> addWeaponFiringRecord() async {
    if (firingRecordKey.currentState?.validate() ?? false) {
      Get.dialog(const LoadingDialog());
      Map<String, dynamic> firingRecord = {
        AppConstants.weaponFiringDate: firingDateController.text,
        AppConstants.weaponFiringLocation: firingLocationController.text,
        AppConstants.weaponFiringNotes: firingNotesController.text,
        AppConstants.weaponFiringShotsFired: firingShotsFiredController.text,
      };
      try {
        if (calculateAmmunitionStock(homeController
                        .userModel
                        .value
                        .license?[homeController.selectedLicenseIndex.value]
                        .ammunitionDetail ??
                    []) -
                calculateShotsFired(homeController
                        .userModel
                        .value
                        .license?[homeController.selectedLicenseIndex.value]
                        .weaponFiringRecord ??
                    []) <
            int.parse(firingShotsFiredController.text)) {
          DefaultSnackbar.show("Error",
              "The number of shots fired should not exceed the remaining stock. Please check your stock levels.");
          closeDialog();
          return;
        }
        var licenses = homeController.userModel.value.license;
        if (licenses != null &&
            homeController.selectedLicenseIndex.value >= 0 &&
            homeController.selectedLicenseIndex.value < licenses.length) {
          if (licenses[homeController.selectedLicenseIndex.value]
                  .weaponFiringRecord ==
              null) {
            licenses[homeController.selectedLicenseIndex.value]
                .weaponFiringRecord = [];
          }
          licenses[homeController.selectedLicenseIndex.value]
              .weaponFiringRecord!
              .add(WeaponFiringRecord.fromJson(firingRecord));
          await homeController.updateUserSpecificData(
              homeController.firebaseAuth.currentUser!.uid, {
            AppConstants.license:
                licenses.map((license) => license.toMap()).toList(),
          });
          await homeController
              .loadUserData(homeController.firebaseAuth.currentUser!.uid);
          homeController.userModel.refresh();
        } else {
          log("Invalid license index or licenses are null");
        }
        closeDialog();
        Get.back();
      } catch (e) {
        closeDialog();
        print(e.toString());
      }
    }
  }

  Future<void> addWeaponServiceRecord() async {
    if (serviceRecordKey.currentState?.validate() ?? false) {
      Get.dialog(const LoadingDialog());
      Map<String, dynamic> serviceRecord = {
        AppConstants.weaponServiceDate: serviceDateController.text,
        AppConstants.weaponServiceDoneBy: serviceDoneByController.text,
        AppConstants.weaponServicePartsChanged: servicePartsChangedList.value,
        AppConstants.weaponServiceNotes: serviceNotesController.text,
      };
      try {
        var licenses = homeController.userModel!.value.license;
        if (licenses != null &&
            homeController.selectedLicenseIndex.value >= 0 &&
            homeController.selectedLicenseIndex.value < licenses.length) {
          if (licenses[homeController.selectedLicenseIndex.value]
                  .weaponServiceRecord ==
              null) {
            licenses[homeController.selectedLicenseIndex.value]
                .weaponServiceRecord = [];
          }
          licenses[homeController.selectedLicenseIndex.value]
              .weaponServiceRecord!
              .add(WeaponServiceRecord.fromJson(serviceRecord));
          await homeController.updateUserSpecificData(
              homeController.firebaseAuth.currentUser!.uid, {
            AppConstants.license:
                licenses.map((license) => license.toMap()).toList(),
          });
          await homeController
              .loadUserData(homeController.firebaseAuth.currentUser!.uid);
          homeController.userModel!.refresh();
        } else {
          log("Invalid license index or licenses are null");
        }
        closeDialog();
        Get.back();
      } catch (e) {
        closeDialog();
        print(e.toString());
      }
    }
  }

  Future<List<Consultancy>> fetchConsultancyData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('admin')
        .doc('consultancy')
        .get();

    final List<dynamic> consultancyList = snapshot.data()?['consultancy'] ?? [];

    return consultancyList.map((e) => Consultancy.fromMap(e)).toList();
  }

 Future<void> loadUtils() async {
  try {
    DocumentSnapshot doc = await _firestore.collection('admin').doc('utils').get();

    AppConstants.caliber = List<String>.from(doc['callibers']);
    AppConstants.caliber.sort((a, b) => a.compareTo(b)); // Sorting alphabetically
    homeController.caliber.value = AppConstants.caliber[0];
    homeController.weaponCaliber.value = AppConstants.caliber[0];

    AppConstants.make = List<String>.from(doc['makes']);
    AppConstants.make.sort((a, b) => a.compareTo(b));
    AppConstants.ammoBrand = List<String>.from(doc['ammobrand']);
    AppConstants.ammoBrand.sort((a, b) => a.compareTo(b));
    ammoBrand.value=AppConstants.ammoBrand.first;

    AppConstants.typeofRounds = List<String>.from(doc['typeOfRounds']);
    AppConstants.typeofRounds.sort((a, b) => a.compareTo(b));
    typeOfRound.value=AppConstants.typeofRounds.first;


    homeController.weaponMake.value = AppConstants.make[0];
    List<dynamic> modelsData = doc['models'];
      AppConstants.model = modelsData.map((item) {
        if (item is Map<String, dynamic>) {
          return Model.fromJson(item);
        } else {
          return Model(model: '', make: ''); // Fallback for unexpected data
        }
      }).toList();
    AppConstants.model.sort((a, b) => a.model.compareTo(b.model)); // Sorting alphabetically
    homeController.weaponModel.value = AppConstants.model[0].model;
  } catch (e) {
    print("errororoororo${e.toString()}");
  } finally {}
}


  @override
  void onReady() {
    super.onReady();
    loadUtils();
  }

  
}
