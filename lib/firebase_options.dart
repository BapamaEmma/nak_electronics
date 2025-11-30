// Firebase configuration for Nak Electronics
// Generated from Firebase Console

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
          'DefaultFirebaseOptions have not been configured for macOS - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDQSlWh3o-8Zk9Uv4Pmc2XAPfF0NuVm-R8',
    appId: '1:241667554232:web:c9dae3c267cc5129f4ad4d',
    messagingSenderId: '241667554232',
    projectId: 'nak-electronics',
    authDomain: 'nak-electronics.firebaseapp.com',
    storageBucket: 'nak-electronics.firebasestorage.app',
    measurementId: 'G-XPBETN9860',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQSlWh3o-8Zk9Uv4Pmc2XAPfF0NuVm-R8',
    appId:
        '1:241667554232:android:your-android-app-id', // TODO: Replace with Android app ID
    messagingSenderId: '241667554232',
    projectId: 'nak-electronics',
    storageBucket: 'nak-electronics.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQSlWh3o-8Zk9Uv4Pmc2XAPfF0NuVm-R8',
    appId:
        '1:241667554232:ios:your-ios-app-id', // TODO: Replace with iOS app ID
    messagingSenderId: '241667554232',
    projectId: 'nak-electronics',
    storageBucket: 'nak-electronics.firebasestorage.app',
  );
}
