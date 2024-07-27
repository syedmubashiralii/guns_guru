import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomLabelText extends StatelessWidget {
  const CustomLabelText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
          color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 9),
    );
  }
}