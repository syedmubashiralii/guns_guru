import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/views/auth/add_user_profile_view.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/dialogs/signout_dialog.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:guns_guru/app/utils/widgets/pdf_viewer.dart';
import 'package:guns_guru/app/utils/widgets/web_browser.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDrawer extends GetView<HomeController> {
  const AppDrawer({Key? key}) : super(key: key);

  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: const BoxDecoration(
                color: ColorHelper.primaryColor,
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/app-icon.png"))),
                  ),
                  10.height,
                  const Text(
                    "GUNS GURU",
                    style: TextStyle(color: Colors.white),
                  ),
                  0.height,
                  FutureBuilder<String>(
                      future: getAppVersion(),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        return Text(
                          'App Version: ${snapshot.data}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        );
                      }),
                ],
              )),
          // ListTile(
          //   leading: const Icon(Icons.star_rate),
          //   title: const Text('Rate Us'),
          //   onTap: () async {
          //     const url =
          //         'https://your-app-store-link'; // Replace with your app's store link
          //     if (await canLaunchUrl(Uri.parse(url))) {
          //       await launchUrl(Uri.parse(url));
          //     } else {
          //       throw 'Could not launch $url';
          //     }
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.share),
          //   title: const Text('Share App'),
          //   onTap: () {
          //     Share.share('Check out this amazing app: https://your-app-link');
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('User Agreement'),
            onTap: () async {
              Get.to(PdfViewer(
                pdfPath: "assets/docs/USER_AGREEMENT_FOR_GUNS_GURU.pdf",
                title: "User Agreement",
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () async {
              const url =
                  'https://sites.google.com/view/gunsguru-privacy-policy/home'; // Replace with your privacy policy link
              // if (await canLaunchUrl(Uri.parse(url))) {
              //   await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication,);
              // } else {
              //   throw 'Could not launch $url';
              // }
              Get.to(WebBrowser(initialUrl: url));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('User Manual'),
            onTap: () async {
              Get.to(PdfViewer(
                pdfPath: "assets/docs/Guns_Guru_User_Manual.pdf",
                title: "User Manual",
              ));
            },
          ),
          ListTile(
            leading:  Icon(
              Icons.remove_red_eye,
              
            ),
            title: const Text('View Profile'),
            onTap: () {
               controller.firstNameController.text =
                controller.userModel.value.firstname ?? "";
            controller.lastNameController.text =
                controller.userModel.value.lastname ?? "";
            controller.cnicController.text =
                controller.userModel.value.cnic ?? "";
            controller.dobController.text =
                controller.userModel.value.dob ?? "";
            controller.phoneNoTextEditingController.text =
                controller.userModel.value.phoneno ?? "";
            controller.addressController.text =
                controller.userModel.value.address ?? "";
            controller.cityController.text =
                controller.userModel.value.city ?? "";
            controller.selectedCountryCode.value =
                controller.userModel.value.countrycode ?? "";
            controller.selectedGender.value =
                controller.userModel.value.gender ?? "MALE";
            controller.emailController.text =
                controller.userModel.value.email ?? "";
            controller.documentExpiryDate.text =
                controller.userModel.value.documentExpiryDate ?? "";
            controller.documentIssuanceDate.text =
                controller.userModel.value.documentIssuanceDate ?? "";
            controller.selectedState.value =
                controller.userModel.value.state ?? "";
            Get.to(()=> AddUserProfileView(isReadOnly: false,));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            title: const Text('Delete Account'),
            onTap: () {
              Get.find<HomeController>()
                  .showDeleteConfirmationDialog(context, () {});
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.money),
          //   title: const Text('Subscritpion Charges'),
          //   onTap: () async {
          //     Get.to(SubscriptionChargesTable());
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              showSignOutDialog();
            },
          ),
        ],
      ),

      // shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.all(0),
      //     ),
    );
  }
}
