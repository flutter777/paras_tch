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
    apiKey: 'AIzaSyDm3HuvJvjyRAQos3IM-jaMqhhxw-L1RQ8',
    appId: '1:578370622162:web:797bcf6e8173d3ee2c130b',
    messagingSenderId: '578370622162',
    projectId: 'login-6e163',
    authDomain: 'login-6e163.firebaseapp.com',
    storageBucket: 'login-6e163.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAVynJ-K-4JMOfnQoMoDoY9x009mkBhX4I',
    appId: '1:578370622162:android:27d81b1b22aaa0222c130b',
    messagingSenderId: '578370622162',
    projectId: 'login-6e163',
    storageBucket: 'login-6e163.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBcdKzF5bf7fMmnbHIgY6vKKRxrBs8v9Rc',
    appId: '1:578370622162:ios:023ea169f25c19842c130b',
    messagingSenderId: '578370622162',
    projectId: 'login-6e163',
    storageBucket: 'login-6e163.appspot.com',
    iosBundleId: 'com.example.parasTechTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBcdKzF5bf7fMmnbHIgY6vKKRxrBs8v9Rc',
    appId: '1:578370622162:ios:77609ed1de6b5a3a2c130b',
    messagingSenderId: '578370622162',
    projectId: 'login-6e163',
    storageBucket: 'login-6e163.appspot.com',
    iosBundleId: 'com.example.parasTechTest.RunnerTests',
  );
}
