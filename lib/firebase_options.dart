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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCSWNkdnlu1oDMlv_oDjFlT0uuNxGVkriQ',
    appId: '1:230449477840:web:1906e85200a8360b6646d5',
    messagingSenderId: '230449477840',
    projectId: 'andamantour-app-d7115',
    authDomain: 'andamantour-app-d7115.firebaseapp.com',
    storageBucket: 'andamantour-app-d7115.appspot.com',
    measurementId: 'G-5KRP6L4DBW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8nQHXxPitaIH5377k6kOL_xBgiagwjg0',
    appId: '1:230449477840:android:a4ca849ec0aea7f76646d5',
    messagingSenderId: '230449477840',
    projectId: 'andamantour-app-d7115',
    storageBucket: 'andamantour-app-d7115.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAf6JlG_7HhKU_qWf6ke5IxL4B0ObY4XRo',
    appId: '1:230449477840:ios:9c02218bf2b5527d6646d5',
    messagingSenderId: '230449477840',
    projectId: 'andamantour-app-d7115',
    storageBucket: 'andamantour-app-d7115.appspot.com',
    iosClientId: '230449477840-npqu7i6t6rdevhiplj5or45r4u0ut0s9.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluttertest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAf6JlG_7HhKU_qWf6ke5IxL4B0ObY4XRo',
    appId: '1:230449477840:ios:18168b3d3a7c0b5c6646d5',
    messagingSenderId: '230449477840',
    projectId: 'andamantour-app-d7115',
    storageBucket: 'andamantour-app-d7115.appspot.com',
    iosClientId: '230449477840-lbnsl0v3l56n2ka54rjpctrh5jp8ea2r.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluttertest.RunnerTests',
  );
}
