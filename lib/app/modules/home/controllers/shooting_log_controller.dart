import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class ShootingLogController extends GetxController {
  HomeController homeController = Get.find();
  final firingRecordKey = GlobalKey<FormState>();

  // Controllers for the mandatory fields
  RxString fireArmMake = "".obs;
  RxString fireArmModel = "".obs;
  RxString caliber = ''.obs;
  TextEditingController serialNumberController = TextEditingController();
  RxString opticsSights = ''.obs;
  TextEditingController accessoriesController = TextEditingController();
  RxString ammunitionBrand = ''.obs;
  TextEditingController bulletWeightController = TextEditingController();
  TextEditingController bulletTypeController = TextEditingController();
  TextEditingController muzzleVelocityController = TextEditingController();
  TextEditingController lotBoxNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController rangeNameLocationController = TextEditingController();
  TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController timeController =
      TextEditingController(text: DateFormat('HH:mm').format(DateTime.now()));
  RxString weatherConditionsController = ''.obs;
  final RxString windDirection = 'N'.obs;
  final RxDouble windSpeed = 0.0.obs;
  TextEditingController temperatureController = TextEditingController();
  RxString selectedTempuratureUnit = "celsius".obs;
  TextEditingController humidityController = TextEditingController();
  TextEditingController altitudeController = TextEditingController();
  RxString terrain = ''.obs;
  RxString brightness = ''.obs;
  // RxDouble shootingDistance = 100.0.obs;
  TextEditingController shootingDistanceController = TextEditingController();
  RxString selectedShootingDistanceUnit = 'yards'.obs;
  RxString targetType = ''.obs;
  RxString shootingPosition = ''.obs;
  TextEditingController roundsFiredController = TextEditingController();
  TextEditingController malfunctionsController = TextEditingController();
  TextEditingController shootingDrillsController = TextEditingController();
  TextEditingController accuracyGroupingController = TextEditingController();
  TextEditingController sightAdjustmentController = TextEditingController();
  TextEditingController performanceObservationsController =
      TextEditingController();
  TextEditingController lessonsLearnedController = TextEditingController();
  TextEditingController additionalNotesController = TextEditingController();
  RxString selectedWindSpeedUnit = 'km/hr'.obs;

  Future<void> addWeaponFiringRecord() async {
    if (firingRecordKey.currentState?.validate() ?? false) {
      Get.dialog(const LoadingDialog());
      Map<String, dynamic> firingRecord = {
        AppConstants.UID: FirebaseAuth.instance.currentUser?.uid ??
            Get.find<HomeController>().userModel.value.uid ??
            "",
        AppConstants.fireArmMake: fireArmMake.value,
        AppConstants.fireArmModel: fireArmModel.value,
        AppConstants.caliber: caliber.value,
        AppConstants.serialNumber: serialNumberController.text,
        AppConstants.opticsSights: opticsSights.value,
        AppConstants.accessories: accessoriesController.text,
        AppConstants.ammunitionBrand: ammunitionBrand.value,
        AppConstants.bulletWeight: bulletWeightController.text,
        AppConstants.bulletType: bulletTypeController.text,
        AppConstants.muzzleVelocity: muzzleVelocityController.text,
        AppConstants.lotBoxNumber: lotBoxNumberController.text,
        AppConstants.notes: notesController.text,
        AppConstants.rangeNameLocation: rangeNameLocationController.text,
        AppConstants.date: dateController.text,
        AppConstants.time: timeController.text,
        AppConstants.weatherConditions: weatherConditionsController.value,
        AppConstants.windDirection: windDirection.value,
        AppConstants.windSpeed: windSpeed.value,
        AppConstants.temperature: temperatureController.text,
        AppConstants.selectedTempuratureUnit: selectedTempuratureUnit.value,
        AppConstants.humidity: humidityController.text,
        AppConstants.altitude: altitudeController.text,
        AppConstants.terrain: terrain.value,
        AppConstants.brightness: brightness.value,
        AppConstants.shootingDistance: shootingDistanceController.text,
        AppConstants.selectedShootingDistanceUnit:
            selectedShootingDistanceUnit.value,
        AppConstants.targetType: targetType.value,
        AppConstants.shootingPosition: shootingPosition.value,
        AppConstants.roundsFired: roundsFiredController.text,
        AppConstants.malfunctions: malfunctionsController.text,
        AppConstants.shootingDrills: shootingDrillsController.text,
        AppConstants.accuracyGrouping: accuracyGroupingController.text,
        AppConstants.sightAdjustment: sightAdjustmentController.text,
        AppConstants.performanceObservations:
            performanceObservationsController.text,
        AppConstants.selectedWindSpeedUnit: selectedWindSpeedUnit.value,
        AppConstants.lessonsLearned: lessonsLearnedController.text,
        AppConstants.additionalNotes: additionalNotesController.text,
      };

      try {
        // Check ammunition stock before adding record
        // if (calculateAmmunitionStock(homeController
        //                 .userModel
        //                 .value
        //                 .license?[homeController.selectedLicenseIndex.value]
        //                 .ammunitionDetail ??
        //             []) -
        //         calculateShotsFired(homeController
        //                 .userModel
        //                 .value
        //                 .license?[homeController.selectedLicenseIndex.value]
        //                 .weaponFiringRecord ??
        //             []) <
        //     int.parse(roundsFiredController.text)) {
        //   DefaultSnackbar.show("Error",
        //       "The number of shots fired should not exceed the remaining stock. Please check your stock levels.");
        //   closeDialog();
        //   return;
        // }

        // Add firing record to Firestore
        await FirebaseFirestore.instance
            .collection('shooterlogs')
            .add(firingRecord);
        await getShooterLogs();
        clearAllFields();
        addLogWithLicense();

        // Optionally, update user model or perform additional operations here

        closeDialog();
        Get.back();
      } catch (e) {
        closeDialog();
        print(e.toString());
      }
    }
  }

  addLogWithLicense() {
    var controller = Get.find<HomeController>();
    var selectedLicenseNumber = controller.userModel.value
        .license![controller.selectedLicenseIndex.value].licenseNumber;

    var filteredLogs = shooterLogList
        .where((log) => log.serialNumber == selectedLicenseNumber)
        .toList();
    controller.userModel.value.license![controller.selectedLicenseIndex.value]
        .weaponFiringRecord = filteredLogs;
    controller.userModel.refresh();
  }

  RxList<WeaponFiringRecord> shooterLogList = <WeaponFiringRecord>[].obs;

  Future<void> getShooterLogs() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('shooterlogs')
        .where('uid', isEqualTo: userId)
        .get();

    var records = querySnapshot.docs
        .map((doc) =>
            WeaponFiringRecord.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

    shooterLogList.assignAll(records);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getShooterLogs();
  }

  void populateFieldsForEditing(WeaponFiringRecord record) {
    fireArmMake.value = record.fireArmMake ?? "";
    fireArmModel.value = record.fireArmModel ?? "";
    caliber.value = record.caliber ?? "";
    serialNumberController.text = record.serialNumber ?? "";
    opticsSights.value = record.opticsSights ?? "";
    accessoriesController.text = record.accessories ?? "";
    ammunitionBrand.value = record.ammunitionBrand ?? "";
    bulletWeightController.text = record.bulletWeight ?? "";
    bulletTypeController.text = record.bulletType ?? "";
    muzzleVelocityController.text = record.muzzleVelocity ?? "";
    lotBoxNumberController.text = record.lotBoxNumber ?? "";
    notesController.text = record.notes ?? "";
    rangeNameLocationController.text = record.rangeNameLocation ?? "";
    dateController.text =
        record.date ?? DateFormat('yyyy-MM-dd').format(DateTime.now());
    timeController.text =
        record.time ?? DateFormat('HH:mm').format(DateTime.now());
    selectedWindSpeedUnit.value = record.selectedWindSpeedUnit ?? "km/hr";
    weatherConditionsController.value = record.weatherConditions ?? "";
    windDirection.value = record.windDirection ?? 'N';
    windSpeed.value = record.windSpeed ?? 0.0;
    temperatureController.text = record.temperature ?? "";
    selectedTempuratureUnit.value = record.selectedTemperatureUnit ?? "celsius";
    humidityController.text = record.humidity ?? "";
    altitudeController.text = record.altitude ?? "";
    terrain.value = record.terrain ?? "";
    brightness.value = record.brightness ?? "";
    shootingDistanceController.text =
        record.shootingDistance.toString() ?? " 100.0";
    selectedShootingDistanceUnit.value =
        record.selectedShootingDistanceUnit ?? 'yards';
    targetType.value = record.targetType ?? "";
    shootingPosition.value = record.shootingPosition ?? "";
    roundsFiredController.text = record.roundsFired ?? "";
    malfunctionsController.text = record.malfunctions ?? "";
    shootingDrillsController.text = record.shootingDrills ?? "";
    accuracyGroupingController.text = record.accuracyGrouping ?? "";
    sightAdjustmentController.text = record.sightAdjustment ?? "";
    performanceObservationsController.text =
        record.performanceObservations ?? "";
    lessonsLearnedController.text = record.lessonsLearned ?? "";
    additionalNotesController.text = record.additionalNotes ?? "";
  }

  void clearAllFields() {
    // Clear all the RxString and RxDouble fields
    fireArmMake.value = "";
    fireArmModel.value = "";
    caliber.value = "";
    opticsSights.value = "";
    ammunitionBrand.value = "";
    windDirection.value = "N";
    windSpeed.value = 0.0;
    selectedTempuratureUnit.value = "celsius";
    terrain.value = "";
    brightness.value = "";
    shootingDistanceController.text = "";
    selectedShootingDistanceUnit.value = 'yards';
    targetType.value = "";
    shootingPosition.value = "";

    // Clear all the TextEditingControllers
    serialNumberController.clear();
    accessoriesController.clear();
    bulletWeightController.clear();
    bulletTypeController.clear();
    muzzleVelocityController.clear();
    lotBoxNumberController.clear();
    notesController.clear();
    rangeNameLocationController.clear();
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    timeController.text = DateFormat('HH:mm').format(DateTime.now());
    weatherConditionsController.value='';
    temperatureController.clear();
    humidityController.clear();
    altitudeController.clear();
    roundsFiredController.clear();
    malfunctionsController.clear();
    shootingDrillsController.clear();
    accuracyGroupingController.clear();
    sightAdjustmentController.clear();
    performanceObservationsController.clear();
    lessonsLearnedController.clear();
    additionalNotesController.clear();
  }

  Future<String> getCurrentLocation() async {
    // Create a Location instance
    final Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        DefaultSnackbar.show("Error",
            "Please enable location service inorder to automatically fetch location");
        return "";
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        DefaultSnackbar.show("Error", "Location Permission Denied");
        return "";
      }
    }
    LocationData locationData = await location.getLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      return "";
    }
    String formattedLocation =
        '${locationData.latitude!.toStringAsFixed(4)},${locationData.longitude!.toStringAsFixed(4)}';

    return formattedLocation;
  }
}
