import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
   CustomContainer({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
                padding: const EdgeInsets.all(16.0),
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: child,
                );
  }
}