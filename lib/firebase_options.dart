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

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyBUHEHV7EtXHezDywFNGqiS8ggYbB4bMEs",
      authDomain: "vitamedd.firebaseapp.com",
      databaseURL: "https://vitamedd-default-rtdb.firebaseio.com",
      projectId: "vitamedd",
      storageBucket: "vitamedd.appspot.com",
      messagingSenderId: "356117566040",
      appId: "1:356117566040:web:0504ade43eb6ec2286f02d"
  
      );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC19RnkX29STGxH0Ub310X-BQlht31yPSE',
    appId: '1:356117566040:android:662b78536db8640486f02d',
    messagingSenderId: '356117566040',
    projectId: 'vitamedd',
    storageBucket: 'vitamedd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYEiVkTZ67nz9v5VY-qCpUcGohmZEPseo',
    appId: '1:356117566040:ios:91c6d55c2a80a3ac86f02d',
    messagingSenderId: '356117566040',
    projectId: 'vitamedd',
    storageBucket: 'vitamedd.appspot.com',
    iosBundleId: 'com.example.vitamed',
  );
}
