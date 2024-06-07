// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyApa7gXxMEkT7jg6E9cdnHoN5-LULzE0KU',
    appId: '1:294684488033:web:4ce94862a83dc552319520',
    messagingSenderId: '294684488033',
    projectId: 'task0-55a93',
    authDomain: 'task0-55a93.firebaseapp.com',
    storageBucket: 'task0-55a93.appspot.com',
    measurementId: 'G-N0P0P5GWDD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTUHs1Vizj8_iiIGPr9HYViYe8a5iZAQ4',
    appId: '1:294684488033:android:3c3d3c9f43d98634319520',
    messagingSenderId: '294684488033',
    projectId: 'task0-55a93',
    storageBucket: 'task0-55a93.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDPwT1V_-QYMe1A2qRknWgnazHWwUsBISU',
    appId: '1:294684488033:ios:3245330fb76df6b1319520',
    messagingSenderId: '294684488033',
    projectId: 'task0-55a93',
    storageBucket: 'task0-55a93.appspot.com',
    iosBundleId: 'com.example.task00',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDPwT1V_-QYMe1A2qRknWgnazHWwUsBISU',
    appId: '1:294684488033:ios:3245330fb76df6b1319520',
    messagingSenderId: '294684488033',
    projectId: 'task0-55a93',
    storageBucket: 'task0-55a93.appspot.com',
    iosBundleId: 'com.example.task00',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyApa7gXxMEkT7jg6E9cdnHoN5-LULzE0KU',
    appId: '1:294684488033:web:6c755862f14975d1319520',
    messagingSenderId: '294684488033',
    projectId: 'task0-55a93',
    authDomain: 'task0-55a93.firebaseapp.com',
    storageBucket: 'task0-55a93.appspot.com',
    measurementId: 'G-GH660BR2DG',
  );
}
