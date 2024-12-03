import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/widgets/shooter_record_widgets.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/dialogs/add_ammo_stock_dialog.dart';
import 'package:guns_guru/app/utils/widgets/banner_card.dart';
import 'package:guns_guru/app/utils/widgets/dark_button.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:intl/intl.dart';

class AddShooterLog extends GetView<ShootingLogController> {
  AddShooterLog({super.key});
  HomeController homeController = Get.find();
  WeaponController weaponController = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (weaponController.ammunitionList.isEmpty) {
        showAddAmmoDialog(context);
      }
      else{
        controller.ammunitionBrand.value=weaponController.ammunitionList.value.first.ammunitionBrand??"";
      }
    });

    if (controller.homeController.fromFiringRecordDetail.value == false) {
      controller.dateController = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
      controller.timeController = TextEditingController(
          text: DateFormat('HH:mm a').format(DateTime.now()));
      // controller.getCurrentLocation().then((value) {
      //   controller.rangeNameLocationController.text = value;
      // });
      log(controller.rangeNameLocationController.text.toString());
      if (weaponController.weaponList.isEmpty) {
        controller.fireArmMake.value =
            weaponController.weaponList[0].weaponMake ?? "";
        controller.fireArmModel.value =
            weaponController.weaponList[0].weaponModel ?? "";
        controller.caliber.value =
            weaponController.weaponList[0].weaponCaliber ?? "";
        controller.weaponuid.value = weaponController.weaponList[0].uid ?? "";
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        controller: controller.scrollController,
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
                    10.height,
                    _addShootingPlace(),
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

  Widget _addShootingPlace() {
    return Obx(() {
      return InkWell(
        onTap: controller.addShootingRangePicture,
        child: controller.shootingRangePictures.isEmpty
            ? Container(
                height: 80,
                width: Get.width,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text("Add Bullseye Target Pictures (optional)"),
                  ],
                ),
              )
            : Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.shootingRangePictures.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Image.file(
                                controller.shootingRangePictures[index],
                                height: 200,
                                width: 150,
                                fit: BoxFit.contain,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.shootingRangePictures
                                        .removeAt(index); // Remove picture
                                  },
                                  child: const Icon(Icons.remove_circle,
                                      color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    if (controller.shootingRangePictures.length < 3)
                      DarkButton(
                          onTap: controller.addShootingRangePicture,
                          text: "Add")
                  ],
                ),
              ),
      );
    });
  }

  // Firearm Details Section
  Widget _buildFirearmDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdownField(
          label: 'Weapon Number',
          selectedValue: controller.weaponNo.value,
          items: weaponController.weaponList.value
                  .map((weapon) => weapon.weaponNo ?? "")
                  .toList() ??
              [],
          onChanged: (String? value) async {
            controller.weaponNo.value = value ?? "";
            final selectedWeapon = weaponController.weaponList.value.firstWhere(
                (weapon) => weapon.weaponNo == value,
                orElse: () => WeaponDetails());

            controller.fireArmMake.value = selectedWeapon.weaponMake ?? "";
            controller.fireArmModel.value = selectedWeapon.weaponModel ?? "";
            controller.caliber.value = selectedWeapon.weaponCaliber ?? "";
            controller.weaponuid.value = selectedWeapon.uid ?? "";
            controller.typeofRound.value='';
            await weaponController.loadAmmos(weaponNo:controller.weaponNo.value);
            controller.ammunitionBrand.value=weaponController.ammunitionList.value.first.ammunitionBrand??"";
          },
          isMandatory: true,
          isEnabled: !homeController.fromFiringRecordDetail.value,
        ),
        10.height,
        Obx(() {
          return CustomDropdownField(
            label: 'Firearm Make',
            selectedValue: controller.fireArmMake.value,
            items: AppConstants.make,
            onChanged: (String? value) {
              controller.fireArmMake.value = value ?? "";
            },
            isMandatory: true,
            isEnabled: false ?? !homeController.fromFiringRecordDetail.value,
          );
        }),
        10.height,
        Obx(() {
          return CustomDropdownField(
            label: 'Firearm Model',
            selectedValue: controller.fireArmModel.value,
            items: AppConstants.model.map((model) => model.model).toList(),
            onChanged: (String? value) {
              controller.fireArmModel.value = value ?? "";
            },
            isMandatory: false,
            isEnabled: false ?? !homeController.fromFiringRecordDetail.value,
          );
        }),
        10.height,
        Obx(() {
          return CustomDropdownField(
            label: 'Firearm Caliber',
            selectedValue: controller.caliber.value,
            items: AppConstants.caliberList,
            onChanged: (String? value) {
              controller.caliber.value = value ?? "";
            },
            isMandatory: true,
            isEnabled: false ?? !homeController.fromFiringRecordDetail.value,
          );
        }),
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
        Obx(
         () {
            return CustomDropdownField(
              label: 'Ammo Brand',
              selectedValue: controller.ammunitionBrand.value,
              items: weaponController.ammunitionList
                      .map((ammo) => ammo.ammunitionBrand ?? "")
                      .toSet()
                      .toList() ??
                  [],
              isMandatory: true,
              onChanged: (String? value) {
                controller.ammunitionBrand.value = value ?? "";
              },
              isEnabled: !homeController.fromFiringRecordDetail.value,
            );
          }
        ),
        10.height,
        Obx(
          () {
            return CustomDropdownField(
              label: 'Type of Round',
              selectedValue: controller.typeofRound.value,
              items: controller.ammunitionBrand.value.isEmpty
                  ? weaponController.ammunitionList
                      .map((ammo) => ammo.typeOfRound ?? "")
                      .toSet()
                      .toList()
                  : weaponController.ammunitionList
                      .where((ammo) =>
                          ammo.ammunitionBrand == controller.ammunitionBrand.value)
                      .map((ammo) => ammo.typeOfRound ?? "")
                      .toSet()
                      .toList(),
              isMandatory: true,
              onChanged: (String? value) {
                controller.typeofRound.value = value ?? "";
              },
              isEnabled: !homeController.fromFiringRecordDetail.value,
            );
          }
        ),

        10.height,
        CustomOptionalField(
          label: 'Bullet Weight',
          controller: controller.bulletWeightController,
          isEnabled: homeController.fromFiringRecordDetail.value,
        ),
        // 10.height,
        // CustomTextField(
        //   label: 'Bullet Type',
        //   controller: controller.bulletTypeController,
        //   isMandatory: true,
        //   isEnabled: homeController.fromFiringRecordDetail.value,
        // ),
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
        if (AppConstants.isPakistani)
          CustomDropdownField(
            isEnabled: !homeController.fromFiringRecordDetail.value,
            label: 'Shooting Range',
            selectedValue: controller.shootingRange.value,
            items: AppConstants.shootingRanges,
            onChanged: (String? value) {
              controller.shootingRange.value = value ?? "";
          
            },
            isMandatory: false,
          ),
        if (AppConstants.isPakistani)
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
                "Note: If you don't see your shooting range in the list or if you are shooting at a different location, then Select Other Option, please add the location by turning on your GPS. Click the button below to fetch your location."),
          ),
        if (AppConstants.isPakistani) 10.height,
        Obx(
          () {
            return controller.shootingRange.value=='Other'||AppConstants.isPakistani==false? CustomTextField(
              label: 'Range Location (GPS)',
              controller: controller.rangeNameLocationController,
              isMandatory: true,
              isEnabled: homeController.fromFiringRecordDetail.value,
              suffix:
                  controller.homeController.fromFiringRecordDetail.value == false
                      ? DarkButton(
                          onTap: () async {
                            controller.rangeNameLocationController.text =
                                await controller.getCurrentLocation();
                          },
                          text: "Fetch Location")
                      : const SizedBox(),
              validator: (value) {
                if (AppConstants.isPakistani&&controller.shootingRange.value!='Other') {
                  return null;
                }
                if (value == null || value.isEmpty) {
                  return 'Range Location is required';
                }
            
                // // Regular expression for GPS coordinates validation
                // final regex = RegExp(
                //   r'^(-?([1-8]?\d(\.\d+)?|90(\.0+)?))\s*,\s*(-?(1[0-7]\d(\.\d+)?|180(\.0+)?))$',
                //   caseSensitive: false,
                //   multiLine: false,
                // );
            
                // if (!regex.hasMatch(value)) {
                //   return 'Enter a valid GPS location in the format XX.XXXX,YY.YYYY';
                // }
                return null;
              },
            ):SizedBox();
          }
        ),
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
          items: AppConstants.weatherConditionsList,
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
        ),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomOptionalField(
                isEnabled: homeController.fromFiringRecordDetail.value,
                label: 'Temperature (C/F)',
                controller: controller.temperatureController,
              ),
            ),
            5.width,
            Center(
              child: Obx(() {
                return CustomDropdown(
                  selectedUnit: controller.selectedTempuratureUnit.value,
                  units: const ['celsius', 'fahrenheit'],
                  onChanged: (newValue) {
                    if (newValue != null) {
                      controller.selectedTempuratureUnit.value = newValue;
                    }
                  },
                );
              }),
            ),
          ],
        ),
        10.height,
        CustomTextField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Humidity',
          controller: controller.humidityController,
          suffix: const Text("%"),
          isMandatory: false,
          inputType: TextInputType.number,
          validator: (value) {
            // if (value == null || value.isEmpty) {
            //   return 'Please enter humidity';
            // }
            // final humidity = double.tryParse(value);
            // if (humidity == null) {
            //   return 'Please enter a valid number';
            // }
            // if (humidity < 0 || humidity > 100) {
            //   return 'Humidity must be between 0 and 100%';
            // }
            // return null; // Input is valid
          },
        ),
        10.height,
        CustomOptionalField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Altitude (from sea level)',
          controller: controller.altitudeController,
          
          suffix: const Text('ft'),
          inputType: TextInputType.number,
          validator: (value) {
            // if (value == null || value.isEmpty) {
            //   return null;
            // }
            // final altitude = double.tryParse(value);
            // if (altitude == null) {
            //   return 'Please enter a valid number';
            // }
            // if (altitude < 0) {
            //   return 'Altitude cannot be negative';
            // }
            // return null;
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
          isMandatory: false,
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
          isMandatory: false,
        ),
        10.height,
        Row(
          children: [
            Expanded(
              child: Obx(() {
                return CustomTextField(
                  isEnabled: homeController.fromFiringRecordDetail.value,
                  label: 'Shooting Distance (yds/mtrs) ',
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
            Obx(() {
              return CustomDropdown(
                selectedUnit: controller.selectedShootingDistanceUnit.value,
                units: const ['meters', 'yards'],
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.selectedShootingDistanceUnit.value = newValue;
                  }
                },
              );
            }),
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
          isMandatory: false,
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
          isMandatory: false,
        ),
      ],
    );
  }

  // Session Details Section
  Widget _buildSessionDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.height,
        CustomTextField(
          isEnabled: homeController.fromFiringRecordDetail.value,
          label: 'Rounds Fired',
          controller: controller.roundsFiredController,
          inputType: TextInputType.number,
          isMandatory: true,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Rounds Fired is required';
            }
            final intValue = int.tryParse(value);
            if (intValue == null) {
              return 'Please enter a valid integer';
            }
            return null;
          },
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
          isMandatory: false,
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
    LicenseController licenseController = Get.find();
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
