import 'package:flutter/material.dart';

class AdvanceShootingRecordView extends StatefulWidget {
  @override
  _AdvanceShootingRecordViewState createState() =>
      _AdvanceShootingRecordViewState();
}

class _AdvanceShootingRecordViewState extends State<AdvanceShootingRecordView> {
  DateTime date = DateTime.now();
  bool openDate = false;

  DateTime time = DateTime.now();
  bool openTime = false;

  DateTime datePur = DateTime.now();
  bool openDatePur = false;

  List<String> shootingRangeList = [];
  List<String> brandList = [];
  List<String> weatherConditionList = [];
  List<String> bulletTypeList = [];
  List<String> celsiusList = [];
  List<String> windDirectionList = [];
  List<String> terrainList = [];
  List<String> brightnessList = [];
  List<String> meterList = [];
  List<String> feetList = [];
  List<String> targetTypeList = [];
  List<String> shootingPositionList = [];

  List<Map<String, String>> shootingDistanceList = [
    {'label': 'Meter', 'value': 'meter'},
    {'label': 'Yards', 'value': 'yards'},
  ];

  String? selectedShootingDistance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shooting Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Date Picker
            ListTile(
              title: Text('Date: ${date.toLocal()}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  date = pickedDate;
                  setState(() {});
                }
              },
            ),

            // Time Picker
            ListTile(
              title: Text(
                  'Time: ${time.toLocal().toString().split(' ')[1].substring(0, 5)}'),
              trailing: Icon(Icons.access_time),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  time = pickedDate;
                  setState(() {});
                }
              },
            ),

            // Date of Purchase Picker
            ListTile(
              title: Text('Purchase Date: ${datePur.toLocal()}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  datePur = pickedDate;
                  setState(() {});
                }
              },
            ),

            // Dropdown Menus for Lists
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Shooting Range'),
              items: shootingRangeList.map((range) {
                return DropdownMenuItem<String>(
                  value: range,
                  child: Text(range),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Brand'),
              items: brandList.map((brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Weather Condition'),
              items: weatherConditionList.map((condition) {
                return DropdownMenuItem<String>(
                  value: condition,
                  child: Text(condition),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Bullet Type'),
              items: bulletTypeList.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Celsius'),
              items: celsiusList.map((temp) {
                return DropdownMenuItem<String>(
                  value: temp,
                  child: Text(temp),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Wind Direction'),
              items: windDirectionList.map((direction) {
                return DropdownMenuItem<String>(
                  value: direction,
                  child: Text(direction),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Terrain'),
              items: terrainList.map((terrain) {
                return DropdownMenuItem<String>(
                  value: terrain,
                  child: Text(terrain),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Brightness'),
              items: brightnessList.map((brightness) {
                return DropdownMenuItem<String>(
                  value: brightness,
                  child: Text(brightness),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Meter'),
              items: meterList.map((meter) {
                return DropdownMenuItem<String>(
                  value: meter,
                  child: Text(meter),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Feet'),
              items: feetList.map((feet) {
                return DropdownMenuItem<String>(
                  value: feet,
                  child: Text(feet),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Target Type'),
              items: targetTypeList.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Shooting Position'),
              items: shootingPositionList.map((position) {
                return DropdownMenuItem<String>(
                  value: position,
                  child: Text(position),
                );
              }).toList(),
              onChanged: (value) {
                // Handle selection
              },
            ),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Shooting Distance'),
              value: selectedShootingDistance,
              items: shootingDistanceList.map((distance) {
                return DropdownMenuItem<String>(
                  value: distance['value'],
                  child: Text(distance['label']!),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedShootingDistance = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
