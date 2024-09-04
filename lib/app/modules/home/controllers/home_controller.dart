import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guns_guru/app/modules/home/models/user_model.dart';
import 'package:guns_guru/app/modules/home/views/auth/auth_view.dart';
import 'package:guns_guru/app/modules/home/views/home/home_view.dart';
import 'package:guns_guru/app/modules/home/views/license/license_list_view.dart';
import 'package:guns_guru/app/modules/home/views/auth/splash_view.dart';
import 'package:guns_guru/app/modules/home/views/auth/add_user_profile_view.dart';
import 'package:guns_guru/app/utils/app_constants.dart';
import 'package:guns_guru/app/utils/default_snackbar.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:guns_guru/app/utils/helper_functions.dart';
import 'package:guns_guru/app/utils/widgets/source_selection_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class HomeController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final licenseFormKey = GlobalKey<FormState>();
  // final weaponFormKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ImagePicker picker = ImagePicker();
  final firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Rx<File?> frontImage = Rx<File?>(null);
  Rx<File?> backImage = Rx<File?>(null);

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController documentExpiryDate = TextEditingController();
  TextEditingController documentIssuanceDate = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  RxString selectedCountryCode = "PK".obs;
  RxString selectedGender = "MALE".obs;
  RxString selectedState = "".obs;
  TextEditingController phoneNoTextEditingController = TextEditingController();

  //weapon fields

  RxBool isPhoneNumberValid = false.obs;

  //
  // RxMap<String, dynamic>? userModel;
  Rx<UserModel> userModel = UserModel().obs;

  RxBool fromFiringRecordDetail = false.obs;
  RxBool fromServiceDetail = false.obs;

  @override
  void onReady() {
    super.onReady();
    isUserLogged();
  }

  Future<bool> isUserLogged() async {
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
    // if (userModel.value.cnicFrontSide != null &&
    //     userModel.value.cnicFrontSide!.isNotEmpty) {
    if (userModel.value.firstname != null &&
        userModel.value.firstname!.isNotEmpty) {
      // if (userModel.value.license != null &&
      //     userModel.value.license!.isNotEmpty) {
      Get.off(const HomeView());
      // } else {
      // Get.off(AddLicenseView());
      // }
    } else {
      Get.off(AddUserProfileView());
    }
    // } else {
    //   Get.off(IDCardScreen());
    // }
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
        DefaultSnackbar.show("Error", e.toString());
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
        DefaultSnackbar.show('Error', e.toString());
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

  // loadRecordFromCard() async {
  //   try {
  //     if (frontImage.value != null && backImage.value != null) {
  //       Get.dialog(const LoadingDialog());
  //       CnicModel cnicModel = await CnicScanner().scanCnic(
  //           imageToScan: InputImage.fromFilePath(frontImage.value!.path));
  //       firstNameController.text = cnicModel.cnicHolderName;
  //       dobController.text = cnicModel.cnicHolderDateOfBirth;
  //       cnicController.text = cnicModel.cnicNumber;
  //       String frontSide = await uploadImage(frontImage.value!);
  //       await updateUserSpecificData(firebaseAuth.currentUser!.uid,
  //           {AppConstants.CNICFrontSide: frontSide});
  //       String backSide = await uploadImage(frontImage.value!);
  //       await updateUserSpecificData(firebaseAuth.currentUser!.uid,
  //           {AppConstants.CNICBackSide: backSide});
  //       await loadUserData(firebaseAuth.currentUser!.uid);
  //       closeDialog();
  //       Get.to(AddUserProfileView());
  //     } else {
  //       DefaultSnackbar.show('Title', "Please Enter Cnic Images First");
  //     }
  //   } catch (e) {
  //     closeDialog();
  //     print(e.toString());
  //   }
  // }

  pickAndSetImage(bool isFront) async {
    String source = '';
    await showChoiceDialog(onCameraTap: () {
      source = "Camera";
      Get.back();
    }, onGalleryTap: () {
      source = "Gallery";
      Get.back();
    });
    if (source != '') {
      String? path = await pickImage(picker, source);
      if (path != null && path.isNotEmpty) {
        if (isFront) {
          frontImage.value = File(path);
        } else {
          backImage.value = File(path);
        }
      }
    }
  }

  Future<void> saveForm() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      Get.dialog(const LoadingDialog());
      await updateUserSpecificData(firebaseAuth.currentUser!.uid, {
        AppConstants.FirstName: firstNameController.text,
        AppConstants.LastName: lastNameController.text,
        AppConstants.CNIC: cnicController.text,
        AppConstants.DOB: dobController.text,
        AppConstants.PhoneNo: phoneNoTextEditingController.text,
        AppConstants.Address: addressController.text,
        AppConstants.City: cityController.text,
        AppConstants.CountryCode: selectedCountryCode.value,
        AppConstants.Gender: selectedGender.value,
        AppConstants.UID: FirebaseAuth.instance.currentUser?.uid ?? "",
        AppConstants.Email: FirebaseAuth.instance.currentUser?.email ?? "",
        AppConstants.documentIssuanceDate: documentIssuanceDate.text,
        AppConstants.documentExpiryDate: documentExpiryDate.text,
        AppConstants.Country: selectedCountryCode.value == "CA"
            ? "Canada"
            : selectedCountryCode.value == "US"
                ? "United States"
                : "",
        AppConstants.state: selectedState.value
      });
      await loadUserData(firebaseAuth.currentUser!.uid);
      closeDialog();
      onLoginSuccesfull();
    } else {
      print('Validation failed');
    }
  }

  // Future<void> saveLicenseForm(bool fromEdit) async {
  //   if (licenseFormKey.currentState?.validate() ?? false) {
  //     licenseFormKey.currentState?.save();
  //     if (licensePictures.isEmpty) {
  //       DefaultSnackbar.show(
  //           'Error', "Please Select at least one license picture");
  //       return;
  //     }

  //     Get.dialog(const LoadingDialog());

  //     // Upload each picture and get their URLs
  //     List<String> licensePicUrls = [];
  //     for (File picture in licensePictures) {
  //       String? picUrl = await uploadImage(picture);
  //       if (picUrl != null) {
  //         licensePicUrls.add(picUrl);
  //       }
  //     }

  //     List<License> licenses = userModel.value.license ?? [];
  //     License license = License.fromJson({
  //       AppConstants.licenseTrackingNumber: trackingNumberController.text,
  //       AppConstants.licenseNumber: licenseNumberController.text,
  //       AppConstants.licenseAmmunitionLimit: ammunitionLimitController.text,
  //       AppConstants.weaponType: licenseWeaponType.value,
  //       AppConstants.licenseIssuingAuthority: issuingAuthority.value,
  //       AppConstants.licenseValidTill: validTillController.text,
  //       AppConstants.licenseIssuaingQuota: issuaingQuota.value,
  //       AppConstants.licenseDateOfIssuance: dateOfIssuanceController.text,
  //       AppConstants.licenseJurisdiction: jurisdiction.value,
  //       AppConstants.licensePicture:
  //           licensePicUrls, // Store list of picture URLs
  //       AppConstants.licenseValidated: false,
  //       AppConstants.DocumentType: documentTypeController.text,
  //       AppConstants.Country: selectedCountry.value
  //     });

  //     if (fromEdit == true) {
  //       licenses[selectedLicenseIndex.value] = license;
  //     } else {
  //       licenses.add(license);
  //     }

  //     await updateUserSpecificData(firebaseAuth.currentUser!.uid, {
  //       AppConstants.license:
  //           licenses.map((license) => license.toMap()).toList(),
  //     });
  //     await loadUserData(firebaseAuth.currentUser!.uid);
  //     if (Get.isDialogOpen!) {
  //       Get.back();
  //     }
  //     onLoginSuccesfull();
  //   } else {
  //     if (kDebugMode) {
  //       print('Validation failed');
  //     }
  //   }
  // }

  // Future<void> saveWeaponDetail() async {
  //   if (weaponFormKey.currentState?.validate() ?? false) {
  //     if (!isValidPhoneNumber(authorizeDealerPhoneNo.text)) {
  //       DefaultSnackbar.show("Error",
  //           "Please enter a valid phone number containing only digits");
  //       return;
  //     }
  //     Get.back();
  //     Get.dialog(const LoadingDialog());

  //     String? weaponReceipt = weaponPurchaseReceipt.value == null
  //         ? ''
  //         : await uploadImage(File(weaponPurchaseReceipt.value!.path));
  //     Map<String, dynamic> weaponDetailValue = {
  //       AppConstants.weaponCaliber: weaponCaliber.value,
  //       AppConstants.weaponType: weaponType.value,
  //       AppConstants.weaponAuthorizeDealerName: authorizeDealerName.text,
  //       AppConstants.weaponAuthorizeDealerAddress: authorizeDealerAddress.text,
  //       AppConstants.weaponAuthorizeDealerPhoneNumber:
  //           authorizeDealerPhoneNo.text,
  //       AppConstants.weaponNo: weaponNumberController.text,
  //       AppConstants.weaponPurchaseRecipt: weaponReceipt,
  //       AppConstants.weaponPurchaseDate: weaponPurchaseDate.text,
  //       AppConstants.weaponMake: weaponMake.value,
  //       AppConstants.weaponModel: weaponModel.value,
  //     };
  //     var licenses = userModel.value.license ?? [];
  //     if (selectedLicenseIndex.value >= 0 &&
  //         selectedLicenseIndex.value < licenses.length) {
  //       licenses[selectedLicenseIndex.value].weaponDetails =
  //           WeaponDetails.fromJson(weaponDetailValue);
  //       await updateUserSpecificData(firebaseAuth.currentUser!.uid, {
  //         AppConstants.license:
  //             licenses.map((license) => license.toMap()).toList(),
  //       });
  //       await loadUserData(firebaseAuth.currentUser!.uid);
  //       userModel.refresh();
  //       if (Get.isDialogOpen!) {
  //         Get.back();
  //       }
  //     } else {
  //       log("Invalid license index or licenses are null");
  //     }
  //   } else {
  //     if (Get.isDialogOpen!) {
  //       Get.back();
  //     }
  //     log("Form validation failed");
  //   }
  // }

  signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    userModel.value = UserModel();
    Get.offAll(const SplashView());
    isUserLogged();
  }
}
