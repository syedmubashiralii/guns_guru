import 'package:image_picker/image_picker.dart';

Future<String> pickImage(ImagePicker picker) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      return pickedFile!.path??"";
  }