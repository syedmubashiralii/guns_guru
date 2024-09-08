import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guns_guru/app/modules/home/controllers/home_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/home_extension_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/license_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/service_record_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/shooting_log_controller.dart';
import 'package:guns_guru/app/modules/home/controllers/weapon_controller.dart';
import 'package:guns_guru/app/routes/app_pages.dart';
import 'package:guns_guru/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const fatalError = true;
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };

  
  runApp(
    GetMaterialApp(
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.black),
          buttonTheme:
              const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          brightness: Brightness.light,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        defaultTransition: Transition.cupertino,
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
        getPages: AppPages.routes),
  );
}
