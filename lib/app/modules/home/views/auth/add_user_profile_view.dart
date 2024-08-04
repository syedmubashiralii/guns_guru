import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import '../../controllers/home_controller.dart';

class AddUserProfileView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorHelper.primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'User Profile',
            style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ListView(
                    children: [
                      20.height,
                      TextFormField(
                        controller: controller.nameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Full Name is required';
                          }
                          if (value.length > 50) {
                            return 'Full Name cannot be longer than 50 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: controller.cnicController,
                        decoration: const InputDecoration(
                            labelText: 'CNIC',
                            border: OutlineInputBorder(),
                            hintText: '1111-1111111-1'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'CNIC is required';
                          }
                          if (!RegExp(r'^\d{5}-\d{7}-\d{1}$').hasMatch(value)) {
                            return 'CNIC must be in the format 11111-1111111-1';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: controller.dobController,
                          decoration: const InputDecoration(
                              labelText: 'Date of Birth',
                              border: OutlineInputBorder(),
                              hintText: 'DD/MM/YYYY'),
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                          onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime(1990,1,1),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                controller.dobController.text =
                                    "${pickedDate.day<10?'0${pickedDate.day}':pickedDate.day}/${pickedDate.month<10?'0${pickedDate.month}':pickedDate.month}/${pickedDate.year}";
                              }
                            },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date of Birth is required';
                            }
                            RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                            if (!dateRegex.hasMatch(value)) {
                              return 'Please enter a valid date format: DD/MM/YYYY';
                            }
                            List<String> parts = value.split('/');
                            if (parts.length != 3 ||
                                parts.any((part) => !isNumeric(part))) {
                              return 'Date must be in numeric format: DD/MM/YYYY';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: controller.addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is required';
                          }
                          if (value.length > 100) {
                            return 'Address cannot be longer than 100 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: controller.cityController,
                        decoration: const InputDecoration(
                          labelText: 'City',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'City is required';
                          }
                          if (value.length > 50) {
                            return 'City cannot be longer than 50 characters';
                          }
                          return null;
                        },
                      ),
                      20.height,
                    ],
                  ),
                ),
              ),
              10.height,
              SizedBox(
                width: Get.width,
                child: DarkButton(
                  onTap: controller.saveForm,
                  text: "Submit",
                ),
              ),
              20.height,
            ],
          ),
        ),
      ),
    );
  }
}
