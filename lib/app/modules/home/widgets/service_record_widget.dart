   import 'package:flutter/material.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';

Widget buildServiceRecord(
      String date, String serviceType, String weaponNO) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Date',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceType,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Service Type',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weaponNO,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Weapon',
                  ),
                ],
              ),
            ),
            5.width,
            CircleAvatar(
                radius: 10,
                backgroundColor: Colors.black.withOpacity(.7),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 12,
                )),
            5.width,
          ],
        ),
        5.height,
        const Divider(),
        5.height,
      ],
    );
  }

