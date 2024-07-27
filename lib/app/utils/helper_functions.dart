import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:crypto/crypto.dart';

Future<String?> pickImage(ImagePicker picker) async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  return pickedFile!.path ?? "";
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
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

int calculateRemainingQuota(List<AmmunitionDetail> ammunition,int totalQuota){
   int stock= calculateAmmunitionStock(ammunition??[]);
   return totalQuota-stock;
}

int calculateShotsFired(List<WeaponFiringRecord> firingRecord){
  var shots=0;
  for (var detail in firingRecord) {
    shots += int.parse(detail.weaponFiringShotsFired ?? "0");
  }
  return shots;
}
