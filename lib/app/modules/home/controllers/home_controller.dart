import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guns_guru/app/modules/home/controllers/cnic_scanner.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/models/cnic_model.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/auth_view.dart';
import 'package:guns_guru/app/modules/home/views/add_license_view.dart';
import 'package:guns_guru/app/modules/home/views/license_list_view.dart';
import 'package:guns_guru/app/modules/home/views/splash_view.dart';
import 'package:guns_guru/app/modules/home/views/user_profile_view.dart';
import 'package:guns_guru/app/modules/home/views/id_card_view.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final licenseFormKey = GlobalKey<FormState>();
  final weaponFormKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ImagePicker picker = ImagePicker();
  final firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);
  RxInt selectedLicenseIndex = 0.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  ///license Fields
  TextEditingController trackingNumberController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController ammunitionLimitController = TextEditingController();
  TextEditingController dateOfIssuanceController = TextEditingController();
  TextEditingController validTillController = TextEditingController();
  //weapon fields
  TextEditingController weaponTypeController = TextEditingController();
  TextEditingController weaponNumberController = TextEditingController();

  RxString caliber = '9mm'.obs;
  RxString issuingAuthority = "Sindh Home Department".obs;
  RxString jurisdiction = "All Pakistan".obs;
  RxString issuaingQuota = "CM Quota".obs;
  Rx<File?> licensePicture = Rx<File?>(null);
  RxString weaponCaliber = "9mm".obs;
  RxString weaponMake = "Make".obs;
  RxString weaponModel = "Model".obs;

  //
  // RxMap<String, dynamic>? userModel;
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    isUserLogged();
    Get.put(HomeExtensionController());
  }

  Future<bool> isUserLogged() async {
    //  await firebaseAuth.signOut();
    User? firebaseUser = getLoggedFirebaseUser();
    await Future.delayed(const Duration(seconds: 3));
    if (firebaseUser == null) {
      Get.off(const AuthView());
      return true;
    } else {
      await loadUserData(firebaseUser.uid);
      onLoginSuccesfull();

      return false;
    }
  }

  onLoginSuccesfull() {
    if (userModel.value.cnicFrontSide != null &&
        userModel.value.cnicFrontSide!.isNotEmpty) {
      if (userModel.value.fullname != null &&
          userModel.value.fullname!.isNotEmpty) {
        if (userModel.value.license != null &&
            userModel.value.license!.isNotEmpty) {
          Get.to(const LicenseListView());
        } else {
          Get.to(AddLicenseView());
        }
      } else {
        Get.off(UserProfileView());
      }
    } else {
      Get.off(IDCardScreen());
    }
  }

  User? getLoggedFirebaseUser() {
    return firebaseAuth.currentUser;
  }

  Future<void> signInWithGoogle({bool isSignUpRequired = false}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      Get.dialog(const LoadingDialog(), barrierDismissible: false);
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth == null) {
        if (Get.isDialogOpen!) {
          Get.back();
        }
        return;
      }
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("google signed in ${userCredential.user!.uid}");

      User? currentUser = FirebaseAuth.instance.currentUser!;
      await loadUserData(currentUser.uid);
      if (Get.isDialogOpen!) {
        Get.back();
      }
      onLoginSuccesfull();
    } catch (e) {
      print("error in signing with google : $e");
      if (Get.isDialogOpen!) {
        Get.back();
      }
      if (!e.toString().contains('popup_closed_by_user')) {
        DefaultSnackbar.show("Error",  e.toString());
      }
    }
  }

  Future<void> signInWithApple({bool isSignUpRequired = false}) async {
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      // Trigger the authentication flow
      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
        nonce: nonce,
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      if (kDebugMode) {
        print("apple signed in ${userCredential.user!.uid}");
      }
      User? currentUser = FirebaseAuth.instance.currentUser!;
      await loadUserData(currentUser.uid);
      if (Get.isDialogOpen!) {
        Get.back();
      }
      onLoginSuccesfull();
    } catch (e) {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      if (!e.toString().contains('popup_closed_by_user')) {
        DefaultSnackbar.show('Error',  e.toString());
      }
      if (kDebugMode) {
        print("error in signing with google : $e");
      }
    }
  }

  Future loadUserData(String documentId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection('users').doc(documentId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        // userModel = data.obs;
        userModel.value = UserModel.fromJson(data);
        print(userModel.toJson().toString());
      } else {
        // Document does not exist, create it with default values
        final defaultData = UserModel();
        await firestore
            .collection('users')
            .doc(documentId)
            .set(defaultData.toJson());
      }
    } catch (error) {
      print(error.toString());
      Get.snackbar('Error', 'Failed to load user data');
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      final path = 'user_images/${DateTime.now().millisecondsSinceEpoch}.png';
      final uploadTask = _storage.ref().child(path).putFile(image);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      return '';
    }
  }

  Future<void> updateUserSpecificData(
      String userId, Map<String, dynamic> newData) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(userId).update(newData);
    } catch (e) {
      print('Error updating user data: $e');
    }
  }

  loadRecordFromCard() async {
    try {
      if (frontImage.value != null && backImage.value != null) {
        Get.dialog(const LoadingDialog());
        CnicModel cnicModel = await CnicScanner().scanCnic(
            imageToScan: InputImage.fromFilePath(frontImage.value!.path));
        nameController.text = cnicModel.cnicHolderName ?? "";
        dobController.text = cnicModel.cnicHolderDateOfBirth ?? "";
        cnicController.text = cnicModel.cnicNumber ?? "";
        String frontSide = await uploadImage(frontImage.value!);
        await updateUserSpecificData(firebaseAuth.currentUser!.uid,
            {AppConstants.CNICFrontSide: frontSide});
        String backSide = await uploadImage(frontImage.value!);
        await updateUserSpecificData(firebaseAuth.currentUser!.uid,
            {AppConstants.CNICBackSide: backSide});
        await loadUserData(firebaseAuth.currentUser!.uid);
        closeDialog();
        Get.to(UserProfileView());
      } else {
        DefaultSnackbar.show('Title',"Please Enter Cnic Images First");
      }
    } catch (e) {
      closeDialog();
      print(e.toString());
    }
  }

  pickAndSetImage(bool isFront) async {
    String? path = await pickImage(picker);
    if (path != null && path.isNotEmpty) {
      if (isFront) {
        frontImage.value = File(path);
      } else {
        backImage.value = File(path);
      }
    }
  }

  Future<void> saveForm() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      Get.dialog(const LoadingDialog());
      await updateUserSpecificData(firebaseAuth.currentUser!.uid, {
        AppConstants.Name: nameController.text,
        AppConstants.CNIC: cnicController.text,
        AppConstants.DOB: dobController.text,
        AppConstants.Address: addressController.text,
        AppConstants.City: cityController.text
      });
      await loadUserData(firebaseAuth.currentUser!.uid);
      closeDialog();
      //TODO: add navigation
      onLoginSuccesfull();
    } else {
      print('Validation failed');
    }
  }

  Future<void> saveLicenseForm() async {
    if (licenseFormKey.currentState?.validate() ?? false) {
      licenseFormKey.currentState?.save();
      if (licensePicture.value == null) {
        DefaultSnackbar.show('Error', "Please Select license picture");
        return;
      }

      Get.dialog(const LoadingDialog());

      String? licensePic = await uploadImage(File(licensePicture.value!.path));

      List<License> licenses = [];

      licenses = userModel.value.license ?? [];

      licenses.add(License.fromJson({
        AppConstants.licenseTrackingNumber: trackingNumberController.text,
        AppConstants.licenseNumber: licenseNumberController.text,
        AppConstants.licenseAmmunitionLimit: ammunitionLimitController.text,
        AppConstants.licenseCalibre: caliber.value,
        AppConstants.licenseIssuingAuthority: issuingAuthority.value,
        AppConstants.licenseValidTill: validTillController.text,
        AppConstants.licenseIssuaingQuota: issuaingQuota.value,
        AppConstants.licenseDateOfIssuance: dateOfIssuanceController.text,
        AppConstants.licenseJurisdiction: jurisdiction.value,
        AppConstants.licensePicture: licensePic
      }));

      await updateUserSpecificData(firebaseAuth.currentUser!.uid, {
        AppConstants.license:
            licenses.map((license) => license.toMap()).toList(),
      });
      await loadUserData(firebaseAuth.currentUser!.uid);
      if (Get.isDialogOpen!) {
        Get.back();
      }
      onLoginSuccesfull();
    } else {
      print('Validation failed');
    }
  }

  Future<void> saveWeaponDetail() async {
    if (weaponFormKey.currentState?.validate() ?? false) {
      Get.back();
      Get.dialog(const LoadingDialog());
      Map<String, dynamic> weaponDetailValue = {
        AppConstants.weaponCaliber: weaponCaliber.value,
        AppConstants.weaponType: weaponTypeController.text,
        AppConstants.weaponNo: weaponNumberController.text,
        AppConstants.weaponMake: weaponMake.value,
        AppConstants.weaponModel: weaponModel.value,
      };
      var licenses = userModel.value.license ?? [];
      if (selectedLicenseIndex.value >= 0 &&
          selectedLicenseIndex.value < licenses.length) {
        licenses[selectedLicenseIndex.value].weaponDetails =
            WeaponDetails.fromJson(weaponDetailValue);
        await updateUserSpecificData(firebaseAuth.currentUser!.uid, {
          AppConstants.license:
              licenses.map((license) => license.toMap()).toList(),
        });
        await loadUserData(firebaseAuth.currentUser!.uid);
        userModel.refresh();
        if (Get.isDialogOpen!) {
          Get.back();
        }
      } else {
        log("Invalid license index or licenses are null");
      }
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
      log("Form validation failed");
    }
  }

  signOut() {
    firebaseAuth.signOut();
    GoogleSignIn().signOut();
    Get.offAll(const SplashView());
    isUserLogged();
  }
}
