import 'package:image_picker/image_picker.dart';

Future<String> pickImage(ImagePicker picker) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      return pickedFile!.path??"";
  }

  bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}