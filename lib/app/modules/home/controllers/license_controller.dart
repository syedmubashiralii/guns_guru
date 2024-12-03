import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/source_selection_dialog.dart';
import 'package:image_picker/image_picker.dart';

class LicenseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final licenseFormKey = GlobalKey<FormState>();

  RxList<License> licenseList = <License>[].obs;

  final ImagePicker picker = ImagePicker();
  RxInt selectedLicenseIndex = 0.obs;
  RxString selectedCountry = "".obs;

  TextEditingController trackingNumberController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController documentTypeController = TextEditingController();
  TextEditingController ammunitionLimitController = TextEditingController();
  TextEditingController dateOfIssuanceController = TextEditingController();
  TextEditingController validTillController = TextEditingController();
  RxString issuingQuota = "Federal Interior Minister".obs;
  RxList<File> licensePictures = <File>[].obs;
  RxString jurisdiction = "All Pakistan".obs;
  RxString caliber = '9mm'.obs;
  RxString licenseWeaponType = 'PISTOL'.obs;
  RxString issuingAuthority = "Sindh".obs;
  RxString weaponNo = "".obs;

  @override
  void onReady() async {
    super.onReady();
    // licenseList.value = await getAllLicenses(
    //     Get.find<HomeController>().userModel.value.uid ?? "");
  }

  loadLicenses() async {
    licenseList.value =
        await getAllLicenses(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> updateLicenseWeaponNo(weaponNo, weaponUid) async {
    String? userID = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userID == null || userID == '') {
      DefaultSnackbar.show(
        'Error',
        'Please reauthenticate and try again',
      );
      return;
    }
    DocumentReference licenseDoc = _firestore
        .collection('licenses')
        .doc(userID ?? '')
        .collection('userLicenses')
        .doc(licenseList[selectedLicenseIndex.value].uid);

    await licenseDoc.update({"weaponNo": weaponNo, "weaponUid": weaponUid});
    licenseList.value = await getAllLicenses(
        userID ?? "");
    licenseList.refresh();
  }

  Future<void> addLicense() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (userId == null || userId == "") {
      DefaultSnackbar.show('Error', "Please reauthenticate and then try again");
      return;
    }
    try {
      print("enter");
      // fillControllersWithDummyData();
      if (licenseFormKey.currentState!.validate()) {
        if (licensePictures.isEmpty) {
          DefaultSnackbar.show(
              'Error', "Please Select at least one license picture");
          return;
        }
        Get.dialog(LoadingDialog());
        List<String> licensePicUrls = [];
        for (File picture in licensePictures) {
          String? picUrl = await uploadImage(picture);
          if (picUrl != null) {
            licensePicUrls.add(picUrl);
          }
        }
        License newLicense = License(
            licenseTrackingNumber: trackingNumberController.text,
            licenseNumber: licenseNumberController.text,
            documenttype: documentTypeController.text,
            licenseAmmunitionLimit: ammunitionLimitController.text,
            licenseDateOfIssuance: dateOfIssuanceController.text,
            licenseValidated: false,
            country: selectedCountry.value,
            licenseValidTill: validTillController.text,
            licenseIssuaingQuota: issuingQuota.value,
            licensePicture: licensePicUrls,
            licenseJurisdiction: jurisdiction.value,
            licenseCalibre: caliber.value,
            licenseweaponType: licenseWeaponType.value,
            licenseIssuingAuthority: issuingAuthority.value);

        CollectionReference userLicensesCollection = _firestore
            .collection('licenses')
            .doc(userId ?? '')
            .collection('userLicenses');
        DocumentReference licenseDocRef =
            await userLicensesCollection.add(newLicense.toMap());
        await licenseDocRef.update({'uid': licenseDocRef.id});
        closeDialog();
        Get.back();
        DefaultSnackbar.show(
          'Success',
          'License added successfully!',
        );
        clearAllControllers();

        licenseList.value = await getAllLicenses(userId ?? "");
        licenseList.refresh();
      }
    } catch (e) {
      print("error in add license${e.toString()}");
      closeDialog();
      DefaultSnackbar.show(
        'Error',
        'Failed to add license: $e',
      );
    }
  }

  Future<List<License>> getAllLicenses(String? userId) async {
    if (userId == null || userId == '') {
      return [];
    }
    try {
      print('uid ${userId}');
      QuerySnapshot querySnapshot = await _firestore
          .collection('licenses')
          .doc(userId)
          .collection('userLicenses')
          .get();

      return querySnapshot.docs
          .map((doc) => License.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e.toString());
      DefaultSnackbar.show(
        'Error',
        'Failed to fetch licenses: $e',
      );
      return [];
    }
  }

  Future<void> editLicense(uid) async {
    try {
      if (licenseFormKey.currentState!.validate()) {
        if (licensePictures.isEmpty) {
          DefaultSnackbar.show(
              'Error', "Please Select at least one license picture");
          return;
        }
        Get.dialog(LoadingDialog());

        List<String> licensePicUrls = [];
        for (File picture in licensePictures) {
          String? picUrl = await uploadImage(picture);
          if (picUrl != null) {
            licensePicUrls.add(picUrl);
          }
        }

        License updatedLicense = License(
            uid: uid,
            licenseTrackingNumber: trackingNumberController.text,
            weaponNo:
                licenseList.value[selectedLicenseIndex.value].weaponNo ?? "",
            weaponUid:
                licenseList.value[selectedLicenseIndex.value].weaponUid ?? "",
            licenseNumber: licenseNumberController.text,
            documenttype: documentTypeController.text,
            licenseAmmunitionLimit: ammunitionLimitController.text,
            licenseDateOfIssuance: dateOfIssuanceController.text,
            licenseValidated: false,
            country: selectedCountry.value,
            licenseValidTill: validTillController.text,
            licenseIssuaingQuota: issuingQuota.value,
            licensePicture: licensePicUrls,
            licenseJurisdiction: jurisdiction.value,
            licenseCalibre: caliber.value,
            licenseweaponType: licenseWeaponType.value,
            licenseIssuingAuthority: issuingAuthority.value);

        DocumentReference licenseDoc = _firestore
            .collection('licenses')
            .doc(Get.find<HomeController>().userModel.value.uid ?? '')
            .collection('userLicenses')
            .doc(uid);

        await licenseDoc.update(updatedLicense.toMap());
        closeDialog();
        Get.back();
        DefaultSnackbar.show(
          'Success',
          'License updated successfully!',
        );
        licenseList.value = await getAllLicenses(
            Get.find<HomeController>().userModel.value.uid ?? "");
        clearAllControllers();
      }
    } catch (e) {
      print("error in edit license ${e.toString()}");
      closeDialog();
      DefaultSnackbar.show(
        'Error',
        'Failed to update license: $e',
      );
    }
  }

  Future<void> deleteLicense({
    required String userId,
    required String licenseId,
  }) async {
    try {
      Get.dialog(LoadingDialog());
      DocumentReference licenseDoc = _firestore
          .collection('licenses')
          .doc(userId)
          .collection('userLicenses')
          .doc(licenseId);

      await licenseDoc.delete();
      closeDialog();
      Get.back();
      DefaultSnackbar.show(
        'Success',
        'License deleted successfully!',
      );
      licenseList.value = await getAllLicenses(userId);
      clearAllControllers();
    } catch (e) {
      closeDialog();
      DefaultSnackbar.show(
        'Error',
        'Failed to delete license: $e',
      );
    }
  }

  void fillControllersWithDummyData() {
    if (kDebugMode) {
      trackingNumberController.text = 'TRK12345';
      licenseNumberController.text = 'LIC98765';
      documentTypeController.text = 'Firearm License';
      ammunitionLimitController.text = '100';
      dateOfIssuanceController.text = '01/09/2024';
      validTillController.text = '01/09/2025';
      issuingQuota.value = 'Federal Interior Minister';
      jurisdiction.value = 'All Pakistan';
      caliber.value = '9mm';
      licenseWeaponType.value = 'PISTOL';
      issuingAuthority.value = 'Sindh';
      // Dummy file paths
    }
  }

  void clearAllControllers() {
    trackingNumberController.clear();
    licenseNumberController.clear();
    documentTypeController.clear();
    ammunitionLimitController.clear();
    dateOfIssuanceController.clear();
    validTillController.clear();
    issuingQuota.value = "Federal Interior Minister"; // Reset to default value
    licensePictures.clear(); // Clear file selection
    jurisdiction.value = "All Pakistan"; // Reset to default value
    caliber.value = '9mm'; // Reset to default value
    licenseWeaponType.value = 'PISTOL'; // Reset to default value
    issuingAuthority.value = 'Sindh'; // Reset to default value
  }

  void fillAllDetailsWithSpecificLicense(License license) {
    trackingNumberController.text = license.licenseTrackingNumber ?? '';
    licenseNumberController.text = license.licenseNumber ?? '';
    documentTypeController.text = license.documenttype ?? '';
    ammunitionLimitController.text = license.licenseAmmunitionLimit ?? '';
    dateOfIssuanceController.text = license.licenseDateOfIssuance ?? '';
    validTillController.text = license.licenseValidTill ?? '';
    issuingQuota.value =
        license.licenseIssuaingQuota ?? 'Federal Interior Minister';
    jurisdiction.value = license.licenseJurisdiction ?? 'All Pakistan';
    caliber.value = license.licenseCalibre ?? '9mm';
    licenseWeaponType.value = license.licenseweaponType ?? 'PISTOL';
    issuingAuthority.value = license.licenseIssuingAuthority ?? 'Sindh';
    // Assuming licensePicture contains file paths
    licensePictures.value =
        license.licensePicture?.map((path) => File(path)).toList() ?? [];
  }

  Future<void> addLicensePicture() async {
    if (licensePictures.length >= 3) {
      DefaultSnackbar.show('Error', 'You can only add up to 3 pictures.');
      return;
    }

    String source = '';
    await showChoiceDialog(onCameraTap: () {
      source = "Camera";
      Get.back();
    }, onGalleryTap: () {
      source = "Gallery";
      Get.back();
    });
    if (source != '') {
      String? path = await pickImage(picker, source);
      if (path != null && path.isNotEmpty) {
        licensePictures.add(File(path)); // Add picture to the list
      }
    }
  }
}
