
import 'package:flutter/material.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/custom_label_text.dart';

class BuildFiringRecord extends StatelessWidget {
  BuildFiringRecord(
      {super.key,
      required this.date,
      required this.time,
      required this.shotsFired});
  String date;
  String time;
  String shotsFired;

  @override
  Widget build(BuildContext context) {
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
                    time,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Time',
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shotsFired,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const CustomLabelText(
                    text: 'Shots Fired',
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
}
