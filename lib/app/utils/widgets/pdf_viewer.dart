import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatelessWidget {
  String pdfPath;
  String title;
  PdfViewer({super.key, required this.pdfPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back,color: Colors.white)),
        centerTitle: true,
        backgroundColor: ColorHelper.primaryColor,
        title:  Text(title,style: const TextStyle(color: Colors.white),),
      ),
      body: SfPdfViewer.asset(
        pdfPath,
      )
    );
  }
}
