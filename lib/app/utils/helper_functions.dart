import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crypto/crypto.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String?> pickImage(ImagePicker picker, String source) async {
  var pickedFile;
  if (source == "Gallery") {
    bool galleryPermission = false;
    if (Platform.isIOS) {
      PermissionStatus permissionStatus = await Permission.photos.request();
      if (permissionStatus.isGranted || permissionStatus.isLimited) {
        galleryPermission = true;
      }
    } else {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      galleryPermission = deviceInfo.version.sdkInt > 32
          ? await Permission.photos.request().isGranted
          : await Permission.storage.request().isGranted;
    }
    if (galleryPermission == true) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else {
      DefaultSnackbar.show("Error", "Please Allow Gallery Permission First");
    }
  } else {
    bool cameraPermission = await Permission.camera.request().isGranted;
    if (cameraPermission == true) {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    } else {
      DefaultSnackbar.show("Error", "Please Allow Camera Permission First");
    }
  }

  return pickedFile!.path ?? "";
}

Future<bool> galleryPermission() async {
  bool storagePermission = false;

  return storagePermission;
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

bool isNumericInt(String s) {
  if (s == null) {
    return false;
  }
  return int.tryParse(s) != null;
}

String sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

Future<String> datePicker() async {
  final DateTime? picked = await showDatePicker(
    context: navigator!.context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    var month = picked.month < 10 ? "0${picked.month}" : "${picked.month}";
    var day = picked.day < 10 ? "0${picked.day}" : "${picked.day}";
    return "$day/$month/${picked.year}";
  } else {
    return "";
  }
}

closeDialog() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}

int calculateAmmunitionStock(List<AmmunitionDetail> ammunition) {
  var total = 0;
  for (var detail in ammunition) {
    total += int.parse(detail.ammunitionQuantityPurchased ?? "0");
  }
  return total;
}

int calculateRemainingQuota(List<AmmunitionDetail> ammunition, int totalQuota) {
  int stock = calculateAmmunitionStock(ammunition ?? []);
  return totalQuota - stock;
}

int calculateShotsFired(List<WeaponFiringRecord> firingRecord) {
  var shots = 0;
  for (var detail in firingRecord) {
    shots += int.parse(detail.weaponFiringShotsFired ?? "0");
  }
  return shots;
}


void sendSMS(String phoneNumber, String message) async {
    final smsUri = 'sms:$phoneNumber?body=${Uri.encodeComponent(message)}';
    if (await canLaunchUrl(Uri.parse(smsUri))) {
      await launchUrl(Uri.parse(smsUri));
    } else {
      throw 'Could not launch $smsUri';
    }
  }