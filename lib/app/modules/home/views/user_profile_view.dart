import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/cnic_test.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/home_controller.dart';

class UserProfileView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorHelper.primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'User Profile',
            style: TextStyle(color: Colors.white),
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
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name is required';
                          }
                          if (value.length > 50) {
                            return 'First Name cannot be longer than 50 characters';
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
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date of Birth is required';
                          }
                          return null;
                        },
                      ),
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
              DarkButton(
                onTap: controller.saveForm,
                text: "Submit",
              ),
              20.height,
            ],
          ),
        ),
      ),
    );
  }
}
