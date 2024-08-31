import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../controllers/home_controller.dart';

class AddUserProfileView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.phoneNoTextEditingController.text = "+92";
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorHelper.primaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'User Profile',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
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
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.firstNameController,
                              decoration: const InputDecoration(
                                labelText: 'First Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'First Name is required';
                                }
                                if (value.length > 25) {
                                  return 'First Name cannot be longer than 25 characters';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10.0), // Space between fields
                          Expanded(
                            child: TextFormField(
                              controller: controller.lastNameController,
                              decoration: const InputDecoration(
                                labelText: 'Last Name',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Last Name is required';
                                }
                                if (value.length > 25) {
                                  return 'Last Name cannot be longer than 25 characters';
                                }
                                return null;
                              },
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return TextFormField(
                          controller: controller.cnicController,
                          decoration: InputDecoration(
                              labelText:
                                  controller.selectedCountryCode.value != "PK"
                                      ? 'ID NO'
                                      : 'CNIC NO',
                              border: const OutlineInputBorder(),
                              hintText:
                                  controller.selectedCountryCode.value != "PK"
                                      ? 'Enter ID NO'
                                      : '1111-1111111-1'),
                          keyboardType: TextInputType.number,
                          inputFormatters:
                              controller.selectedCountryCode.value != "PK"
                                  ? []
                                  : [
                                      MaskTextInputFormatter(
                                        mask: '#####-#######-#',
                                        filter: {"#": RegExp(r'[0-9]')},
                                      )
                                    ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return controller.selectedCountryCode.value ==
                                      "PK"
                                  ? 'CNIC NO is required'
                                  : 'ID NO is required';
                            }
                            if (!RegExp(r'^\d{5}-\d{7}-\d{1}$')
                                    .hasMatch(value) &&
                                controller.selectedCountryCode.value == "PK") {
                              return 'CNIC must be in the format 11111-1111111-1';
                            }

                            return null;
                          },
                        );
                      }),
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
                              initialDate: DateTime(1990, 1, 1),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              controller.dobController.text =
                                  "${pickedDate.day < 10 ? '0${pickedDate.day}' : pickedDate.day}/${pickedDate.month < 10 ? '0${pickedDate.month}' : pickedDate.month}/${pickedDate.year}";
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
                      Obx(() {
                        return IntlPhoneField(
                          initialCountryCode:
                              controller.selectedCountryCode.value,
                          invalidNumberMessage: "Phone number is not valid".tr,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14.0),
                            border: const OutlineInputBorder(),
                            hintText: "Phone Number".tr,
                            counterText: "",
                          ),
                          onChanged: (phone) {
                            controller.phoneNoTextEditingController.text =
                                phone.completeNumber;
                            log(controller.selectedCountryCode.value);
                            try {
                              controller.isPhoneNumberValid.value =
                                  phone.isValidNumber();
                            } catch (e) {
                              controller.isPhoneNumberValid.value = false;
                            }
                          },
                          onCountryChanged: (country) {
                            if (kDebugMode) {
                              print('Country changed to: ${country.code}');
                            }
                            controller.selectedCountryCode.value = country.code;
                          },
                        );
                      }),
                      // const SizedBox(height: 20),
                      // Obx(() {
                      //   return DropdownSearch<String>(
                      //     popupProps: const PopupProps.menu(
                      //       showSearchBox:
                      //           true, // Enables the search box in the dropdown
                      //       searchFieldProps: TextFieldProps(
                      //         decoration: InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           labelText: 'Search Country',
                      //         ),
                      //       ),
                      //     ),
                      //     items: AppConstants.ALL_COUNTRIES_ALPHA_2.keys
                      //         .toList(), // The list of issuing authorities
                      //     dropdownDecoratorProps: const DropDownDecoratorProps(
                      //       dropdownSearchDecoration: InputDecoration(
                      //         labelText: 'Country',
                      //         border: OutlineInputBorder(),
                      //       ),
                      //     ),
                      //     selectedItem: controller.selectedCountryCode.value,
                      //     onChanged: (newValue) {
                      //       controller.selectedCountryCode.value = newValue!;
                      //       print("Country changed to: ${controller.selectedCountryCode.value}");
                      //     },
                      //     dropdownBuilder: (context, selectedItem) => SizedBox(
                      //       width: Get.width * .6,
                      //       child: Text(
                      //         selectedItem ?? '',
                      //         overflow: TextOverflow.ellipsis,
                      //       ),
                      //     ),
                      //     validator: (value) {
                      //       if (value == null) {
                      //         return 'Selected Country is required';
                      //       }
                      //       return null;
                      //     },
                      //   );
                      // }),

                      const SizedBox(height: 20),
                      TextFormField(
                        controller: controller.addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
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
                        inputFormatters: [
                          UpperCaseTextFormatter(),
                        ],
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
                      DropdownButtonFormField<String>(
                        value: controller.selectedGender.value,
                        decoration: const InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
                        items: ['MALE', 'FEMALE']
                            .map((gender) => DropdownMenuItem<String>(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedGender.value = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                      ),
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
