import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/dark_button.dart';
import 'package:nb_utils/nb_utils.dart';

class LicenseDetailsForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController issuingAuthorityController =
      TextEditingController();
  final TextEditingController trackingNumberController =
      TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController ammunitionLimitController =
      TextEditingController();
  final TextEditingController dateOfIssuanceController =
      TextEditingController();
  final TextEditingController validTillController = TextEditingController();
  final TextEditingController issuanceQuotaController = TextEditingController();

  String weaponType = 'Anti Material';
  String jurisdiction = 'All Pakistan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryColor,
        foregroundColor: Colors.white,
        title: const Text('Add License Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              10.height,
              TextFormField(
                controller: issuingAuthorityController,
                decoration: const InputDecoration(
                  labelText: 'Issuing Authority',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Issuing Authority is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: trackingNumberController,
                decoration: const InputDecoration(
                  labelText: 'Tracking Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tracking Number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: licenseNumberController,
                decoration: const InputDecoration(
                  labelText: 'License Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'License Number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: ammunitionLimitController,
                decoration: const InputDecoration(
                  labelText: 'Ammunition Limit',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ammunition Limit is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: weaponType,
                decoration: const InputDecoration(
                  labelText: 'Weapon Type',
                  border: OutlineInputBorder(),
                ),
                items: ['Anti Material', 'Carbine'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  weaponType = newValue!;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Weapon Type is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: dateOfIssuanceController,
                decoration: const InputDecoration(
                  labelText: 'Date of Issuance',
                  border: OutlineInputBorder(),
                  hintText: 'DD/MM/YYYY',
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date of Issuance is required';
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
                controller: validTillController,
                decoration: const InputDecoration(
                  labelText: 'Valid Till',
                  border: OutlineInputBorder(),
                  hintText: 'DD/MM/YYYY',
                ),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Valid Till is required';
                  }
                  RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                  if (!dateRegex.hasMatch(value)) {
                    return 'Please enter a valid date format: DD/MM/YYYY';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: jurisdiction,
                decoration: const InputDecoration(
                  labelText: 'Jurisdiction',
                  border: OutlineInputBorder(),
                ),
                items:
                    ['All Pakistan', 'Provincial - Punjab'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  jurisdiction = newValue!;
                },
                validator: (value) {
                  if (value == null) {
                    return 'Jurisdiction is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: issuanceQuotaController,
                decoration: const InputDecoration(
                  labelText: 'Issuance Quota',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Issuance Quota is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement file picker here
                },
                child: const Text('Upload License Picture'),
              ),
              const SizedBox(height: 20),
              DarkButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data
                  }
                },
                text: "Submit",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
