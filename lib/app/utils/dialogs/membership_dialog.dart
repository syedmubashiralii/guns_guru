import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/views/auth/add_user_profile_view.dart';
import 'package:guns_guru/app/utils/dialogs/complete_profile_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';

class MembershipDialog extends StatefulWidget {
  @override
  _MembershipDialogState createState() => _MembershipDialogState();
}

class _MembershipDialogState extends State<MembershipDialog> {
  String userType = "Pakistani"; // Default selection
  String? selectedMembership;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Membership"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Radio<String>(
                value: "Pakistani",
                groupValue: userType,
                onChanged: (value) {
                  setState(() {
                    userType = value!;
                    selectedMembership = null;
                  });
                },
              ),
              const Text("Pakistani"),
              Radio<String>(
                value: "Non-Pakistani",
                groupValue: userType,
                onChanged: (value) {
                  setState(() {
                    userType = value!;
                    selectedMembership = null; // Reset membership on change
                  });
                },
              ),
              const Text("Non-Pakistani"),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "Select Membership:",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ..._getMembershipOptions(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (selectedMembership != null) {
              // Show confirmation dialog
              _showWhatsAppRedirectDialog(context);
            } else {
              // Show error if no membership is selected
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please select a membership."),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: const Text("Confirm"),
        ),
      ],
    );
  }

  List<Widget> _getMembershipOptions() {
    List<String> options = userType == "Pakistani"
        ? ["Platinum Membership", "Silver Membership"]
        : ["Gold Membership"];
    return options
        .map(
          (option) => RadioListTile<String>(
            title: Text(option),
            value: option,
            groupValue: selectedMembership,
            onChanged: (value) {
              setState(() {
                selectedMembership = value!;
              });
            },
          ),
        )
        .toList();
  }

  void _showWhatsAppRedirectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Redirecting to WhatsApp"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "We are redirecting you to our WhatsApp catalog to choose your membership and complete the payment. "
              "After making the payment, please send a screenshot to the same WhatsApp number. "
              "Once the admin verifies your information, you will gain access to this functionality.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            RichText(
                text: TextSpan(
                    text:
                        "If you encounter any issues, you can manually contact us at ",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                    children: [
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            const ClipboardData(text: "+923316662709"));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("WhatsApp number copied to clipboard."),
                          backgroundColor: Colors.green,
                        ));
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
                  )
                ])),
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
              Navigator.pop(context, selectedMembership);
              HomeController homeController = Get.find();
              if (homeController.userModel.value.phoneno == null ||
                  homeController.userModel.value.phoneno == '') {
                showUserDetailsDialog(context, () {
                  Get.to(() => AddUserProfileView(
                        isReadOnly: false,
                      ));
                });
              } else {
                redirectToWhatsApp("+923316662709",
                    message:
                        "Membership Name: ${selectedMembership}\n User Record ${homeController.userModel.value.toJson()}");
              }
              // Perform redirection logic here
            },
            child: const Text("Proceed to WhatsApp"),
          ),
        ],
      ),
    );
  }
}

// Function to show the Membership Dialog
void showMembershipDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => MembershipDialog(),
  ).then((selectedMembership) {
    if (selectedMembership != null) {
      // Handle the selected membership
      print("Selected Membership: $selectedMembership");
    }
  });
}
