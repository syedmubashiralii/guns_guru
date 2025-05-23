// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAemr949re4chKKzUKfz3yG6Hod9_mOBKQ',
    appId: '1:340919836801:android:437e7c8c239b6fb9682d80',
    messagingSenderId: '340919836801',
    projectId: 'guns-guru',
    storageBucket: 'guns-guru.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBma4Pku_pKcd4wMLQM22U0KOO78Clo8k4',
    appId: '1:340919836801:ios:01f33c92c8a0a217682d80',
    messagingSenderId: '340919836801',
    projectId: 'guns-guru',
    storageBucket: 'guns-guru.appspot.com',
    androidClientId: '340919836801-15g9mq3u964jqaerjtdm74pgg5d6osbd.apps.googleusercontent.com',
    iosClientId: '340919836801-p5pupm73kgbmcusq026t2b1tt8ntn26t.apps.googleusercontent.com',
    iosBundleId: 'com.khastech.gunsguru',
  );
}
