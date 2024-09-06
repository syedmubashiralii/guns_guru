import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/consultancy/subscription_charges_table.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/dialogs/signout_dialog.dart';
import 'package:guns_guru/app/utils/extensions.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
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
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: const Text('Rate Us'),
            onTap: () async {
              const url =
                  'https://your-app-store-link'; // Replace with your app's store link
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            onTap: () {
              Share.share('Check out this amazing app: https://your-app-link');
            },
          ),
          ListTile(
            leading: const Icon(Icons.web),
            title: const Text('Website'),
            onTap: () async {
              const url =
                  'https://your-website-link'; // Replace with your website link
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            onTap: () async {
              const url =
                  'https://your-privacy-policy-link'; // Replace with your privacy policy link
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms & Conditions'),
            onTap: () async {
              const url =
                  'https://your-terms-and-conditions-link'; // Replace with your terms and conditions link
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
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
