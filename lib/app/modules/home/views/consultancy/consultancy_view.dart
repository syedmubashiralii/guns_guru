import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/consultancy_controller.dart';
import 'package:guns_guru/app/modules/home/views/consultancy/consultancy_service_detail.dart';
import 'package:guns_guru/app/utils/app_colors.dart';

class ConsultancyView extends StatelessWidget {
  ConsultancyView({super.key});

  final ConsultancyController controller = Get.put(ConsultancyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar: AppBar(
          backgroundColor: ColorHelper.primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset(
            "assets/images/guns-guru.png",
            height: 40,
          ),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _buildConsultancySection(controller),
      ),
    );
  }

  Widget _buildConsultancySection(
      ConsultancyController consultancyController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "CONSULTANCY SERVICES",
          style: TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black, fontSize: 17),
        ),
        const SizedBox(height: 10),
        Obx(() {
          if (consultancyController.consultancyList.isEmpty) {
            consultancyController.fetchConsultancyData();
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            shrinkWrap: true, // To prevent infinite height error
            physics:
                const NeverScrollableScrollPhysics(), // Disable internal scrolling
            itemCount: consultancyController.consultancyList.length,
            itemBuilder: (context, index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text('${index + 1}.'),
                  title: Text(consultancyController.consultancyList[index].name),
                  subtitle: Text(consultancyController
                      .consultancyList[index].description),
                  trailing: IconButton(
                    onPressed: () {
                      consultancyController.selectedConsultancyIndex.value =
                          index;
                      Get.to(const ConsultancyServiceDetail());
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
