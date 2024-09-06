import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';

class ServiceRecordController extends GetxController {
  HomeController homeController = Get.find();
  RxList<ServiceRecord> serviceRecordList = <ServiceRecord>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxString weaponuid = ''.obs;
  RxString weaponNo = ''.obs;
  final serviceRecordKey = GlobalKey<FormState>();
  final serviceDateController = TextEditingController();
  final serviceNotesController = TextEditingController();
  TextEditingController retailerPhoneNo = TextEditingController();
  RxList servicePartsChangedList = [].obs;
  RxBool isBasicService = false.obs;
  RxBool isSelfService = false.obs;
  TextEditingController armorNameController = TextEditingController();
  TextEditingController armorAddressController = TextEditingController();
  TextEditingController armorPhoneNoController = TextEditingController();

  Future<void> getAllServiceRecords() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    QuerySnapshot querySnapshot = await _firestore
        .collection('servicerecord')
        .doc(userId)
        .collection('userservicerecord')
        .get();

    var records = querySnapshot.docs
        .map((doc) => ServiceRecord.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    serviceRecordList.assignAll(records);
    serviceRecordList.refresh();
  }

  Future<void> addServiceRecord() async {
    try {
      if (serviceRecordKey.currentState!.validate()) {
        // if (servicePartsChangedList.isEmpty) {
        //   DefaultSnackbar.show(
        //       'Error', "Please select at least one part changed");
        //   return;
        // }

        Get.dialog(LoadingDialog());

        ServiceRecord newServiceRecord = ServiceRecord(
            serviceDate: serviceDateController.text,
            partsChanged: servicePartsChangedList.value,
            serviceType:
                isBasicService.isTrue ? "Basic Service" : "Deatiled Service",
            selfOrArmorService:
                isSelfService.isTrue ? "Self Service" : "Armor Service",
            armorName: armorNameController.text,
            armorAddress: armorAddressController.text,
            armorphoneno: armorPhoneNoController.text,
            notes: serviceNotesController.text,
            weaponno: weaponNo.value,
            weaponuid: weaponuid.value,
            licenseno: "",
            licenseuid: "");

        CollectionReference userServiceRecordsCollection = _firestore
            .collection('servicerecord')
            .doc(Get.find<HomeController>().userModel.value.uid ?? '')
            .collection('userservicerecord');

        DocumentReference serviceRecordDocRef =
            await userServiceRecordsCollection.add(newServiceRecord.toMap());
        await serviceRecordDocRef.update({'uid': serviceRecordDocRef.id});
        closeDialog();
        Get.back();
        DefaultSnackbar.show(
          'Success',
          'Service record added successfully!',
        );
        await getAllServiceRecords();
      }
    } catch (e) {
      closeDialog();
      DefaultSnackbar.show(
        'Error',
        'Failed to add service record: $e',
      );
    }
  }

  populateData(ServiceRecord record) {
    weaponNo.value=record.weaponno??"";
    serviceDateController.text = record.serviceDate ?? "";
    armorPhoneNoController.text=record.armorphoneno??"";
    servicePartsChangedList.value = record.partsChanged ?? [];
    isBasicService.value = record.serviceType == "Basic Service" ? true : false;
    isSelfService.value =
        record.selfOrArmorService == "Self Service" ? true : false;
    armorNameController.text = record.armorName ?? "";
    armorAddressController.text = record.armorAddress ?? "";
    serviceNotesController.text = record.notes ?? "";
  }
}
