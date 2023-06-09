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
    apiKey: 'AIzaSyCg-m_8xTFrmUWoLpvSpZI0uKEU9p4I-LY',
    appId: '1:1003470910941:web:63ec68bb2a8153522e7234',
    messagingSenderId: '1003470910941',
    projectId: 'role-auth-vitgdsc',
    authDomain: 'role-auth-vitgdsc.firebaseapp.com',
    storageBucket: 'role-auth-vitgdsc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCC_RZWI-CuIRTxmwGWMYPI5Odo1MUFTJU',
    appId: '1:1003470910941:android:dc5d2f46b3d9ce862e7234',
    messagingSenderId: '1003470910941',
    projectId: 'role-auth-vitgdsc',
    storageBucket: 'role-auth-vitgdsc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtC4mSJ98G5v7Rx71aWtbgQ0o4bc5587k',
    appId: '1:1003470910941:ios:53314a09d9efb9232e7234',
    messagingSenderId: '1003470910941',
    projectId: 'role-auth-vitgdsc',
    storageBucket: 'role-auth-vitgdsc.appspot.com',
    iosClientId: '1003470910941-lg38cccip7kl2a9mlthpe4m5bkrtqsoa.apps.googleusercontent.com',
    iosBundleId: 'me.chandramdutta.roleAuth',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDtC4mSJ98G5v7Rx71aWtbgQ0o4bc5587k',
    appId: '1:1003470910941:ios:53314a09d9efb9232e7234',
    messagingSenderId: '1003470910941',
    projectId: 'role-auth-vitgdsc',
    storageBucket: 'role-auth-vitgdsc.appspot.com',
    iosClientId: '1003470910941-lg38cccip7kl2a9mlthpe4m5bkrtqsoa.apps.googleusercontent.com',
    iosBundleId: 'me.chandramdutta.roleAuth',
  );
}
