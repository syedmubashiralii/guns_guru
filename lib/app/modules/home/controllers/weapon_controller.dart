import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/models/model_make_model.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:image_picker/image_picker.dart';

class WeaponController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxInt selectedWeapon = 0.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  HomeController homeController = Get.find();
  final weaponFormKey = GlobalKey<FormState>();
  RxList<WeaponDetails> weaponList = <WeaponDetails>[].obs;
  RxList<AmmunitionDetail> ammunitionList = <AmmunitionDetail>[].obs;
  var weaponDetails = Rx<WeaponDetails?>(null);
  final ImagePicker picker = ImagePicker();
  TextEditingController authorizeDealerName = TextEditingController();
  TextEditingController authorizeDealerAddress = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController authorizeDealerPhoneNo = TextEditingController();
  TextEditingController weaponPurchaseDate = TextEditingController();
  TextEditingController weaponDocumentIssuingDate = TextEditingController();
  TextEditingController weaponDocumentExpiryDate = TextEditingController();
  RxString weaponType = "PISTOL".obs;
  TextEditingController weaponNumberController = TextEditingController();
  TextEditingController issuingDocumentNoController = TextEditingController();
  Rx<File?> weaponPurchaseReceipt = Rx<File?>(null);
  RxString weaponCaliber = "9mm".obs;
  RxString weaponMake = "Glock".obs;
  RxString weaponModel = "AK-47".obs;
  RxBool isPhoneNumberValid = false.obs;
  RxString licenseNumber = ''.obs;

  ///amunition
  final serviceRecordKey = GlobalKey<FormState>();
  final serviceDateController = TextEditingController();
  final serviceDoneByController = TextEditingController();
  final serviceNotesController = TextEditingController();
  TextEditingController retailerPhoneNo = TextEditingController();
  RxList servicePartsChangedList = [].obs;
  RxString ammoBrand = "Federal Premium".obs;
  RxString typeOfRound = "Full Metal Jacket (FMJ)".obs;
  RxString AmmoBrand = "".obs;
  final ammunitionStockFormKey = GlobalKey<FormState>();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController retailerNameController = TextEditingController();
  // TextEditingController brandController = TextEditingController();
  TextEditingController caliberController = TextEditingController();
  TextEditingController quantityPurchasedController = TextEditingController();
  Rx<File?> ammoPurchaseReceipt = Rx<File?>(null);
  RxList<String> filteredModels = <String>[].obs;

  @override
  onReady() async {
    // weaponList.value = await getAllWeapons(_auth.currentUser?.uid ?? "");
    loadUtils();
  }

  List<String> get filterModelsList {
    log("enter");
    if (weaponMake.value.isEmpty) {
      return AppConstants.model.map((model) => model.model).toList();
    } else {
      log("enter");
      return AppConstants.model
          .where((model) => model.make == weaponMake.value)
          .map((model) => model.model)
          .toList();
    }
  }

  Future<void> addAmmunition() async {
    try {
      LicenseController licenseController = Get.find();
      if (ammunitionStockFormKey.currentState!.validate()) {
        Get.dialog(const LoadingDialog());
        AmmunitionDetail ammunitionDetail = AmmunitionDetail(
          ammunitionBrand: ammoBrand.value,
          ammunitionCaliber: caliberController.text,
          ammunitionPurchaseDate: purchaseDateController.text,
          ammunitionPurchasedFrom: retailerNameController.text,
          typeOfRound: typeOfRound.value,
          retailerPhoneNo: retailerPhoneNo.text,
          retailerName: retailerNameController.text,
          ammunitionQuantityPurchased: quantityPurchasedController.text,
          weaponNo: weaponDetails.value!.weaponNo,
          weaponUid: weaponDetails.value!.uid,
          licenseNo: AppConstants.isPakistani
              ? licenseController
                  .licenseList
                  .value[licenseController.selectedLicenseIndex.value]
                  .licenseNumber
              : "",
          licenseUid: AppConstants.isPakistani
              ? licenseController.licenseList
                  .value[licenseController.selectedLicenseIndex.value].uid
              : "",
        );
        CollectionReference ammunitionCollection = _firestore
            .collection('ammunition')
            .doc(Get.find<HomeController>().userModel.value.uid ?? '')
            .collection('userAmmunitions');
        DocumentReference ammunitionDocumentReference =
            await ammunitionCollection.add(ammunitionDetail.toMap());
        await ammunitionDocumentReference
            .update({'uid': ammunitionDocumentReference.id});
        closeDialog();
        Get.back();
        DefaultSnackbar.show(
          'Success',
          'Stock added successfully!',
        );
        clearAllControllers();
        ammunitionList.value =
            await getAllAmmunition(_auth.currentUser?.uid ?? "");
      }
    } catch (e) {
      closeDialog();
      DefaultSnackbar.show(
        'Error',
        'Failed to add stock: $e',
      );
    }
  }

  Future<void> addWeapon() async {
    try {
      fillControllersWithDummyData();
      if (weaponFormKey.currentState!.validate()) {
        Get.dialog(const LoadingDialog());
        WeaponDetails newWeapon = WeaponDetails(
            weaponNo: weaponNumberController.text,
            weaponType: weaponType.value,
            weaponauthorizedealername: authorizeDealerName.text,
            weaponauthorizedealeraddress: authorizeDealerAddress.text,
            weaponauthorizedealerphonenumber: authorizeDealerPhoneNo.text,
            weaponpurchaserecipt: weaponPurchaseReceipt.value?.path ?? '',
            weaponpurchasedate: weaponPurchaseDate.text,
            weaponMake: weaponMake.value,
            weaponModel: weaponModel.value,
            weaponCaliber: weaponCaliber.value,
            licenseNo: issuingDocumentNoController.text,
            documentIdNo: homeController.userModel.value.countrycode == "PK"
                ? licenseNumber.value
                : issuingDocumentNoController.text,
            emailId: emailController.text,
            documentIssuingDate: weaponDocumentIssuingDate.text,
            documentExpiryDate: weaponDocumentExpiryDate.text);
        CollectionReference userWeaponsCollection = _firestore
            .collection('weapons')
            .doc(Get.find<HomeController>().userModel.value.uid ?? '')
            .collection('userWeapons');
        DocumentReference weaponDocumentReference =
            await userWeaponsCollection.add(newWeapon.toMap());
        await weaponDocumentReference
            .update({'uid': weaponDocumentReference.id});
        if (AppConstants.isPakistani) {
          Get.find<LicenseController>().updateLicenseWeaponNo(
              weaponNumberController.text ?? "", weaponDocumentReference.id);
        }
        closeDialog();
        Get.back();
        DefaultSnackbar.show(
          'Success',
          'Weapon added successfully!',
        );
        clearAllControllers();
        weaponList.value = await getAllWeapons(_auth.currentUser?.uid ?? "");
      }
    } catch (e) {
      closeDialog();
      DefaultSnackbar.show(
        'Error',
        'Failed to add weapon: $e',
      );
    }
  }

  Future<void> fetchWeaponDetailsById(String weaponDocId) async {
    try {
      log("enter 1");
      DocumentSnapshot weaponSnapshot = await _firestore
          .collection('weapons')
          .doc(FirebaseAuth.instance.currentUser?.uid ?? '')
          .collection('userWeapons')
          .doc(weaponDocId)
          .get();
      log("enter 2222");

      if (weaponSnapshot.exists) {
        log(weaponSnapshot.data().toString());
        weaponDetails.value = WeaponDetails.fromJson(
            weaponSnapshot.data() as Map<String, dynamic>);

        weaponDetails.refresh();
      }
    } catch (e) {
      DefaultSnackbar.show(
        'Error',
        'Failed to fetch weapon details: $e',
      );
    } finally {
      closeDialog();
    }
  }

  Future<List<WeaponDetails>> getAllWeapons(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('weapons')
          .doc(userId)
          .collection('userWeapons')
          .get();

      return querySnapshot.docs
          .map((doc) =>
              WeaponDetails.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch weapons: $e',
          snackPosition: SnackPosition.BOTTOM);
      return [];
    }
  }

  Future<List<AmmunitionDetail>> getAllAmmunition(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('ammunition')
          .doc(userId)
          .collection('userAmmunitions')
          .get();

      return querySnapshot.docs
          .map((doc) =>
              AmmunitionDetail.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Get.snackbar('Error', 'Failed to fetch ammuition: $e',
      //     snackPosition: SnackPosition.BOTTOM);
      return [];
    }
  }

  Future<void> editWeapon() async {
    try {
      if (weaponFormKey.currentState!.validate()) {
        Get.dialog(LoadingDialog());

        WeaponDetails updatedWeaponDetails = WeaponDetails(
            weaponNo: weaponNumberController.text,
            weaponType: weaponType.value,
            weaponauthorizedealername: authorizeDealerName.text,
            weaponauthorizedealeraddress: authorizeDealerAddress.text,
            weaponauthorizedealerphonenumber: authorizeDealerPhoneNo.text,
            weaponpurchaserecipt: weaponPurchaseReceipt.value?.path ?? '',
            weaponpurchasedate: weaponPurchaseDate.text,
            weaponMake: weaponMake.value,
            weaponModel: weaponModel.value,
            weaponCaliber: weaponCaliber.value,
            licenseNo: issuingDocumentNoController.text,
            documentIdNo: issuingDocumentNoController.text,
            emailId: emailController.text,
            documentIssuingDate: weaponDocumentIssuingDate.text,
            documentExpiryDate: weaponDocumentExpiryDate.text);
        DocumentReference weaponDoc = _firestore
            .collection('weapons')
            .doc(Get.find<HomeController>().userModel.value.uid ?? '')
            .collection('userWeapons')
            .doc(weaponNumberController.text);

        await weaponDoc.update(updatedWeaponDetails.toMap());
        closeDialog();
        Get.back();
        DefaultSnackbar.show(
          'Success',
          'Weapon updated successfully!',
        );
        weaponList.value = await getAllWeapons(_auth.currentUser?.uid ?? "");
        clearAllControllers();
      }
    } catch (e) {
      closeDialog();
      DefaultSnackbar.show(
        'Error',
        'Failed to update weapon: $e',
      );
    }
  }

  Future<void> deleteWeapon({
    required String userId,
    required String weaponId,
  }) async {
    try {
      Get.dialog(LoadingDialog());
      DocumentReference weaponDoc = _firestore
          .collection('weapons')
          .doc(userId)
          .collection('userWeapons')
          .doc(weaponId);

      await weaponDoc.delete();
      closeDialog();
      Get.back();
      Get.snackbar('Success', 'Weapon deleted successfully!',
          snackPosition: SnackPosition.BOTTOM);
      weaponList.value = await getAllWeapons(_auth.currentUser?.uid ?? "");
      clearAllControllers();
    } catch (e) {
      closeDialog();
      Get.snackbar('Error', 'Failed to delete weapon: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void fillControllersWithDummyData() {
    if (kDebugMode) {
      authorizeDealerName.text = 'John Doe';
      authorizeDealerAddress.text = '1234 Elm Street';
      authorizeDealerPhoneNo.text = '3105286323';
      weaponPurchaseDate.text = '01/09/2024';
      weaponDocumentIssuingDate.text = '09/01/2024';
      weaponDocumentExpiryDate.text = '09/01/2025';
      weaponNumberController.text = '12345';
      issuingDocumentNoController.text = 'LIC123456';
      emailController.text = 'test@example.com';
      weaponType.value = 'PISTOL';
      weaponMake.value = 'Glock';
      weaponModel.value = 'AK-47';
      weaponCaliber.value = '9mm'; // Dummy file path
    }
  }

  // Method to clear all controllers
  void clearAllControllers() {
    authorizeDealerName.clear();
    authorizeDealerAddress.clear();
    authorizeDealerPhoneNo.clear();
    weaponPurchaseDate.clear();
    weaponDocumentIssuingDate.clear();
    weaponDocumentExpiryDate.clear();
    weaponNumberController.clear();
    issuingDocumentNoController.clear();
    emailController.clear();
    weaponType.value = "PISTOL"; // Reset to default value
    weaponMake.value = "Glock"; // Reset to default value
    weaponModel.value = "AK-47"; // Reset to default value
    weaponCaliber.value = "9mm"; // Reset to default value
    weaponPurchaseReceipt.value = null; // Clear file selection
    isPhoneNumberValid.value = false; // Reset validation state
  }

  fillAllDetailsWithSpecificWeapon(WeaponDetails weapon) {
    print(
        "weaponauthorizedealerphonenumber${weapon.weaponauthorizedealerphonenumber}");
    weaponNumberController.text = weapon.weaponNo ?? '';
    weaponType.value = weapon.weaponType ?? 'PISTOL';
    authorizeDealerName.text = weapon.weaponauthorizedealername ?? '';
    authorizeDealerAddress.text = weapon.weaponauthorizedealeraddress ?? '';
    authorizeDealerPhoneNo.text = weapon.weaponauthorizedealerphonenumber ?? '';
    weaponPurchaseDate.text = weapon.weaponpurchasedate ?? '';
    weaponDocumentIssuingDate.text = weapon.documentIssuingDate ?? '';
    weaponDocumentExpiryDate.text = weapon.documentExpiryDate ?? '';
    issuingDocumentNoController.text = weapon.documentIdNo ?? '';
    emailController.text = weapon.emailId ?? '';
    weaponMake.value = weapon.weaponMake ?? 'Glock';
    weaponModel.value = weapon.weaponModel ?? 'AK-47';
    weaponCaliber.value = weapon.weaponCaliber ?? '9mm';
  }

  Future<void> loadUtils() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('admin').doc('utils').get();

      AppConstants.caliberList = List<String>.from(doc['callibers']);
      AppConstants.caliberList
          .sort((a, b) => a.compareTo(b)); // Sorting alphabetically
      Get.find<LicenseController>().caliber.value = AppConstants.caliber[0];
      weaponCaliber.value = AppConstants.caliber[0];

      AppConstants.make = List<String>.from(doc['makes']);
      AppConstants.make.sort((a, b) => a.compareTo(b));
      AppConstants.ammoBrand = List<String>.from(doc['ammobrand']);
      AppConstants.ammoBrand.sort((a, b) => a.compareTo(b));
      ammoBrand.value = AppConstants.ammoBrand.first;

      AppConstants.typeofRounds = List<String>.from(doc['typeOfRounds']);
      AppConstants.typeofRounds.sort((a, b) => a.compareTo(b));
      typeOfRound.value = AppConstants.typeofRounds.first;

      weaponMake.value = AppConstants.make[0];
      List<dynamic> modelsData = doc['models'];
      AppConstants.model = modelsData.map((item) {
        if (item is Map<String, dynamic>) {
          return Model.fromJson(item);
        } else {
          return Model(model: '', make: ''); // Fallback for unexpected data
        }
      }).toList();
      AppConstants.model
          .sort((a, b) => a.model.compareTo(b.model)); // Sorting alphabetically
      weaponModel.value = AppConstants.model[0].model;
    } catch (e) {
      print("errororoororo${e.toString()}");
    } finally {}
  }
}
