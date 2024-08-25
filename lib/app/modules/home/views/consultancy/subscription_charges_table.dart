import 'package:flutter/material.dart';
import 'package:guns_guru/app/utils/app_colors.dart';

class SubscriptionChargesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: ColorHelper.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Subscription Charges'),
      ),
     
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Number of Licenses')),
            DataColumn(label: Text('Full Subscription Fee / Year (incl. 1 year license renewal fee)')),
            DataColumn(label: Text('Subscription Fee for Shooters & Service Log / Year')),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('Rs. 5,500')),
              DataCell(Text('Rs. 1,850')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Rs. 9,000')),
              DataCell(Text('Rs. 3,000')),
            ]),
            DataRow(cells: [
              DataCell(Text('3')),
              DataCell(Text('Rs. 12,500')),
              DataCell(Text('Rs. 4,000')),
            ]),
            DataRow(cells: [
              DataCell(Text('4')),
              DataCell(Text('Rs. 15,750')),
              DataCell(Text('Rs. 5,000')),
            ]),
            DataRow(cells: [
              DataCell(Text('5')),
              DataCell(Text('Rs. 19,500')),
              DataCell(Text('Rs. 6,000')),
            ]),
            DataRow(cells: [
              DataCell(Text('Each additional')),
              DataCell(Text('Rs. 3,500')),
              DataCell(Text('Rs. 900')),
            ]),
          ],
        ),
      ),
    );
  }
}