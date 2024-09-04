import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
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
      var galleryFile = await picker.pickImage(source: ImageSource.gallery);
      if (galleryFile != null) {
        CroppedFile? croppedFile = await cropImage(galleryFile.path);
        if (croppedFile != null) {
          pickedFile = XFile(croppedFile!.path);
        }
      }
    } else {
      DefaultSnackbar.show("Error", "Please Allow Gallery Permission First");
    }
  } else {
    bool cameraPermission = await Permission.camera.request().isGranted;
    if (cameraPermission == true) {
      var cameraFile = await picker.pickImage(source: ImageSource.camera);
      if (cameraFile != null) {
        CroppedFile? croppedFile = await cropImage(cameraFile.path);
        if (croppedFile != null) {
          pickedFile = XFile(croppedFile!.path);
        }
      }
    } else {
      DefaultSnackbar.show("Error", "Please Allow Camera Permission First");
    }
  }

  return pickedFile!.path ?? "";
}

Future<CroppedFile?> cropImage(String path) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: ColorHelper.primaryColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
        ],
      ),
      IOSUiSettings(
        title: 'Cropper',
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio4x3,
        ],
      ),
    ],
  );
  return croppedFile;
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

Future<String> datePicker({DateTime? lastDate}) async {
  final DateTime? picked = await showDatePicker(
    context: navigator!.context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: lastDate ?? DateTime(2040),
  );

  if (picked != null) {
    var month = picked.month < 10 ? "0${picked.month}" : "${picked.month}";
    var day = picked.day < 10 ? "0${picked.day}" : "${picked.day}";
    return "$day/$month/${picked.year}";
  } else {
    return "";
  }
}

void closeDialog() {
  if (Get.isDialogOpen==true) {
    Get.back();
  }
}
  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp phoneRegExp = RegExp(r'^[0-9+]+$');
    return phoneRegExp.hasMatch(phoneNumber);
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
    shots += int.parse(detail.roundsFired ?? "0");
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

bool isAnyLicenseValidionExpire(List<License> licenses) {
  final currentDate = DateTime.now();
  final oneMonthFromNow = currentDate.add(Duration(days: 30));
  final dateFormat = DateFormat('dd/MM/yyyy');

  for (var license in licenses) {
    log(license.licenseValidTill!.toString());
    final licenseValidTill = dateFormat.parse(license.licenseValidTill!);

    if (currentDate.isAfter(licenseValidTill) ||
        licenseValidTill.isBefore(oneMonthFromNow)) {
      return true;
    }
  }

  return false;
}

bool checkLicenseValidation(License license) {
  final currentDate = DateTime.now();
  final oneMonthFromNow = currentDate.add(Duration(days: 30));
  final dateFormat = DateFormat('dd/MM/yyyy');

  log(license.licenseValidTill!.toString());
  final licenseValidTill = dateFormat.parse(license.licenseValidTill!);

  if (currentDate.isAfter(licenseValidTill) ||
      licenseValidTill.isBefore(oneMonthFromNow)) {
    return true;
  }

  return false;
}

bool checkIsAfterCurrentDate(License license) {
  final currentDate = DateTime.now();
  final dateFormat = DateFormat('dd/MM/yyyy');
  final licenseValidTill = dateFormat.parse(license.licenseValidTill!);

  if (currentDate.isAfter(licenseValidTill)) {
    print(licenseValidTill);
    print(currentDate);
    print("enterrrrrr");
    return true;
  }

  return false;
}

Future<File> urlToFile(String imageUrl) async {
  // Get the temporary directory
  final Directory tempDir = await getTemporaryDirectory();
  // Create a file path for the image
  final String filePath = '${tempDir.path}/temp_image.png';
  // Download the image
  final http.Response response = await http.get(Uri.parse(imageUrl));
  // Save the image as a file
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return file;
}



Future<String> uploadImage(File image) async {
    try {
      final path = 'user_images/${DateTime.now().millisecondsSinceEpoch}.png';
      final uploadTask = FirebaseStorage.instance.ref().child(path).putFile(image);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return '';
    }
  }