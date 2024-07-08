import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:crypto/crypto.dart';

Future<String> pickImage(ImagePicker picker) async {
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
