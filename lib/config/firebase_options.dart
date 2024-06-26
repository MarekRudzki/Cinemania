// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members

// Package imports:
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
    apiKey: 'AIzaSyAlWO8P2Nb00tlK4dz_bZy_Q9Lk1hFvoh8',
    appId: '1:127068649620:android:dcf8de2af22ebd458a5c81',
    messagingSenderId: '127068649620',
    projectId: 'cinemania-e7a17',
    storageBucket: 'cinemania-e7a17.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBmEwdEMWC5IwrGJijAX8YnFZtrkXTN_5I',
    appId: '1:127068649620:ios:a54fbc04ec58cd038a5c81',
    messagingSenderId: '127068649620',
    projectId: 'cinemania-e7a17',
    storageBucket: 'cinemania-e7a17.appspot.com',
    androidClientId: '127068649620-23rrd75586mtoe6mcivr6f4tlvlp57ff.apps.googleusercontent.com',
    iosClientId: '127068649620-pg5qjcleqr7caql1n5eujh8l7d56diuq.apps.googleusercontent.com',
    iosBundleId: 'com.marekrudzki.cinemania',
  );
}
