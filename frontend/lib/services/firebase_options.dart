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
    apiKey: 'AIzaSyAMFylssGHrPUTqesCBCWhn-XtzD6Mxrkw',
    appId: '1:168429018697:web:c386126bc141e6b1fa6998',
    messagingSenderId: '168429018697',
    projectId: 'maqderah-65012',
    authDomain: 'maqderah-65012.firebaseapp.com',
    storageBucket: 'maqderah-65012.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXSLM0qM3PDTFhIEput2sWCf3xZryTWcc',
    appId: '1:168429018697:android:1905308a148b39bafa6998',
    messagingSenderId: '168429018697',
    projectId: 'maqderah-65012',
    storageBucket: 'maqderah-65012.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqmlFiDacg2838Zs9X4601NIO30dNDZ1I',
    appId: '1:168429018697:ios:95ee6c1beb8ab8c6fa6998',
    messagingSenderId: '168429018697',
    projectId: 'maqderah-65012',
    storageBucket: 'maqderah-65012.appspot.com',
    iosBundleId: 'com.example.maqderah',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBqmlFiDacg2838Zs9X4601NIO30dNDZ1I',
    appId: '1:168429018697:ios:95ee6c1beb8ab8c6fa6998',
    messagingSenderId: '168429018697',
    projectId: 'maqderah-65012',
    storageBucket: 'maqderah-65012.appspot.com',
    iosBundleId: 'com.example.maqderah',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAMFylssGHrPUTqesCBCWhn-XtzD6Mxrkw',
    appId: '1:168429018697:web:5fb390b7505f3ebafa6998',
    messagingSenderId: '168429018697',
    projectId: 'maqderah-65012',
    authDomain: 'maqderah-65012.firebaseapp.com',
    storageBucket: 'maqderah-65012.appspot.com',
  );

}