import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/widgets/shooter_record_widgets.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:intl/intl.dart';

class AddWeaponFiringRecord extends GetView<ShootingLogController> {
  // final controller controller = Get.find();

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    controller.timeController = TextEditingController(
        text: DateFormat('HH:mm a').format(DateTime.now()));
    controller.getCurrentLocation().then((value) {
      controller.rangeNameLocationController.text = value;
    });
    log(controller.rangeNameLocationController.text.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.height,
            BannerCard(
              title: 'FIRING RECORD',
              content: Form(
                key: controller.firingRecordKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFirearmDetailsSection(),
                    20.height,
                    _buildAmmunitionDetailsSection(),
                    20.height,
                    _buildRangeInformationSection(),
                    20.height,
                    _buildSessionDetailsSection(),
                    10.height,
                    // _buildAmmunitionStockNote(),
                    20.height,
                    _buildAddRecordButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Image.asset(
        "assets/images/guns-guru.png",
        height: 40,
      ),
      centerTitle: true,
      foregroundColor: Colors.white,
      backgroundColor: ColorHelper.primaryColor,
    );
  }

  // Firearm Details Section
  Widget _buildFirearmDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdownField(
          label: 'Firearm Make',
          selectedValue: controller.fireArmMake.value,
          items: AppConstants.make,
          onChanged: (String? value) {
            controller.fireArmMake.value = value ?? "";
          },
          isMandatory: true,
          isEnabled: !homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomDropdownField(
          label: 'Firearm Model',
          selectedValue: controller.fireArmModel.value,
          items: AppConstants.model.map((model) => model.model).toList(),
          onChanged: (String? value) {
            controller.fireArmModel.value = value ?? "";
          },
          isMandatory: true,
          isEnabled: !homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomDropdownField(
          label: 'Caliber',
          selectedValue: controller.caliber.value,
          items: AppConstants.caliberList,
          onChanged: (String? value) {
            controller.caliber.value = value ?? "";
          },
          isMandatory: true,
          isEnabled: !homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomTextField(
          label: 'Serial Number',
          controller: controller.serialNumberController,
          isMandatory: true,
          isEnabled: homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomDropdownField(
          label: 'Optics/Sights',
          selectedValue: controller.opticsSights.value,
          items: AppConstants.opticsorSights,
          onChanged: (String? value) {
            controller.opticsSights.value = value ?? "";
          },
          isEnabled: !homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomOptionalField(
          label: 'Accessories',
          controller: controller.accessoriesController,
          isEnabled: homeController.fromFiringRecordDetail.value,
        ),
      ],
    );
  }

  // Ammunition Details Section
  Widget _buildAmmunitionDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdownField(
          label: 'Ammo Brand',
          selectedValue: controller.ammunitionBrand.value,
          items: AppConstants.ammoBrand,
          onChanged: (String? value) {
            controller.ammunitionBrand.value = value ?? "";
          },
          isEnabled: !homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomOptionalField(
          label: 'Bullet Weight',
          controller: controller.bulletWeightController,
          isEnabled: homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomTextField(
          label: 'Bullet Type',
          controller: controller.bulletTypeController,
          isMandatory: true,
          isEnabled: homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomOptionalField(
          label: 'Muzzle Velocity',
          controller: controller.muzzleVelocityController,
          isEnabled: homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomOptionalField(
          label: 'Lot/Box Number',
          controller: controller.lotBoxNumberController,
          isEnabled: homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        CustomTextField(
          label: 'Notes',
          controller: controller.notesController,
          maxLines: 3,
          isEnabled: homeController.fromFiringRecordDetail.value,
        ),
      ],
    );
  }

  // Range Information Section
  Widget _buildRangeInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
            label: 'Range Location (GPS)',
            controller: controller.rangeNameLocationController,
            isMandatory: true,
            isEnabled: homeController.fromFiringRecordDetail.value,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Range Location is required';
              }
              final regex = RegExp(r'^\d+\.\d{4},\d+\.\d{4}$');
              if (!regex.hasMatch(value)) {
                return 'Enter a valid GPS location in the format XX.XXXX,YY.YYYY';
              }
              return null;
            }),
        10.height,
        CustomTextField(
          label: 'Date',
          controller: controller.dateController,
          isMandatory: true,
          isEnabled: homeController.fromFiringRecordDetail.value,
          onTap: () =>
              _selectDate(navigator!.context, controller.dateController),
        ),
        10.height,
        CustomTextField(
          label: 'Time',
          controller: controller.timeController,
          isMandatory: true,
          isEnabled: homeController.fromFiringRecordDetail.value,
          onTap: () =>
              _selectTime(navigator!.context, controller.timeController),
        ),
        10.height,

         CustomDropdownField(
          label: 'Weather Condition',
          selectedValue: controller.weatherConditionsController.value,
          items: AppConstants.weaponTypeList,
          onChanged: (String? value) {
            controller.weatherConditionsController.value = value ?? "";
          },
          isEnabled: !homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        WindDirectionSelector(
          selectedDirection: controller.windDirection,
          windSpeed: controller.windSpeed,
          onDirectionChanged: (newDirection) {
            if (newDirection != null) {
              controller.windDirection.value = newDirection;
            }
          },
          onSpeedChanged: (newSpeed) {
            controller.windSpeed.value = newSpeed;
          },
        ),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomOptionalField(
                isEnabled: !homeController.fromFiringRecordDetail.value,
                label: 'Temperature (C/F)',
                controller: controller.temperatureController,
              ),
            ),
            5.width,
            Center(
              child: CustomDropdown(
                selectedUnit: controller.selectedTempuratureUnit.value,
                units: const ['celsius', 'fahrenheit'],
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.selectedTempuratureUnit.value = newValue;
                  }
                },
              ),
            ),
          ],
        ),
        10.height,
        CustomTextField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Humidity',
          controller: controller.humidityController,
          suffix: Text("%"),
          isMandatory: true,
          inputType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter humidity';
            }
            final humidity = double.tryParse(value);
            if (humidity == null) {
              return 'Please enter a valid number';
            }
            if (humidity < 0 || humidity > 100) {
              return 'Humidity must be between 0 and 100%';
            }
            return null; // Input is valid
          },
        ),
        10.height,
        CustomOptionalField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Altitude (from sea level)',
          controller: controller.altitudeController,
          suffix: Text('ft'),
          inputType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return null;
            }
            final altitude = double.tryParse(value);
            if (altitude == null) {
              return 'Please enter a valid number';
            }
            if (altitude < 0) {
              return 'Altitude cannot be negative';
            }
            return null;
          },
        ),
        10.height,
        CustomDropdownField(
          isEnabled: !homeController.fromFiringRecordDetail.value,
          label: 'Terrain',
          selectedValue: controller.terrain.value,
          items: AppConstants.terrains,
          onChanged: (String? value) {
            controller.terrain.value = value ?? "";
          },
          isMandatory: true,
        ),
        10.height,
        CustomDropdownField(
          isEnabled: !homeController.fromFiringRecordDetail.value,
          label: 'Brightness',
          selectedValue: controller.brightness.value,
          items: AppConstants.brightnessLevel,
          onChanged: (String? value) {
            controller.brightness.value = value ?? "";
          },
          isMandatory: true,
        ),
        10.height,
        Row(
          children: [
            Expanded(
              child: Obx(() {
                return CustomTextField(
                  isEnabled: homeController.fromFiringRecordDetail.value,
                  label: 'Shooting Distance (yds/mtrs) *',
                  controller: controller.shootingDistanceController,
                  isMandatory: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a shooting distance';
                    }
                    final distance = double.tryParse(value);
                    if (distance == null) {
                      return 'Please enter a valid number';
                    }
                    if (distance < 0) {
                      return 'Distance cannot be negative';
                    }
                    return null; // Valid input
                  },
                );
              }),
            ),
            5.width,
            CustomDropdown(
              selectedUnit: controller.selectedShootingDistanceUnit.value,
              units: const ['meters', 'yards'],
              onChanged: (newValue) {
                if (newValue != null) {
                  controller.selectedShootingDistanceUnit.value = newValue;
                }
              },
            ),
          ],
        ),
        10.height,
        CustomDropdownField(
          isEnabled: !homeController.fromFiringRecordDetail.value,
          label: 'Target Type',
          selectedValue: controller.targetType.value,
          items: AppConstants.targetTypes,
          onChanged: (String? value) {
            controller.targetType.value = value ?? "";
          },
          isMandatory: true,
        ),
        10.height,
        CustomDropdownField(
          isEnabled: !homeController.fromFiringRecordDetail.value,
          label: 'Shooting Position',
          selectedValue: controller.shootingPosition.value,
          items: AppConstants.shootingPositions,
          onChanged: (String? value) {
            controller.shootingPosition.value = value ?? "";
          },
          isMandatory: true,
        ),
      ],
    );
  }

  // Session Details Section
  Widget _buildSessionDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Rounds Fired',
          controller: controller.roundsFiredController,
          isMandatory: true,
        ),
        10.height,
        CustomOptionalField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Shooting Drills/Exercises',
          controller: controller.shootingDrillsController,
        ),
        10.height,
        CustomOptionalField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Malfunctions/Issues',
          controller: controller.malfunctionsController,
        ),
        10.height,
        CustomTextField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Accuracy/Grouping',
          controller: controller.accuracyGroupingController,
          isMandatory: true,
        ),
        10.height,
        CustomOptionalField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Sight Adjustment',
          controller: controller.sightAdjustmentController,
        ),
        10.height,
        CustomOptionalField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Performance Observations',
          controller: controller.performanceObservationsController,
        ),
        10.height,
        CustomOptionalField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Lessons Learned',
          controller: controller.lessonsLearnedController,
        ),
        10.height,
        CustomTextField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Additional Notes',
          controller: controller.additionalNotesController,
          maxLines: 3,
        ),
      ],
    );
  }

  // Helper widgets
  Widget _buildAmmunitionStockNote() {
    LicenseController licenseController=Get.find();
    final remainingStock = calculateAmmunitionStock(licenseController
                .licenseList![licenseController.selectedLicenseIndex.value]
                .ammunitionDetail ??
            []) -
        calculateShotsFired(licenseController
                .licenseList[licenseController.selectedLicenseIndex.value]
                .weaponFiringRecord ??
            []);

    return Text(
      "Note: Your Remaining Firing Stock is $remainingStock",
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAddRecordButton() {
    return Visibility(
      visible: controller.homeController.fromFiringRecordDetail.isFalse,
      child: DarkButton(
        onTap: controller.addWeaponFiringRecord,
        text: 'Add Record',
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      controller.text =
          "${pickedDate.toLocal()}".split(' ')[0]; // Format the date if needed
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      // Format the selected time as HH:mm
      final formattedTime = pickedTime.format(context);
      controller.text = formattedTime;
    }
  }
}
