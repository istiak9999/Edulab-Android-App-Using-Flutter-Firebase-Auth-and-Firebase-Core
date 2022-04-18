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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA1uJxJ4uiza6q5OnFEc8_Ih289ilsgCl8',
    appId: '1:141652131858:web:68cc73fdc60f41408718cb',
    messagingSenderId: '141652131858',
    projectId: 'edulab-b84ef',
    authDomain: 'edulab-b84ef.firebaseapp.com',
    storageBucket: 'edulab-b84ef.appspot.com',
    measurementId: 'G-0Q41D87JNE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCWUZuM_B-pdVs_XGcFVuMbDTD3CplXg3Y',
    appId: '1:141652131858:android:9065ef9a3348ccca8718cb',
    messagingSenderId: '141652131858',
    projectId: 'edulab-b84ef',
    storageBucket: 'edulab-b84ef.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCi6UU3eakyEpL_r6FIhp-fSfFB34tTJXk',
    appId: '1:141652131858:ios:53dbe919f265cced8718cb',
    messagingSenderId: '141652131858',
    projectId: 'edulab-b84ef',
    storageBucket: 'edulab-b84ef.appspot.com',
    iosClientId: '141652131858-j4qkvf97ebdtr8e0r7v3m00snn1fidrn.apps.googleusercontent.com',
    iosBundleId: 'i',
  );
}
