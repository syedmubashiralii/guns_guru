import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/routes/app_pages.dart';
import 'package:guns_guru/firebase_options.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialize();

  Get.put(HomeController(),permanent: true);
  runApp(
    GetMaterialApp(
        builder: (BuildContext context, Widget? child) {
          final MediaQueryData data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(
              textScaler:
                  TextScaler.linear(data.textScaleFactor > 1.1 ? 1.1 : 1.0),
            ),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        title: "Guns Guru",
        initialRoute: AppPages.INITIAL,
        // theme: ThemeData(fontFamily: "SFProDisplay"),
        getPages: AppPages.routes),
  );
}
