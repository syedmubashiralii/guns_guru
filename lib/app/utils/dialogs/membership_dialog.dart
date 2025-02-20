import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';

class MembershipPage extends GetView<HomeController> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> memberships = <Map<String, dynamic>>[].obs;

  MembershipPage({super.key});

  Future<void> loadMemberships() async {
    try {
      final snapshot = await firestore.collection('memberships').get();
      memberships.value = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; 
        return data;
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load memberships: $e');
    }
  }

  Future<void> _showWhatsAppRedirectDialog(BuildContext context, String membershipName) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Redirecting to WhatsApp"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Check out the subscription options from our WhatsApp catalog. We are redirecting you to WhatsApp where you can communicate with us directly. Select your preferred membership, make the payment, and send a screenshot to the same WhatsApp number. Once your membership is updated, you will be able to enjoy the associated perks. For the best experience, please restart your app after your membership is updated. If you are not automatically redirected to WhatsApp, you can contact us manually using the WhatsApp number provided below.", 
              
              
              
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Clipboard.setData(const ClipboardData(text: "+923316662709"));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("WhatsApp number copied to clipboard."),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text(
                "+923316662709",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              HomeController homeController = Get.find();
              final user = homeController.userModel.value;

              final userDetails = {
                'First Name': user.firstname,
                'Last Name': user.lastname,
                'Email': user.email,
                'Phone': user.phoneno,
                'Gender': user.gender,
                'Date of Birth': homeController.formatDate(user.dob),
                'Address': user.address,
                'City': user.city,
                'State': user.state,
                'Country': user.country,
                'Country Code': user.countrycode,
                'CNIC': user.cnic,
                'Document Issuance Date': homeController.formatDate(user.documentIssuanceDate),
                'Document Expiry Date': homeController.formatDate(user.documentExpiryDate),
                'Membership': user.memberShip,
                'Membership Date': homeController.formatDate(user.membershipDate),
                'Membership Expiry Date': homeController.formatDate(user.membershipExpiryDate),
              };

              final filteredDetails = userDetails.entries
                  .where((entry) => entry.value != null && entry.value!.isNotEmpty)
                  .map((entry) => '${entry.key}: ${entry.value}')
                  .join('\n');

              final message = "Membership Name: $membershipName\n\nUser Details:\n$filteredDetails";
              redirectToWhatsApp("+923316662709", message: message);
            },
            child: const Text("Proceed to WhatsApp"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    loadMemberships(); // Load memberships when the widget builds

    return Scaffold(
       appBar: AppBar(
          title: Text('Membership'),
          centerTitle: true,
          foregroundColor: Colors.white,
          backgroundColor: ColorHelper.primaryColor,
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Membership", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    final membership = controller.userModel.value.memberShip ?? "None";
                    return Text("Membership: $membership", style: const TextStyle(fontSize: 14));
                  }),
                  const SizedBox(height: 20),
                  const Text(
                    "Choose Membership", 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Obx(() {
                    if (memberships.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: memberships.length,
                      itemBuilder: (context, index) {
                        final membership = memberships[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.blue.shade200),
                          ),
                          child: ListTile(
                            title: Text(
                              membership['name'] ?? 'No Name',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Type: ${membership['type'] ?? 'Unknown'}'),
                                Text('Description: ${membership['description'] ?? 'No Description'}'),
                              ],
                            ),
                            onTap: () => _showWhatsAppRedirectDialog(context, membership['name'] ?? 'Unknown'),
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 
