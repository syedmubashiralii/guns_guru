import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/views/auth/splash_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/auth/add_user_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  SplashView(),
      binding: HomeBinding(),
    ),
  ];
}
