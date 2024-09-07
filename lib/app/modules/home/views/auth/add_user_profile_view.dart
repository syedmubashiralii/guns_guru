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
      body: Obx(() {
        return Padding(
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
                          return IntlPhoneField(
                            initialCountryCode:
                                controller.selectedCountryCode.value,
                                initialValue: controller.phoneNoTextEditingController.text,
                            invalidNumberMessage:
                                "Phone number is not valid".tr,
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
                              controller.selectedCountryCode.value =
                                  country.code;
                            },
                          );
                        }),
                        20.height,
                        TextFormField(
                          controller: controller.emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                            hintText: 'john@gmail.com',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            RegExp emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          return TextFormField(
                            controller: controller.cnicController,
                            decoration: InputDecoration(
                                labelText:
                                    controller.selectedCountryCode.value != "PK"
                                        ? 'DL/PAL/License no'
                                        : 'CNIC NO',
                                border: const OutlineInputBorder(),
                                hintText:
                                    controller.selectedCountryCode.value != "PK"
                                        ? 'Enter DL/PAL/License no'
                                        : '1111-1111111-1'),
                            keyboardType:
                                controller.selectedCountryCode.value == "PK"
                                    ? TextInputType.number
                                    : TextInputType.text,
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
                                    : 'DL/PAL/License no is required';
                              }
                              if (!RegExp(r'^\d{5}-\d{7}-\d{1}$')
                                      .hasMatch(value) &&
                                  controller.selectedCountryCode.value ==
                                      "PK") {
                                return 'CNIC must be in the format 11111-1111111-1';
                              }

                              return null;
                            },
                          );
                        }),
                        if (controller.selectedCountryCode.value != "PK")
                          20.height,
                        if (controller.selectedCountryCode.value != "PK")
                          TextFormField(
                            readOnly: true,
                            controller: controller.documentIssuanceDate,
                            decoration: const InputDecoration(
                              labelText: 'Document Issuing Date',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                              hintText: 'DD/MM/YYYY',
                            ),
                            onTap: () async {
                              controller.documentIssuanceDate.text =
                                  await datePicker(lastDate: DateTime.now());
                            },
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Document issuing date is required';
                              }
                              RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                              if (!dateRegex.hasMatch(value)) {
                                return 'Please enter a valid date format: DD/MM/YYYY';
                              }
                              return null;
                            },
                          ),
                        if (controller.selectedCountryCode.value != "PK")
                          20.height,
                        if (controller.selectedCountryCode.value != "PK")
                          TextFormField(
                            readOnly: true,
                            controller: controller.documentExpiryDate,
                            decoration: const InputDecoration(
                              labelText: 'Document Expiry Date',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.date_range),
                              hintText: 'DD/MM/YYYY',
                            ),
                            onTap: () async {
                              controller.documentExpiryDate.text =
                                  await datePicker();
                            },
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Document expiry date is required';
                              }
                              RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                              if (!dateRegex.hasMatch(value)) {
                                return 'Please enter a valid date format: DD/MM/YYYY';
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
                         if (controller.selectedCountryCode.value == "CA" ||
                            controller.selectedCountryCode.value == "US")
                          20.height,
                        if (controller.selectedCountryCode.value == "CA" ||
                            controller.selectedCountryCode.value == "US")
                          Obx(() {
                            return DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSearchBox:
                                    true, // Enables the search box in the dropdown
                                searchFieldProps: const TextFieldProps(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Search States',
                                  ),
                                ),
                                itemBuilder: (context, item, isSelected) {
                                  return ListTile(
                                    title: SizedBox(
                                      width: Get.width * .6,
                                      child: Text(
                                        item,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              items: controller.selectedCountryCode.value ==
                                      "US"
                                  ? AppConstants.usStates
                                  : AppConstants
                                      .canadianProvincesAndTerritories, // The list of makes to display
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: 'State/Province',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              selectedItem: controller.selectedState.value,
                              onChanged: (newValue) {
                                controller.selectedState.value = newValue!;
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'State/Province is required';
                                }
                                return null;
                              },
                            );
                          }),
                        if (controller.selectedCountryCode.value == "CA" ||
                            controller.selectedCountryCode.value == "US")
                          const SizedBox(height: 20),
                        if (controller.selectedCountryCode.value == "CA" ||
                            controller.selectedCountryCode.value == "US")
                          TextFormField(
                            // controller: controller.cityController,
                            readOnly: true,
                            initialValue:
                                controller.selectedCountryCode.value == "CA"
                                    ? "Canada"
                                    : "United States",

                            decoration: const InputDecoration(
                              labelText: 'Country',
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                          ),
                        20.height,
                        DropdownButtonFormField<String>(
                          value: controller.selectedGender.value,
                          decoration: const InputDecoration(
                            labelText: 'Gender',
                            border: OutlineInputBorder(),
                          ),
                          items: ['MALE', 'FEMALE','PREFER NOT TO MENTION']
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
        );
      }),
    );
  }
}
