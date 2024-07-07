import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/auth_view.dart';
import 'package:guns_guru/app/modules/home/views/home_view.dart';

class HomeController extends GetxController {


  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    isUserLogged();
  }

  Future<bool> isUserLogged() async {
    User? firebaseUser =  getLoggedFirebaseUser();
    if (firebaseUser != null) {
      Get.off(AuthView());
      return true;
    } else {
      Get.off(HomeView());
        return false;
    }
}

User? getLoggedFirebaseUser() {
    return firebaseAuth.currentUser;
}

}
