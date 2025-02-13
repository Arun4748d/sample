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
    apiKey: 'AIzaSyAtCJ5rfzq2NHWJaVUJ7r8Pjm4Y6omczAA',
    appId: '1:1063311470471:web:ec36c23e6e75754d132d22',
    messagingSenderId: '1063311470471',
    projectId: 'chattingapp-c759a',
    authDomain: 'chattingapp-c759a.firebaseapp.com',
    storageBucket: 'chattingapp-c759a.firebasestorage.app',
    measurementId: 'G-618RMVB7NS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaYA0MBataUsAlGB_n6Q3NSsPrktIXNUk',
    appId: '1:1063311470471:android:7c3572fe47559506132d22',
    messagingSenderId: '1063311470471',
    projectId: 'chattingapp-c759a',
    storageBucket: 'chattingapp-c759a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDn47738UOl0stcZHKOl9M3YzKtg4CTB9U',
    appId: '1:1063311470471:ios:6d3c2d5f241abb34132d22',
    messagingSenderId: '1063311470471',
    projectId: 'chattingapp-c759a',
    storageBucket: 'chattingapp-c759a.firebasestorage.app',
    iosBundleId: 'com.example.sample',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDn47738UOl0stcZHKOl9M3YzKtg4CTB9U',
    appId: '1:1063311470471:ios:6d3c2d5f241abb34132d22',
    messagingSenderId: '1063311470471',
    projectId: 'chattingapp-c759a',
    storageBucket: 'chattingapp-c759a.firebasestorage.app',
    iosBundleId: 'com.example.sample',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAtCJ5rfzq2NHWJaVUJ7r8Pjm4Y6omczAA',
    appId: '1:1063311470471:web:08e0934035182f07132d22',
    messagingSenderId: '1063311470471',
    projectId: 'chattingapp-c759a',
    authDomain: 'chattingapp-c759a.firebaseapp.com',
    storageBucket: 'chattingapp-c759a.firebasestorage.app',
    measurementId: 'G-KN66TVFQ8M',
  );

}