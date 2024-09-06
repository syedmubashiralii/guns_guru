import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/utils/extensions.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isMandatory;
  final VoidCallback? onTap;
  final int? maxLines;
  final bool isEnabled;
  final FormFieldValidator<String>? validator;
  Widget? suffix;
  TextInputType? inputType;

  CustomTextField({
    required this.label,
    required this.controller,
    this.isMandatory = false,
    this.maxLines,
    this.inputType,
    this.suffix,
    this.onTap,
    this.isEnabled = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: inputType ?? TextInputType.name,
          readOnly: isEnabled,
          controller: controller,
          onTap: onTap,
          maxLines: maxLines ?? 1,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Enter $label',
            suffix: suffix,
          ),
          validator: validator ??
              (isMandatory
                  ? (value) {
                      if (value == null || value.isEmpty) {
                        return '$label is required';
                      }
                      return null;
                    }
                  : null),
        ),
      ],
    );
  }
}

class CustomOptionalField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  bool isEnabled;
  final FormFieldValidator<String>? validator;
  Widget? suffix;
  TextInputType? inputType;

  CustomOptionalField(
      {required this.label,
      required this.controller,
      this.isEnabled = false,
      this.validator,
      this.inputType,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: inputType ?? TextInputType.name,
          readOnly: isEnabled,
          controller: controller,
          decoration: InputDecoration(
            suffix: suffix,
            border: const OutlineInputBorder(),
            hintText: 'Enter $label',
          ),
          validator: validator ?? null,
        ),
      ],
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String label;
  final String? selectedValue;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool isMandatory;
  final bool isEnabled;

  CustomDropdownField(
      {required this.label,
      required this.selectedValue,
      required this.items,
      required this.onChanged,
      this.isMandatory = false,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        DropdownSearch<String>(
          enabled: isEnabled,
          popupProps: const PopupProps.menu(
            showSearchBox: true, // Enables the search box in the dropdown
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search', // Generic label for search
              ),
            ),
          ),
          items: items, // The list of values
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              hintText: label,
              border: const OutlineInputBorder(),
            ),
          ),
          selectedItem: selectedValue,

          onChanged: onChanged,
          validator: isMandatory
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '$label is required';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String selectedUnit;
  final List<String> units;
  final Function(String?) onChanged;

  CustomDropdown(
      {required this.selectedUnit,
      required this.units,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedUnit,
      onChanged: onChanged,
      underline: const SizedBox(),
      items: units.map((String unit) {
        return DropdownMenuItem<String>(
          value: unit,
          child: Text(unit),
        );
      }).toList(),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final Function(double) onChanged;
  final String unit;

  CustomSlider(
      {required this.value, required this.onChanged, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: value,
            min: 1,
            max: 5000,
            inactiveColor: Colors.grey,
            divisions: 5000,
            onChanged: onChanged,
            label: '${value.toStringAsFixed(0)} $unit',
          ),
        ),
      ],
    );
  }
}

class WindDirectionSelector extends StatelessWidget {
  final RxString selectedDirection;
  final RxDouble windSpeed;
  final Function(String?) onDirectionChanged;
  final Function(double) onSpeedChanged;
  bool isEnabled;

  WindDirectionSelector(
      {required this.selectedDirection,
      required this.windSpeed,
      required this.onDirectionChanged,
      required this.onSpeedChanged,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    final List<String> directions = [
      'N',
      'NE',
      'E',
      'SE',
      'S',
      'SW',
      'W',
      'NW'
    ];
    ShootingLogController controller = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Wind Direction',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        5.height,
        DropdownButtonFormField(
          value: selectedDirection.value,
          items: directions.map((direction) {
            return DropdownMenuItem<String>(
              value: direction,
              child: Text(direction),
            );
          }).toList(),
          onChanged: onDirectionChanged,
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        Obx(() {
          return Text(
            'Wind Speed ${controller.selectedWindSpeedUnit.value} *',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          );
        }),
        Row(
          children: [
            Expanded(
              child: Obx(() {
                return Slider(
                  value: windSpeed.value,
                  min: 0,
                  max: 100, // Adjust the max value based on your needs
                  onChanged: onSpeedChanged,
                  divisions: 100,
                  label: '${windSpeed.value.toStringAsFixed(1)}',
                );
              }),
            ),
            const SizedBox(width: 10),
            Obx(() {
              return DropdownButton<String>(
                value: controller.selectedWindSpeedUnit.value,
                items: const [
                  DropdownMenuItem(
                    value: 'km/hr',
                    child: Text('km/hr'),
                  ),
                  DropdownMenuItem(
                    value: 'miles/hr',
                    child: Text('miles/hr'),
                  ),
                ],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    controller.selectedWindSpeedUnit.value = newValue;
                  }
                },
              );
            }),
          ],
        ),
      ],
    );
  }
}
