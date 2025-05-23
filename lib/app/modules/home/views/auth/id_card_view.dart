// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
// import 'package:guns_guru/app/utils/app_colors.dart';
// import 'package:guns_guru/app/utils/widgets/dark_button.dart';
// import 'package:guns_guru/app/utils/extensions.dart';

// class IDCardScreen extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: ColorHelper.primaryColor,
//           centerTitle: true,
//           title: const Text(
//             'Upload ID Card',
//             style: TextStyle(color: Colors.white, fontSize: 15),
//           )),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             10.height,
//             const Text(
//               "Import Front Side of NIC",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             5.height,
//             GestureDetector(
//               onTap: () => controller.pickAndSetImage(true),
//               child: Obx(() {
//                 return controller.frontImage.value == null
//                     ? Image.asset(
//                         'assets/images/cnic_front.png',
//                         height: 200,
//                         width: double.infinity,
//                         fit: BoxFit.contain,
//                       )
//                     : Image.file(
//                         controller.frontImage.value!,
//                         height: 200,
//                         width: double.infinity,
//                         fit: BoxFit.contain,
//                       );
//               }),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Import Back Side of NIC",
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//             5.height,
//             GestureDetector(
//               onTap: () => controller.pickAndSetImage(false),
//               child: Obx(() {
//                 return controller.backImage.value == null
//                     ? Image.asset(
//                         'assets/images/cnic_back.png',
//                         height: 200,
//                         width: double.infinity,
//                         fit: BoxFit.contain,
//                       )
//                     : Image.file(
//                         controller.backImage.value!,
//                         height: 200,
//                         width: double.infinity,
//                         fit: BoxFit.contain,
//                       );
//               }),
//             ),
//             const Spacer(),
//             SizedBox(
//               width: Get.width,
//               child: DarkButton(
//                 onTap: controller.loadRecordFromCard,
//                 text: "Upload",
//               ),
//             ),
//             20.height,
//           ],
//         ),
//       ),
//     );
//   }
// }
