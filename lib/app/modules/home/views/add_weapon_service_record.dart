import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/widgets/weapon_detail_widget.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/banner_card.dart';
import 'package:guns_guru/app/utils/custom_radio_button.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';

class AddWeaponServiceRecord extends GetView<HomeExtensionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          "assets/images/guns-guru.png",
          height: 40,
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: ColorHelper.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weapon Service Record',
                style: TextStyle(fontWeight: FontWeight.w500)),
            10.height,
            WeaponDetailWidget(
              license: controller.homeController.userModel.value.license![
                  controller.homeController.selectedLicenseIndex.value],
              isButtonShown: false,
            ),
            20.height,
            BannerCard(
              title: 'SERVICE RECORD',
              content: Form(
                key: controller.serviceRecordKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      onTap: controller.homeController.fromServiceDetail.isTrue
                          ? () {}
                          : () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                controller.serviceDateController.text =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              }
                            },
                      readOnly:
                          true,
                      controller: controller.serviceDateController,
                      decoration: const InputDecoration(
                        labelText: 'Date',
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a date';
                        }
                        return null;
                      },
                    ),
                    20.height,
                    TextFormField(
                      readOnly:
                          controller.homeController.fromServiceDetail.value,
                      controller: controller.serviceDoneByController,
                      decoration: const InputDecoration(
                        labelText: 'Service Done By',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a service provider';
                        }
                        return null;
                      },
                    ),
                    20.height,
                    PartsChangedSection(),
                    20.height,
                    TextFormField(
                      readOnly:
                          controller.homeController.fromServiceDetail.value,
                      controller: controller.serviceNotesController,
                      decoration: const InputDecoration(
                        labelText: 'Notes (optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    20.height,
                    Visibility(
                      visible:
                          controller.homeController.fromServiceDetail.isFalse,
                      child: DarkButton(
                          onTap: controller.addWeaponServiceRecord,
                          text: 'Add Record'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PartsChangedSection extends GetView<HomeExtensionController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Any Parts Changed?",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        Wrap(
          children: [
            Obx(() {
              return CustomRadioButton(
                firePin1: controller.servicePartsChangedList.value
                        .contains('Fire Pin')
                    ? true
                    : false,
                onChanged: controller.homeController.fromServiceDetail.isTrue
                    ? (v) {}
                    : (v) {
                        if (v == true) {
                          controller.servicePartsChangedList.add('Fire Pin');
                        } else {
                          controller.servicePartsChangedList.remove('Fire Pin');
                        }
                      },
                title: 'Fire Pin',
              );
            }),
            Obx(() {
              return CustomRadioButton(
                firePin1:
                    controller.servicePartsChangedList.value.contains('Barrel')
                        ? true
                        : false,
                onChanged: controller.homeController.fromServiceDetail.isTrue
                    ? (v) {}
                    : (v) {
                        if (v == true) {
                          controller.servicePartsChangedList.add('Barrel');
                        } else {
                          controller.servicePartsChangedList.remove('Barrel');
                        }
                      },
                title: 'Barrel',
              );
            }),
          ],
        ),
      ],
    );
  }
}
