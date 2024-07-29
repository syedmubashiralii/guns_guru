import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showChoiceDialog(
    {required VoidCallback onCameraTap, required VoidCallback onGalleryTap}) {
  return Get.dialog(
    AlertDialog(
      title: const Text("Choose option"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            GestureDetector(
              onTap: onCameraTap,
              child: const Row(
                children: [
                  Icon(Icons.camera),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Text("Camera"),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            GestureDetector(
              onTap: onGalleryTap,
              child: const Row(
                children: [
                  Icon(Icons.photo_album),
                  Padding(padding: EdgeInsets.all(8.0)),
                  Text("Gallery"),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
